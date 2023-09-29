{pkgs, ...}: {
  sops.secrets.wg-home = {
    sopsFile = ../secrets.yaml;
    path = "/etc/NetworkManager/system-connections/wg-home.nmconnection";
    mode = "0600";
    owner = "root";
    group = "root";
    restartUnits = ["NetworkManager.service"];
  };
  environment.systemPackages = with pkgs; [wireguard-tools];
}
