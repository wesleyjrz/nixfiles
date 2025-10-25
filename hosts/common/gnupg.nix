{pkgs, ...}: rec {
  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };
  };
  environment.systemPackages = [programs.gnupg.agent.pinentryPackage];
  environment.sessionVariables.GNUPGHOME = "$HOME/.local/share/gnupg";
}
