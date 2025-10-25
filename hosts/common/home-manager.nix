# Pending review
{
  inputs,
  outputs,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [pkgs.home-manager];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
    backupFileExtension = "~";
    verbose = true;
    users.wesleyjrz = import ./../../home/${config.networking.hostName}.nix;
    sharedModules = [
      {
        imports = [./../../home];
        home.stateVersion = config.system.stateVersion;
      }
    ];
  };
}
