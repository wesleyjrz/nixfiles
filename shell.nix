# Shell for bootstrapping flake-enabled nix and home-manager
{pkgs ? (import ./nixpkgs.nix) {}}: {
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      git
      nix
      home-manager
      nh
      just
      disko
      age
      alejandra
    ];
    shellHook = ''
      echo " Wesley Jr's NixOS + home-manager config flake."
    '';
  };
}
