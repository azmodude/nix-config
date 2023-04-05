{pkgs, ...}: {
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  # disable pulseaudio, but...
  hardware.pulseaudio.enable = false;
  # ... pull in cli utils
  environment.systemPackages = with pkgs; [pulseaudio easyeffects];
}
