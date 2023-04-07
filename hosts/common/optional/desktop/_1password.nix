{pkgs, ...}: {
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["azmo"];
    # package = pkgs._1password-gui-beta;
  };
}
