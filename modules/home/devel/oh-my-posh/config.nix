{
  programs.oh-my-posh = {
    settings = {
      "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
      blocks = [
        {
          type = "prompt";
          alignment = "left";
          segments = [
            {
              type = "session";
              style = "plain";
              template = "┍─[<#ffff55>{{ .UserName }}</><#ff5555>@</><#55ff55>{{ .HostName }}</>]─";
            }
            {
              type = "path";
              style = "plain";
              foreground = "#ff5555";
              template = "<#ffffff>[</>{{ .Path }}<#ffffff>]</>";
            }
            {
              type = "root";
              style = "plain";
              foreground = "#FF9248";
              template = "<#ffffff>─(</>#<#ffffff>)</>";
            }
          ];
        }

        {
          type = "prompt";
          alignment = "right";
          segments = [
            {
              type = "node";
              style = "plain";
              foreground = "#3C873A";
              properties = {
                fetch_package_manager = true;
                npm_icon = " <#cc3a3a></> ";
                yarn_icon = " <#348cba>/>";
              };
              template = "<#ffffff>(</>{{ if .PackageManagerIcon }}{{ .PackageManagerIcon }} {{ end }}{{ .Full }}<#ffffff>)</>";
            }
            {
              type = "python";
              style = "plain";
              foreground = "#FFE873";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "java";
              style = "plain";
              foreground = "#ec2729";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "dotnet";
              style = "plain";
              foreground = "#0d6da8";
              template = "<#ffffff>(</>{{ if .Unsupported }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "go";
              style = "plain";
              foreground = "#06aad5";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "rust";
              style = "plain";
              foreground = "#925837";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "dart";
              style = "plain";
              foreground = "#055b9c";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "angular";
              style = "plain";
              foreground = "#ce092f";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "aurelia";
              style = "plain";
              foreground = "#de1f84";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "nx";
              style = "plain";
              foreground = "#ffffff";
              template = "<#1e293b>(</>{{ if .Error }}{{ .Error }}{{ else }}Nx {{ .Full }}{{ end }}<#1e293b>)</>";
            }
            {
              type = "julia";
              style = "plain";
              foreground = "#359a25";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "ruby";
              style = "plain";
              foreground = "#9c1006";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "azfunc";
              style = "plain";
              foreground = "#5398c2";
              template = "<#ffffff>(</>{{ if .Error }}{{ .Error }}{{ else }}{{ .Full }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "aws";
              style = "plain";
              foreground = "#faa029";
              template = "<#ffffff>(</>{{ .Profile }}{{ if .Region }}@{{ .Region }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "kubectl";
              style = "plain";
              foreground = "#316ce4";
              template = "<#ffffff>(</>{{ .Context }}{{ if .Namespace }} :: {{ .Namespace }}{{ end }}<#ffffff>)</>";
            }
            {
              type = "os";
              style = "plain";
              foreground = "#ffffff";
              properties = {
                linux = "<#ffffff></>";
                macos = "<#ffffff>\\ue27f</>";
                windows = "<#ffffff></>";
              };
              template = "<#ffffff>(</>{{ if .WSL }}WSL at {{ end }}{{ .Icon }}<#ffffff>)─</>";
            }
            {
              type = "text";
              style = "plain";
              foreground = "#a3e635";
              template = "{{ if or .Env.CONDA_DEFAULT_ENV .Env.MAMBA_DEFAULT_ENV }}<#ffffff>(</>{{ if .Env.CONDA_DEFAULT_ENV }}conda{{ else }}mamba{{ end }}: {{ if .Env.CONDA_DEFAULT_ENV }}{{ .Env.CONDA_DEFAULT_ENV }}{{ else }}{{ .Env.MAMBA_DEFAULT_ENV }}{{ end }}<#ffffff>)</>{{ end }}";
            }
            {
              type = "text";
              style = "plain";
              foreground = "#a3e635";
              template = "{{ if or .Env.UV_ACTIVE .Env.UV_PROJECT_ENVIRONMENT .Env.UV_PYTHON .Env.VIRTUAL_ENV }}<#ffffff>(</>{{ if or .Env.UV_ACTIVE .Env.UV_PROJECT_ENVIRONMENT .Env.UV_PYTHON }}uv{{ else }}venv{{ end }}{{ if .Env.VIRTUAL_ENV }}: {{ .Env.VIRTUAL_ENV | base }}{{ end }}<#ffffff>)</>{{ end }}";
            }
            {
              type = "text";
              style = "plain";
              foreground = "#a3e635";
              template = "{{ if .Env.DIRENV_DIR }}<#ffffff>(</>direnv: {{ .Env.DIRENV_DIR | base }}<#ffffff>)</>{{ end }}";
            }
            {
              type = "executiontime";
              style = "plain";
              foreground = "#93c5fd";
              properties = {threshold = 200;};
              template = "<#ffffff>(</>⏱ {{ .FormattedMs }}<#ffffff>)</>";
            }
          ];
        }

        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "text";
              style = "plain";
              template = "┗─";
            }
            {
              type = "git";
              style = "plain";
              foreground = "#e0f8ff";
              properties = {
                branch_icon = " ";
                fetch_status = true;
                fetch_upstream_icon = true;
              };
              template = "<#ffffff>[</>{{ .HEAD }}{{ if .Staging.Changed }}<#00AA00> ● {{ .Staging.String }}</>{{ end }}{{ if .Working.Changed }}<#D75F00> ● {{ .Working.String }}</>{{ end }}<#ffffff>]-</>";
            }
            {
              type = "status";
              style = "plain";
              foreground = "#ecf7fa";
              foreground_templates = ["{{ if gt .Code 0 }}#ef5350{{ end }}"];
              properties = {always_enabled = true;};
              template = " ";
            }
          ];
        }
      ];
      version = 3;
    };
  };
}
