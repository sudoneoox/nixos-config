{
  programs.fish.interactiveShellInit = ''
    # Syntax highlighting palette
    set -g fish_color_command blue
    set -g fish_color_param cyan
    set -g fish_color_quote yellow
    set -g fish_color_redirection cyan --bold
    set -g fish_color_end green
    set -g fish_color_error brred
    set -g fish_color_operator brcyan
    set -g fish_color_escape brcyan
    set -g fish_color_autosuggestion brblack
    set -g fish_color_search_match white --background=brblack
    set -g fish_color_selection white --bold --background=brblack
    set -g fish_color_valid_path --underline
    set -g fish_color_user brgreen
    set -g fish_color_host normal
    set -g fish_color_status red
  '';
}
