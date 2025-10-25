let
  hosts = [];

  wesleyjrz = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILbJWuY5bCPGvWYi7E8lpifluIBRaz37mpsoE7R/7Wf7 dev@wesleyjrz.com";
  users = [wesleyjrz];
in {
  "wesleyjrz-password.age".publicKeys = hosts ++ users;

  "monero-address.age".publicKeys = hosts ++ users;

  "hydra-wireguard-key.age".publicKeys = hosts ++ users;
  "leviathan-wireguard-key.age".publicKeys = hosts ++ users;

  "firefly.age".publicKeys = hosts ++ users;
  "minecraft-rcon-password.age".publicKeys = hosts ++ users;
}
