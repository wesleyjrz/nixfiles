{
  config,
  pkgs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  age.secrets.wesleyjrz-password.file = ../../secrets/wesleyjrz-password.age;

  nix.settings = {
    allowed-users = ["root" "@wheel"];
    trusted-users = ["root" "@wheel"];
  };

  users.users.root.hashedPassword = "$6$vjKpiiUaCdnXNwLn$PXhb10jyqnLYenyhVR1zZ4PplVPQHgEZDNGcbssdPeZayNIT0DlrlTs8iBvbGig2n4CKsW4XO0eproQcahKEC1";
  # users.users.root.hashedPasswordFile = config.age.secrets.wesleyjrz-password.path;
  users.users.wesleyjrz = {
    isNormalUser = true;
    hashedPassword = "$6$vjKpiiUaCdnXNwLn$PXhb10jyqnLYenyhVR1zZ4PplVPQHgEZDNGcbssdPeZayNIT0DlrlTs8iBvbGig2n4CKsW4XO0eproQcahKEC1";
    # hashedPasswordFile = config.age.secrets.wesleyjrz-password.path;
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
