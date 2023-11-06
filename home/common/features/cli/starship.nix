{pkgs, ...}:
# let
#   nix-inspect = pkgs.writeShellScriptBin "nix-inspect" ''
#     read -ra EXCLUDED <<< "$@"
#
#     IFS=":" read -ra PATHS <<< "$PATH"
#
#     read -ra PROGRAMS <<< \
#       "$(printf "%s\n" "''${PATHS[@]}" | ${pkgs.gnugrep}/bin/grep "\/nix\/store" | ${pkgs.gnugrep}/bin/grep -v "\-man" | ${pkgs.perl}/bin/perl -pe 's/^\/nix\/store\/\w{32}-([^\/]*)\/bin$/\1/' | ${pkgs.findutils}/bin/xargs)"
#
#     for to_remove in "''${EXCLUDED[@]}"; do
#         to_remove_full="$(printf "%s\n" "''${PROGRAMS[@]}" | grep "$to_remove" )"
#         PROGRAMS=("''${PROGRAMS[@]/$to_remove_full}")
#     done
#
#     read -ra PROGRAMS <<< "''${PROGRAMS[@]}"
#     echo "''${PROGRAMS[@]}"
#   '';
# in {
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      # format = let
      #   git = "$git_branch$git_commit$git_state$git_status";
      #   cloud = "$aws$gcloud$openstack";
      # in ''
      #   $username$hostname($shlvl)($cmd_duration) $fill ($nix_shell)$custom
      #   $directory(${git})(- ${cloud}) $fill $time
      #   $jobs$character
      # '';
      #
      fill = {
        symbol = " ";
        disabled = false;
      };

      # Core
      username = {
        format = "[$user]($style)";
        style_root = "#ed8796";
        style_user = "#f4dbd6";
        show_always = true;
      };
      hostname = {
        format = "[@$hostname]($style) in ";
        style = "#8aadf4";
        ssh_only = false;
        ssh_symbol = "󰣀 ";
      };
      shlvl = {
        threshold = 2;
        repeat = false;
        disabled = false;
      };
      cmd_duration = {
        format = "🕙 [$duration]($style) ";
        show_notifications = true;
        min_time_to_notify = 180000;
        disabled = false;
      };
      git_branch = {
        disabled = false;
      };
      git_status = {
        disabled = false;
      };
      git_metrics = {
        disabled = false;
      };
      git_commit = {
        disabled = false;
        tag_disabled = false;
        only_detached = false;
      };
      directory = {
        truncation_symbol = "…/";
        truncation_length = 3;
        fish_style_pwd_dir_length = 1;
      };
      nix_shell = {
        disabled = false;
        impure_msg = "";
      };
      docker_context = {
        disabled = false;
      };
      os = {
        disabled = false;
      };
      status = {
        disabled = false;
        map_symbol = false;
        symbol = " ";
      };
      time = {
        disabled = true;
      };

      # Cloud
      gcloud = {
        disabled = false;
      };
      aws = {
        disabled = false;
      };
      # custom = {
      #   nix_inspect = {
      #     disabled = false;
      #     when = "test -z $IN_NIX_SHELL";
      #     command = "${nix-inspect}/bin/nix-inspect kitty imagemagick ncurses";
      #     format = "[($output <- )$symbol]($style) ";
      #     symbol = " ";
      #     style = "bold blue";
      #   };
      # };

      character = {
        error_symbol = "[~~>](bold red) ";
        success_symbol = "[->>](bold green) ";
        vimcmd_symbol = "[<<-](bold yellow) ";
        vimcmd_visual_symbol = "[<<-](bold cyan) ";
        vimcmd_replace_symbol = "[<<-](bold purple) ";
        vimcmd_replace_one_symbol = "[<<-](bold purple) ";
      };

      # Icon changes only \/
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      directory.read_only = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      gcloud.symbol = " ";
      git_branch.symbol = " ";
      golang.symbol = " ";
      hg_branch.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      memory_usage.symbol = " ";
      nim.symbol = " ";
      nix_shell.symbol = " ";
      nodejs.symbol = " ";
      package.symbol = " ";
      perl.symbol = " ";
      php.symbol = " ";
      python.symbol = " ";
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      shlvl.symbol = " ";
      swift.symbol = "ﯣ ";
      terraform.symbol = "󱁢 ";
    };
  };
}
