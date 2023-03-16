{lib, ...}: {
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = true;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
