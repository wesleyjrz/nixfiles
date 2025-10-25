# Pending review
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [inputs.stylix.homeModules.stylix]
    ++ (builtins.attrValues outputs.homeModules);

  programs.home-manager.enable = true;

  home = rec {
    username = "wesleyjrz";
    homeDirectory = "/home/${username}";
    sessionPath = ["${homeDirectory}/.local/bin"];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
