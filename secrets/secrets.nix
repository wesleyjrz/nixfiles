let
  leviathan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEyLMWvg6FLhBRlDzfFfjGJ9GK2ce1WcyZbMa7DsTDi2";
  # hydra = "";
  hosts = [leviathan];
in {
  "wesleyjrz-password.age".publicKeys = hosts;
  # "minecraft-server-rcon-password.age".publicKeys = [hydra];
}
