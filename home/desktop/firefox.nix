# Pending review
{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "dom.security.https_only_mode" = true;

        # Better context menu options so I can play on chess.com and use arrows
        "dom.event.contextmenu.enabled" = true;
        "dom.event.contextmenu.shift_suppresses_event" = false;
      };
      search = {
        force = true;
        default = "Brave Search";
        engines = {
          "Brave Search" = {
            urls = [{template = "http://search.brave.com/search?q={searchTerms}";}];
            icon = "http://search.brave.com/favicon.ico";
            definedAliases = ["@brave"];
          };
          "DevDocs" = {
            urls = [{template = "https://devdocs.io/search?q={searchTerms}";}];
            icon = "https://devdocs.io/favicon.ico";
            definedAliases = ["@docs"];
          };
          "Nix Packages" = {
            urls = [{template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            urls = [{template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          "Home-Manager Options" = {
            urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];
          };
          "NixOS Wiki" = {
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nw"];
          };
          "Noogle" = {
            urls = [{template = "https://noogle.dev/q?term={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@ng"];
          };
          "ArchWiki" = {
            urls = [{template = "https://wiki.archlinux.org/index.php?search={searchTerms}";}];
            icon = "https://wiki.archlinux.org/favicon.ico";
            definedAliases = ["@aw"];
          };
          "youtube" = {
            urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
            icon = "https://www.youtube.com/favicon.ico";
            definedAliases = ["@yt"];
          };
          "GitHub" = {
            urls = [{template = "https://github.com/search?q={searchTerms}&type=repositories";}];
            icon = "https://github.com/favicon.ico";
            definedAliases = ["@gh"];
          };
          "Music" = {
            urls = [{template = "https://music.youtube.com/search?q={searchTerms}";}];
            icon = "https://music.youtube.com/favicon.ico";
            definedAliases = ["@ytm"];
          };
          "protondb" = {
            urls = [{template = "https://www.protondb.com/search?q={searchTerms}";}];
            icon = "https://www.protondb.com/favicon.ico";
            definedAliases = ["@pdb"];
          };
          amazondotcom-us.metaData.hidden = true;
          bing.metaData.hidden = true;
          wikipedia.metaData.alias = "@wiki";
          google.metaData.alias = "@gg";
        };
        order = [
          "brave"
          "ddg"
          "google"
          "docs"
          "wikipedia"
          "np"
          "no"
          "hm"
          "nw"
          "ng"
          "aw"
          "gh"
          "yt"
          "ytm"
        ];
      };
      userChrome = ''
        /* Adds icons to main menu items which were removed in Proton */

        #appMenu-fxa-status2[fxastatus] > toolbarbutton::before,
        #appMenu-protonMainView > .panel-subview-body > toolbarbutton > image{
          fill: currentColor;
          -moz-context-properties: fill;
          margin-inline: 0 8px !important;
        }
        #appMenu-new-tab-button2{ list-style-image: url("chrome://browser/skin/new-tab.svg") }
        #appMenu-new-window-button2{ list-style-image: url("chrome://browser/skin/window.svg") }
        #appMenu-new-private-window-button2{ list-style-image: url("chrome://browser/skin/privateBrowsing.svg") }
        #appMenu-bookmarks-button{ list-style-image: url("chrome://browser/skin/bookmark-star-on-tray.svg") }
        #appMenu-history-button{ list-style-image: url("chrome://browser/skin/history.svg") }
        #appMenu-downloads-button{ list-style-image: url("chrome://browser/skin/downloads/downloads.svg") }
        #appMenu-passwords-button{ list-style-image: url("chrome://browser/skin/login.svg") }
        #appMenu-extensions-themes-button{ list-style-image: url("chrome://mozapps/skin/extensions/extension.svg") }
        #appMenu-print-button2{ list-style-image: url("chrome://global/skin/icons/print.svg") }
        #appMenu-save-file-button2{ list-style-image: url("chrome://browser/skin/save.svg") }
        #appMenu-find-button2{ list-style-image: url("chrome://global/skin/icons/search-glass.svg") }
        #appMenu-settings-button{ list-style-image: url("chrome://global/skin/icons/settings.svg") }
        #appMenu-more-button2{ list-style-image: url("chrome://global/skin/icons/developer.svg") }
        #appMenu-help-button2{ list-style-image: url("chrome://global/skin/icons/info.svg") }
        #appMenu-quit-button2{ list-style-image: url("chrome://devtools/skin/images/search-clear.svg") }

        /* Add somewhat hacky separator to zoom controls so it looks consistent */
        #appMenu-protonMainView > .panel-subview-body::after{
          content: "";
          display: -moz-box;
          border-bottom: 1px solid var(--panel-separator-color);
          margin: var(--panel-separator-margin);
        }

        #appMenu-find-button2 ~ *{
          -moz-box-ordinal-group: 2;
        }

        /* Show bookmarks toolbar in fullscreen mode */

        #main-window[inFullscreen="true"] #PersonalToolbar {
          visibility: visible !important;
        }

        /* Move up the content view */
        :root[sessionrestored]:not([inFullscreen]) > body > #browser{ margin-top: var(--uc-navbar-transform); }

        /* Always show tab close button on hover and never otherwise */

        .tabbrowser-tab .tab-close-button{
          display:none;
        }
        .tabbrowser-tab:not([pinned]):hover .tab-close-button{
          display: flex !important;
          align-items: center;
        }
      '';
    };
  };

  home.persistence."/nix/persist".directories = [
    ".mozilla/firefox"
  ];
}
