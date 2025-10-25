# Shell for bootstrapping in flake-enabled nix and home-manager
# Can be used with both `nix develop` or `nix-shell`
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      nix
      home-manager
      nh
      disko
      just
      age
      alejandra
    ];
    shellHook = ''
      echo " Wesley Jr's NixOS + home-manager config flake."
    '';
  };
}
