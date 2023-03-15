{lib, ...}: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_DE.utf8";
      LC_IDENTIFICATION = "en_DE.utf8";
      LC_MEASUREMENT = "en_DE.utf8";
      LC_MONETARY = "en_DE.utf8";
      LC_NAME = "en_DE.utf8";
      LC_NUMERIC = "en_DE.utf8";
      LC_PAPER = "en_DE.utf8";
      LC_TELEPHONE = "en_DE.utf8";
      LC_TIME = "en_DE.utf8";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "Europe/Berlin";
}
