# Pending review
{
  lib,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.disko.nixosModules.default
    ]
    ++ (lib.utils.scanPaths ./.)
    ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    overlays = with outputs.overlays; [
      additions
      modifications
      unstable-packages
    ];
  };

  users.mutableUsers = false;
  console.earlySetup = true;
  hardware.enableAllFirmware = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo = {
      enable = true;
      execWheelOnly = true;
      extraRules = [
        {
          commands = [
            {
              command = "ALL";
              options = ["NOPASSWD"];
            }
          ];
          groups = ["wheel"];
        }
      ];
    };
  };

  boot.initrd.systemd.enable = true;
  boot.loader.timeout = 2;
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
    configurationLimit = 12;
    editor = false;
  };

  console.font = "Lat2-Terminus16";

  # Define default XDG variables system-wide
  environment.sessionVariables = {
    XDG_BIN_HOME = "$HOME/.local/bin";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.local/cache";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  environment.localBinInPath = true;
  boot.tmp.cleanOnBoot = true;
}
