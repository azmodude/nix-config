{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      # astronvim
      ripgrep
      gcc
      fzf
      python3
      gdu
      bottom
      tree-sitter
      # docker
      nodePackages.dockerfile-language-server-nodejs
      hadolint
      # shell
      shellcheck
      shfmt
      nodePackages.bash-language-server
      # lua
      luajitPackages.luacheck
      lua-language-server
      stylua
      selene
      # markdown
      marksman
      markdownlint-cli
      # javascript
      nodejs
      yarn
      # yaml
      yaml-language-server
    ];
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";

  systemd.user.services = {
    neovim-clone = {
      Unit = {
        Description = "Clone neovim/lazyvim config from GitHub";
        ConditionPathExists = "!${config.xdg.configHome}/nvim";
        Wants = "network-online.target";
        After = "network-online.target";
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.git}/bin/git clone https://github.com/azmodude/lazyvim ${config.xdg.configHome}/nvim";
      };
    };
  };
  systemd.user.services = {
    neovim-update = {
      Unit = {
        Description = "Update neovim/lazyvim config from GitHub";
        ConditionPathExists = "${config.xdg.configHome}/nvim";
        Wants = "network-online.target";
        After = "network-online.target";
      };
      Install = {
        WantedBy = ["default.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.git}/bin/git -C ${config.xdg.configHome}/nvim pull";
      };
    };
  };

  xdg.configFile = {
    nvim = {
      enable = false;
      source = pkgs.fetchFromGitHub {
        owner = "azmodude";
        repo = "lazyvim";
        rev = "65c9f5500a6f8b04cc4d397528d8e552bf35c931";
        sha256 = "10w5xh2g09xa3sphcpz0fs5y503341jvgj1k8km0q5xvicq5ffgw";
      };
      # make files symbolic links to have .config/nvim writable by lazyvim
      recursive = true;
    };
  };

  programs.astronvim = {
    enable = false;
    userConfig = pkgs.fetchFromGitHub {
      owner = "azmodude";
      repo = "astronvim";
      rev = "caca9a4d5a9a1cb471a333553678bab49c9991a2";
      sha256 = "0si3qymp02pgq47y1bi72aaz2nfqsnd5aybkhpg8gljk5m9gnncn";
    };
  };
}
