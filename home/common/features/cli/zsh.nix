{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".zsh";
    syntaxHighlighting = {
      enable = true;
    };
    enableVteIntegration = true;
    autosuggestion = {
      enable = true;
    };
    enableCompletion = true;
    autocd = true;
    dirHashes = {
      docs = config.home.homeDirectory + "/Documents";
      dl = config.home.homeDirectory + "/Downloads";
      vids = config.home.homeDirectory + "/Videos";
      projects = config.home.homeDirectory + "/projects";
    };
    #defaultKeymap = "viins"; # handled by zsh-vi-mode
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "rsync"
        "sudo"
      ];
    };
    prezto = {
      enable = false;
      editor = {
        dotExpansion = true;
        promptContext = true;
      };
      syntaxHighlighting.highlighters = [
        "main"
        "brackets"
        "pattern"
        "line"
        # "cursor" # cursor highlighter breaks zsh-vi-mode cursor styles
        "root"
      ];
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "syntax-highlighting"
        "autosuggestions"
        "history"
        "directory"
        "spectrum"
        "utility"
        "archive"
        "git"
        "docker"
        "rsync"
        "completion"
        # "prompt" # handled by starship
      ];
      utility.safeOps = true;
    };
    zplug = {
      enable = false;
      plugins = [
        {
          name = "hlissner/zsh-autopair";
          tags = [defer:2];
        }
        {name = "zsh-users/zsh-completions";}
        {name = "mdumitru/fancy-ctrl-z";}
      ];
    };
    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        "mattmc3/zephyr path:plugins/completion"
        "mattmc3/zephyr path:plugins/color"
        "mattmc3/zephyr path:plugins/homebrew"
        "mattmc3/zephyr path:plugins/utility"
        "mattmc3/zephyr path:plugins/zfunctions"
        # zsh specific
        "ohmyzsh/ohmyzsh path:plugins/sudo"

        # utility specific
        "bigH/git-fuzzy path:bin kind:path"

        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/1password"
        "ohmyzsh/ohmyzsh path:plugins/direnv"
        "ohmyzsh/ohmyzsh path:plugins/github"
        "ohmyzsh/ohmyzsh path:plugins/git-auto-fetch"
        "ohmyzsh/ohmyzsh path:plugins/git-escape-magic"
        "ohmyzsh/ohmyzsh path:plugins/git-extras"
        "ohmyzsh/ohmyzsh path:plugins/git-flow-avh"
        "ohmyzsh/ohmyzsh path:plugins/git-lfs"
        "ohmyzsh/ohmyzsh path:plugins/gnu-utils"
        "ohmyzsh/ohmyzsh path:plugins/extract"
        "ohmyzsh/ohmyzsh path:plugins/rsync"
        "ohmyzsh/ohmyzsh path:plugins/taskwarrior"
        "ohmyzsh/ohmyzsh path:plugins/ripgrep kind:fpath"
        "ohmyzsh/ohmyzsh path:plugins/vscode"
        "ohmyzsh/ohmyzsh path:plugins/vagrant"
        "ohmyzsh/ohmyzsh path:plugins/universalarchive"
        "ohmyzsh/ohmyzsh path:plugins/transfer"
        # development
        "ohmyzsh/ohmyzsh path:plugins/python"
        "ohmyzsh/ohmyzsh path:plugins/pyenv"
        "ohmyzsh/ohmyzsh path:plugins/pip"
        "ohmyzsh/ohmyzsh path:plugins/pylint"
        "ohmyzsh/ohmyzsh path:plugins/systemd"
        "ohmyzsh/ohmyzsh path:plugins/ansible"
        "ohmyzsh/ohmyzsh path:plugins/golang"
        "ohmyzsh/ohmyzsh path:plugins/npm"
        "ohmyzsh/ohmyzsh path:plugins/gh kind:fpath"
        # k8s
        "ohmyzsh/ohmyzsh path:plugins/helm"
        "ohmyzsh/ohmyzsh path:plugins/kubectl"
        "ohmyzsh/ohmyzsh path:plugins/istioctl"

        # misc stuff
        "mdumitru/fancy-ctrl-z"
        "zsh-users/zsh-completions"
        "zdharma-continuum/fast-syntax-highlighting"
        "hlissner/zsh-autopair"
      ];
    };
    localVariables = {
      # fire up ZVM initializing directly after sourcing, prevents stomping over other plugins' (like atuin) keybindings
      ZVM_INIT_MODE = "sourcing";
    };

    initExtraFirst = ''
    '';

    initExtra = ''
      # this is kind-of-hacky, but for now it works until a vivid module lands in hm
      export LS_COLORS="$(${pkgs.vivid}/bin/vivid generate catppuccin-macchiato)"
      ZVM_VI_INSERT_ESCAPE_BINDKEY="jk"
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      ZVM_INSERT_MODE_CURSOR="$ZVM_CURSOR_BLINKING_BEAM"
      ZVM_NORMAL_MODE_CURSOR="$ZVM_CURSOR_BLOCK"
    '';

    loginExtra = ''
      # Set SSH_AUTH_SOCK to use 1Password as SSH Agent when not ssh'd in remotely.
      [ -z $SSH_TTY ] && export SSH_AUTH_SOCK=~/.1password/agent.sock
    '';

    shellAliases = {
      man = "${pkgs.bat-extras.batman}/bin/batman";
      cp = "cp -i --reflink=auto --sparse=auto";
      mv = "mv -i";
      rm = "rm -i";
      nrun = "NIXPKGS_ALLOW_UNFREE=1 nix run --impure";
      nsh = "nix shell";
    };
    shellGlobalAliases = {
    };
  };
}
