{
  pkgs,
  lib,
  ...
}: {
  services.printing = {
    enable = true;
    startWhenNeeded = true;
    drivers = with pkgs; [hplip cups-filters];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  hardware = let
    hp = "HP_Officejet_8730_Postscript";
    hpHostName = "officejet8730.fritz.box";
  in {
    printers = {
      # for color to monochrome conversion to work, use:
      # lpadmin -p HP_Officejet_8730_Postscript -o pdftops-renderer-default=gs
      # (and probably turn off HPPJLColorAsGray option)
      ensureDefaultPrinter = hp;
      ensurePrinters = [
        {
          name = hp;
          deviceUri = "socket://${hpHostName}:9100";
          # deviceUri = "ipp://${hpHostName}/ipp/print";
          model = "HP/hp-officejet_pro_8730-ps.ppd.gz";
          description = lib.replaceStrings ["_"] [" "] hp;
          location = "Home Office";
          ppdOptions = {
            PageSize = "A4";
            Collate = "true";
            MediaType = "Plain";
            HPPJLColorAsGray = "yes";
          };
        }
      ];
    };
  };
}
