{user, ...}: {
  programs.thunderbird = {
    enable = true;
    profiles = {
      azmo-default = {
        isDefault = true;
      };
    };
  };
  home = {
    persistence = {
      "/persist/home/${user.name}" = {
        directories = [
          ".thunderbird"
        ];
      };
    };
  };
}
