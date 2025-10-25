# Pending review
{config, ...}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  age.secrets.wesleyjrz-password.file = ../../secrets/wesleyjrz-password.age;

  nix.settings = {
    allowed-users = ["root" "@wheel"];
    trusted-users = ["root" "@wheel"];
  };

  users.users.root.hashedPasswordFile = config.age.secrets.wesleyjrz-password.path;
  users.users.wesleyjrz = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.wesleyjrz-password.path;
    extraGroups =
      [
        "wheel"
        "audio"
        "video"
      ]
      ++ ifTheyExist [
        "network"
        "docker"
        "kvm"
        "mysql"
        "git"
        "libvirtd"
        "adbusers"
        "openrazer"
        "gamemode"
      ];
  };
}
