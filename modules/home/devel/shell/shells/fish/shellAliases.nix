{
  custom,
  lib,
  ...
}: let
  x = custom.x0;
  currentSemester = "2025Fall";
in {
  programs.fish.shellAliases = {
    mamba = lib.mkIf (x.derived.isArch) "micromamba";
    school = "cd /media/resilio/truenas/sync/PROBE/LEARN/SCHOOL/${currentSemester}";
    publicip = "wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1";
    diffs = "diff --side-by-side --suppress-common-lines";
    ccat = "pygmentize -g";
    home-manager-arch = "nix run home-manager/master --";
    home-manager-arch-switch = "nix run home-manager/master -- switch -b backup --flake";
    ls = "lsd";

    # push input flakes to cachix repo
    cachix-push-inputs = "cd ${x.nixosConfPath} && nix flake archive --json | jq -r '.path,(.inputs|to_entries[].value.path)' | nix run cachix push nixossudnox";
    cachix-push-outputs = "cd ${x.nixosConfPath} && nix build github:srid/devour-flake -L --no-link --print-out-paths --override-input flake . | nix run cachix push nixossudnox";

    clip = "kitten clipboard";
    # create backups to external hd
    syncall = "rsync -aAXHv --exclude='/dev/*' --exclude='/proc/*' --exclude='/sys/*' --exclude='/tmp/*' --exclude='/run/*' --exclude='/mnt/*' --exclude='/media/*' --exclude='/lost+found/' --exclude='/home/$USER/disks/*' / ";
    compress = "tar -cJf folder.tar.xz";
    decompress = "tar -xJf";
    nv = "nvim";
    zen = "zen-twilight";
    ":q" = "exit";
    #  * Create missing directories in path when calling `mkdir`
    mkdir = "mkdir -pv";
    #  * `cp` to ask when overwriting files
    cp = "cp -i";
    #  * `mv` to ask when overwriting files
    mv = "mv -i";
    #  * Human readable sizes for `df`, `du`, `free` (i.e. Mb, Gb etc)
    df = "df -h";
    du = "du -ch";
    free = "free -m";
    #  * `sizeof` command to show size of file or directory
    sizeof = "du -hs";
    #  * `wget` to save file with provided name
    wget = "wget --content-disposition";
  };
}
