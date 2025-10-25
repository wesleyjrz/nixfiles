# Pending review
{pkgs, ...}: {
  programs.git = {
    enable = true;
    settings = {
      user.email = "dev@wesleyjrz.com";
      user.name = "Wesley Jr.";
      user.signingKey = "7F7096C5";
      core = {
        editor = "nvim";
        pager = "bat";
      };
      init.defaultBranch = "main";
      commit.gpgSign = true;
      color.pager = "no";
      alias = {
        patch = "add --patch";
        amend = "commit --amend";
        st = "status --short";
        cm = "commit --message";
      };
    };
    ignores = [
      "*~" # backup files
      "result" # nix build directory
      "build" # default build directory
      ".ccls-cache" # ccls cache
      ".cache/clangd" # clangd cache
      ".direnv"
    ];
    lfs.enable = true;
  };

  programs.gh.enable = true;

  home.packages = [pkgs.github-copilot-cli];
  home.persistence."/nix/persist".directories = [
    ".config/gh"
    ".config/github-copilot"
  ];
}
