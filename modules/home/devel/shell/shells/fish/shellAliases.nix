{X0, ...}: {
  programs.fish.shellAliases = {
    publicip = "wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1";
    diffs = "diff --side-by-side --suppress-common-lines";
    ccat = "pygmentize -g";

    # push input flakes to cachix repo
    cachix-push-inputs = "cd ${X0.NIXOS_CONF_PATH} && nix flake archive --json | jq -r '.path,(.inputs|to_entries[].value.path)' | cachix push nixossudnox";
    cachix-push-outputs = "cd ${X0.NIXOS_CONF_PATH} && nix build github:srid/devour-flake -L --no-link --print-out-paths --override-input flake . | cachix push nixossudnox";

    clip = "kitten clipboard";
    # create backups to external hd
    syncall = "rsync -aAXHv --exclude='/dev/*' --exclude='/proc/*' --exclude='/sys/*' --exclude='/tmp/*' --exclude='/run/*' --exclude='/mnt/*' --exclude='/media/*' --exclude='/lost+found/' --exclude='/home/$USER/disks/*' / ";
    compress = "tar -cJf folder.tar.xz";
    decompress = "tar -xJf";
    nv = "nvim";
    zen = "zen-browser-twilight";
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
