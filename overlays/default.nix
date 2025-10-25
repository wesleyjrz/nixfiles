# Pending review
{inputs, ...}: {
  # Bring our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # papermc = prev.papermc.overrideAttrs (oldAttrs: rec {
    #   version = "1.21.1.125";
    #   src =
    #     let
    #       mcVersion = prev.lib.versions.pad 3 version;
    #       buildNum = builtins.elemAt (prev.lib.splitVersion version) 3;
    #     in
    #     prev.fetchurl {
    #       url = "https://papermc.io/api/v2/projects/paper/versions/${mcVersion}/builds/${buildNum}/downloads/paper-${mcVersion}-${buildNum}.jar";
    #       hash = "sha256-7dWV3EEAHwk5Bp/r9eTMlxQaqZbqWWvYIYVEMcp2THA=";
    #     };
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
