{
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
      "result" # nix result directory
      ".ccls-cache" # ccls cache
      ".direnv"
    ];
    lfs.enable = true;
  };

  programs.gh.enable = true;
  home.persistence."/nix/persist".directories = [".config/gh"];
}
