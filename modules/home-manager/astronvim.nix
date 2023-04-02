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
    rev = "a101473";
    sha256 = "sha256-2ucmAbr7ek7FooJtWkTw+Gdxjjd2t1xczQKL/Hoz/48=";
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
