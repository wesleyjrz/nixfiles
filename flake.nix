# Pending review
{
  description = "Wesley Jr's NixOS + home-manager config flake.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    agenix.url = "github:ryantm/agenix";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    cosmic-nightly = {
      url = "github:busyboredom/cosmic-nightly-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    stylix,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;

    lib = nixpkgs.lib.extend (final: prev: (import ./lib final) // home-manager.lib);

    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});

    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    inherit lib;

    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home-manager;

    overlays = import ./overlays {inherit inputs outputs;};

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});

    nixosConfigurations = {
      leviathan = lib.nixosSystem {
        modules = [./hosts/leviathan];
        specialArgs = {inherit inputs outputs;};
      };

      hydra = lib.nixosSystem {
        modules = [./hosts/hydra];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "wesleyjrz@leviathan" = lib.homeManagerConfiguration {
        modules = [./home/leviathan.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };

      "wesleyjrz@hydra" = lib.homeManagerConfiguration {
        modules = [./home/hydra.nix];
        pkgs = pkgsFor.aarch64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
