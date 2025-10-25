# Pending review
{config, ...}: {
  gtk = {
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-enable-event-sounds=0
        gtk-enable-input-feedback-sounds=0
        gtk-key-theme-name="Emacs"
      '';
    };
    gtk3.extraConfig = {
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-key-theme-name = "Emacs";
    };
  };
}
