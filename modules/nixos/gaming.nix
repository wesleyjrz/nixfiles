# Pending review
{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.gaming;
in {
  options = {
    extra.gaming = {
      # NOTE: mangohud is declared in home configuration.
      enable = lib.mkEnableOption "Enable gaming tools like gamemode and mangohud.";

      steam = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Steam.";
      };

      emulators = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable video game emulators.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable 32bit support
    hardware.graphics.enable32Bit = true;
    services.pulseaudio.support32Bit = config.services.pulseaudio.enable;
    services.pipewire.alsa.support32Bit = config.services.pipewire.alsa.enable;

    programs.gamemode = {
      enable = true;

      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };

        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
        };
      };
    };

    environment.systemPackages = with pkgs;
      [steamtinkerlaunch adwsteamgtk protontricks heroic mangohud]
      ++ lib.optionals cfg.emulators [
        (retroarch.withCores (cores:
          with cores; [
            mgba # GB, GBC, GBA
            fceumm # NES
            snes9x # SNES
            genesis-plus-gx # SEGA MS/GG/MD/CD
            mupen64plus # Nintendo 64
            desmume # Nintendo DS
            dolphin # GameCube, Wii
            ppsspp # PSP
            pcsx-rearmed # PlayStation
            pcsx2 # PlayStation 2
          ]))
        prismlauncher # Minecraft launcher
        ryubing # Nintendo Switch
      ];

    programs.steam = {
      enable = cfg.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    hardware.steam-hardware.enable = cfg.steam;

    home-manager.sharedModules =
      lib.optional cfg.steam
      {
        home.persistence."/nix/persist".directories = [
          # Steam
          ".steam"
          ".local/share/Steam"

          # Heroic
          ".config/heroic"
          ".local/share/Heroic"

          # Minecraft
          ".local/share/PrismLauncher"

          # Retroarch
          ".config/retroarch"
          ".local/share/retroarch"
          ".config/PCSX2"

          # Ryujinx
          ".config/Ryujinx"
          ".local/share/ryujinx"

          # Others
          ".local/share/unity3d"
          ".local/share/aspyr-media"
          ".local/share/Terraria"
          ".local/share/StardewValley"
          "Zomboid"
        ];
      };
  };
}
