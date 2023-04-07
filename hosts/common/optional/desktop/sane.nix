{pkgs, ...}: {
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan pkgs.hplipWithPlugin];
    openFirewall = true;
  };
}
