# source: https://gist.github.com/archite/a42683880e99560e0a573a1876b8e965
{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.astronvim;
  astronvim = pkgs.fetchFromGitHub {
    owner = "AstroNvim";
    repo = "AstroNvim";
    rev = "00c4abb95bf83ff1f00f411b65faa1b098d9a9d6";
    sha256 = "0q4g556qghb6rwfnby9gah4qn6dq0sk0f5nai7xmgs9lsiddmm4f";
  };
in {
  options.programs.astronvim = {
    enable = mkOption {
      default = false;
      description = "Enable AstronVim";
      type = types.bool;
    };

    userConfig = mkOption {
      default = null;
      description = "AstronVim User Config";
      type = with types; nullOr path;
    };
  };
  config = mkIf (cfg.enable) {
    home = {
      file = {
        ".config/nvim" = {
          recursive = true;
          source = astronvim;
        };
        ".config/nvim/lua/user" = mkIf (cfg.userConfig != null) {
          recursive = true;
          source = cfg.userConfig;
        };
      };
    };
  };
}
