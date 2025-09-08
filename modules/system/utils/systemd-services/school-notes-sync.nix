{
  pkgs,
  custom,
  lib,
  ...
}: let
  x = custom.x0;

  notesPath = "${x.derived.homeDir}/Projects/${x.currentSchoolSemester}";
  notesRepoUrl = x.repos.schoolNotes;
  #INFO: Frequency to rerun
  TIMER = "20min";
in {
  config = lib.mkIf (x.currentSchoolSemester != "" && notesRepoUrl != "") {
    # -------- One-shot sync service (user, not root) --------
    systemd.services.school-notes-sync = {
      description = "Sync School Notes Repo";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      wants = ["network-online.target"];

      # IMPORTANT: run as the real user (no root privileges)
      serviceConfig = {
        Type = "oneshot";
        User = x.identity.username;
        Environment = [
          "HOME=${x.derived.homeDir}"
          "NOTES_REPO_URL=${notesRepoUrl}"
          "GIT_SSH_COMMAND=${pkgs.openssh}/bin/ssh -oBatchMode=yes -oStrictHostKeyChecking=yes"
        ];
      };

      path = [
        pkgs.git
        pkgs.coreutils
        pkgs.gnused
        pkgs.openssh
      ];

      script = ''
        set -euo pipefail

        if [ -z "''${NOTES_REPO_URL:-}" ]; then
          echo "ERROR: NOTES_REPO_URL is not set (custom.x0.repos.schoolNotes)."
          exit 1
        fi

        # Ensure notes directory exists (as the user)
        mkdir -p "${notesPath}"

        if [ -d "${notesPath}/.git" ]; then
          # Keep origin URL up to date & fetch
          git -C "${notesPath}" remote set-url origin "$NOTES_REPO_URL" || true
          git -C "${notesPath}" fetch --all --prune
        else
          # First-time clone
          git clone --depth=1 "$NOTES_REPO_URL" "${notesPath}"
        fi

        # Stage & commit local changes if any
        if ! git -C "${notesPath}" diff --quiet || ! git -C "${notesPath}" diff --cached --quiet; then
          git -C "${notesPath}" add -A
          # If there are no staged changes (race), commit will fail; ignore
          git -C "${notesPath}" commit -m "chore: update" || true
        fi

        # Figure out sync state vs upstream
        # Ensure we have an upstream (set to origin/HEAD branch if missing)
        if ! git -C "${notesPath}" rev-parse --abbrev-ref @{u} >/dev/null 2>&1; then
          default_branch="$(
            git -C "${notesPath}" remote show origin 2>/dev/null \
            | sed -n 's/.*HEAD branch: //p'
          )"
          [ -z "$default_branch" ] && default_branch="main"
          git -C "${notesPath}" branch --set-upstream-to="origin/''${default_branch}" || true
        fi

        # Recompute status after possibly setting upstream
        if git -C "${notesPath}" rev-parse @{u} >/dev/null 2>&1; then
          current="$(git -C "${notesPath}" rev-parse @)"
          upstream="$(git -C "${notesPath}" rev-parse @{u})"
          base="$(git -C "${notesPath}" merge-base @ @{u})"

          if [ "$current" = "$upstream" ]; then
            # Up to date
            :
          elif [ "$current" = "$base" ]; then
            # Local behind -> fast-forward
            git -C "${notesPath}" pull --ff-only
          elif [ "$upstream" = "$base" ]; then
            # Local ahead -> push
            git -C "${notesPath}" push
          else
            # Diverged -> try rebase, then push
            git -C "${notesPath}" pull --rebase || true
            git -C "${notesPath}" push || true
          fi
        else
          # No upstream (bare origin?) just attempt a pull fast-forward
          git -C "${notesPath}" pull --ff-only || true
        fi
      '';
    };

    # -------- Timer to run periodically (and after boot) --------
    systemd.timers.school-notes-sync = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "2min";
        OnUnitActiveSec = "${TIMER}";
        Unit = "school-notes-sync.service";
      };
    };
  };
}
