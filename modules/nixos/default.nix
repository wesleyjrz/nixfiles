# Pending review
{
  bottles = import ./bottles.nix;
  containers = import ./containers.nix;
  fcitx5 = import ./fcitx5.nix;
  flatpack = import ./flatpak.nix;
  gaming = import ./gaming.nix;
  it87-sensors = import ./it87-sensors.nix;
  nginx = import ./nginx.nix;
  nvidia = import ./nvidia.nix;
  ollama = import ./ollama.nix;
  openrgb = import ./openrgb.nix;
  piper = import ./piper.nix;
  pipewire = import ./pipewire.nix;
  plymouth = import ./plymouth.nix;
  searx = import ./searx.nix;
  sunshine = import ./sunshine.nix;
  tailscale = import ./tailscale.nix;
  via = import ./via.nix;
  virt-manager = import ./virt-manager.nix;
  waydroid = import ./waydroid.nix;
  wayland = import ./wayland.nix;
  wg-quick = import ./wg-quick.nix;
  zenpower-drivers = import ./zenpower-drivers.nix;
}
