# My suckless Neovim configuration

## Dependencies

- `tree-sitter`
- `gcc` -- to compile tree-sitter grammars
- `nix` -- lsp servers are automatically downloaded through nix-shell using `dundalek/lazy-lsp.nvim`
- A programmer, since it doesn't write code by itself.

## Features

- All the main options and functions are available through `which-key.nvim`,
  which pops up whenever you press the space key.
- It uses a space-centric keymapping, so <space> is the leader key for almost
  everything as you may expect.
- Telescope fuzzy finder
- Treesitter
- Automatic LSP support through Nix (because I use NixOS and `mason.nvim` is
  kinda messy in non-imperative systems)
- Auto-completion
- Git signs
- Fully-customisable statusline
- A simple toggleable terminal window
- Folding that just werks
- That's it. All I need.

## Install

1. Download Neovim `>= v0.9.1`

2. Clone this repo into `~/.config/nvim` or wherever you save your
   configuration

3. Open Neovim. Lazy will setup everything.

4. Just code and write. No need to install any LSP servers by yourself

5. If you need to add any additional lua configuration, just add a `.lua` file
   inside `/user/lua` and it will be loaded automatically

## License

Released under the MIT License unless otherwise specified by license files in
subfolders.
