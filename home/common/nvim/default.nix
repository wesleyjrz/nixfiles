# Pending review
{
  config,
  pkgs,
  ...
}: {
  imports = [./theme.nix];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = true;
    withNodeJs = true;
    withRuby = false;
    extraPackages = with pkgs; [
      tree-sitter
      gcc
      lua5_1
      lua51Packages.luarocks
      python3
      python311Packages.pynvim

      # Required by `markdown.nvim`
      python311Packages.pylatexenc

      # Telescope
      ripgrep
      fd
    ];
  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };

  home.persistence."/nix/persist" = {
    directories = [
      ".local/share/nvim"
      ".local/state/nvim"
    ];
    files = [".config/nvim/lazy-lock.json"];
  };
}
