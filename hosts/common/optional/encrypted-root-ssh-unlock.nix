{
boot.initrd = {
  network = {
    enable = true;
    ssh = {
      enable = true;
      port = 22;
      authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAFOj2KxBYTb6MclwoN4xgKN7OgX4Iwv4lViluKPdL9K" ];
      hostKeys = [ "/persist/etc/ssh/ssh_host_ed25519_key" "/persist/etc/ssh/ssh_host_rsa_key" ];
    };
  };
  availableKernelModules = [ "igc" ];
};
}
