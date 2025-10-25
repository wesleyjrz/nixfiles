# Pending review
{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: let
  cfg = config.extra.wayland;
in {
  options = {
    extra.wayland = {
      enable = lib.mkEnableOption "Enable Wayland protocol.";

      cosmic = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable Cosmic Epoch Desktop Environment.";
      };

      enableGnomeKeyring = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable GNOME Keyring.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      inputs.cosmic-nightly.overlays.default
    ];

    environment.systemPackages = with pkgs;
      [
        wl-clipboard
        wlr-randr
      ]
      ++ lib.optionals cfg.cosmic [
        eog
        cosmic-reader
        cosmic-ext-calculator
        cosmic-ext-tweaks
        cosmic-ext-ctl
      ];

    # Local sharing software
    programs.localsend.enable = true;

    services.desktopManager.cosmic.enable = cfg.cosmic;

    services.displayManager = {
      cosmic-greeter.enable = cfg.cosmic;
      autoLogin = {
        enable = true;
        user = "wesleyjrz";
      };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-cosmic
      ];
    };

    security.pam.services.cosmic-greeter.enableGnomeKeyring = cfg.enableGnomeKeyring;
    services.gnome.gnome-keyring.enable = cfg.enableGnomeKeyring;
    programs.seahorse.enable = cfg.enableGnomeKeyring;

    environment.sessionVariables = {
      SDL_VIDEODRIVER = "wayland,x11";
      EGL_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      NIXOS_OZONE_WL = "1";
      COSMIC_DATA_CONTROL_ENABLED = "1";
    };

    home-manager.sharedModules =
      lib.optional (cfg.cosmic)
      {
        home.persistence."/nix/persist".directories = [
          ".config/cosmic"
          ".local/state/cosmic"
          ".local/state/cosmic-comp"
          ".local/cache/cosmic-settings"
          ".local/share/themes/cosmic"
          ".config/autostart"
          ".local/share/dev.edfloreshz.CosmicTweaks"
          ".local/share/org.localsend.localsend_app"
          ".local/share/keyrings"
        ];
      };
  };
}
