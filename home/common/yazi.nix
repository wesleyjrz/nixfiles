# Pending review
{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;
    keymap = {
      manager.prepend_keymap = [
        {
          run = "cd ~/Development";
          on = ["g" "D"];
          desc = "Goto ~/Development";
        }
        {
          run = "cd ~/Pictures/screenshots";
          on = ["g" "s"];
          desc = "Goto ~/Pictures/screenshots";
        }
        {
          run = "cd /backup";
          on = ["g" "b"];
          desc = "Go to Backup disk";
        }
        {
          run = "cd ~/.local/share/Trash/files";
          on = ["g" "t"];
          desc = "Go to Trash";
        }

        {
          run = "tab_switch --relative '-1'";
          on = "<C-t>";
          desc = "Go to the previous tab";
        }
        {
          run = "tab_switch --relative '1'";
          on = "<C-n>";
          desc = "Go to the next tab";
        }

        {
          run = "quit";
          on = "<C-q>";
          desc = "Quit";
        }
      ];
    };
  };

  home.packages = [pkgs.ueberzugpp];

  home.persistence."/nix/persist".directories = [".local/state/yazi"];
}
