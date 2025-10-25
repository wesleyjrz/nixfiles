# Pending review
{
  config,
  pkgs,
  ...
}: let
  leader = ";";
in {
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor-fhs;
    extraPackages = with pkgs; [nixd nil alejandra clang-tools];
    extensions = ["nix"];
    userSettings = {
      disable_ai = false;
      features.edit_prediction_provider = "copilot";
      edit_predictions.mode = "subtle";
      auto_update = false;
      autosave = "on_focus_change";
      minimap.show = "never";
      cursor_blink = false;
      scrollbar.show = "never";
      relative_line_numbers = true;
      soft_wrap = "editor_width";
      show_wrap_guides = false;
      title_bar.show_sign_in = false;
      tab_bar = {
        show_nav_history_buttons = false;
        show_tab_bar_buttons = false;
      };
      toolbar = {
        quick_actions = false;
        selections_menu = false;
      };
      inlay_hints.enabled = true;
      vim_mode = true;
      base_keymap = "Emacs";
      ui_font_family = config.stylix.fonts.sansSerif.name;
      ui_font_size = config.stylix.fonts.sizes.terminal;
      buffer_font_family = config.stylix.fonts.monospace.name;
      buffer_font_size = config.stylix.fonts.sizes.terminal;
      show_whitespaces = "selection";
      whitespace_map = {
        space = "•";
        tab = " ";
      };
      auto_signature_help = true;
      load_direnv = "shell_hook";
      confirm_quit = true;
      terminal = {
        shell = "system";
        blinking = "terminal_controlled";
        line_height = "comfortable";
        copy_on_select = true;
        font_family = config.stylix.fonts.monospace.name;
      };
      languages = {
        Nix = {
          formatter.external = {
            command = "alejandra";
            arguments = [];
          };
          format_on_save = "on";
        };
        C = {
          preferred_line_length = 80;
          soft_wrap = "bounded";
        };
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
    userKeymaps = [
      {
        ### When no panes are open
        context = "EmptyPane || SharedScreen";
        bindings = {
          # Pickers
          "${leader} p" = "projects::OpenRecent";
          "${leader} f" = "file_finder::Toggle";

          # Docks and Panels
          "${leader} a" = "agent::ToggleFocus";

          # Toggle project panel
          "-" = "project_panel::ToggleFocus";
          "_" = "workspace::ToggleLeftDock";

          # Toggle terminal
          "ctrl-\\" = "terminal_panel::Toggle";
        };
      }
      {
        ### Normal mode
        context = "vim_mode == normal && !menu";
        bindings = {
          # Window resize
          ctrl-left = "vim::ResizePaneLeft";
          ctrl-down = "vim::ResizePaneDown";
          ctrl-up = "vim::ResizePaneUp";
          ctrl-right = "vim::ResizePaneRight";

          # Navigate buffers
          ctrl-n = "pane::ActivateNextItem";
          ctrl-p = "pane::ActivatePreviousItem";

          # Pickers
          "${leader} p" = "projects::OpenRecent";
          "${leader} f" = "file_finder::Toggle";
          "${leader} b" = "tab_switcher::ToggleAll";

          # Docks and Panels
          "${leader} g" = "git_panel::ToggleFocus";
          "${leader} a" = "agent::ToggleFocus";
          "${leader} d" = "debugger::Start";
          "${leader} t" = "task::Spawn";

          # Toggle project panel
          "-" = "vim::ToggleProjectPanelFocus";
          "_" = "workspace::ToggleLeftDock";

          # Toggle terminal
          "ctrl-\\" = "terminal_panel::Toggle";
        };
      }
      {
        ### Visual and Normal modes
        context = "VimControl && !menu";
        bindings = {
          # Toggle centered layout
          "ctrl-w c" = "workspace::ToggleCenteredLayout";
        };
      }
      {
        ### Subword motion
        context = "VimControl && !menu && vim_mode != operator";
        bindings = {
          w = "vim::NextSubwordStart";
          e = "vim::NextSubwordEnd";
          b = "vim::PreviousSubwordStart";
        };
      }
      {
        ### Insert mode
        context = "vim_mode == insert";
        bindings = {
          ctrl-h = "editor::Backspace";
          ctrl-j = "editor::Newline";
        };
      }
      {
        ### Completion menu navigation
        context = "showing_completions";
        bindings = {
          ctrl-n = "editor::ContextMenuNext";
          ctrl-p = "editor::ContextMenuPrevious";
        };
      }
      {
        ### Pane and Dock contexts
        context = "Pane || Dock";
        bindings = {
          # Window navigation
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w j" = "workspace::ActivatePaneDown";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w l" = "workspace::ActivatePaneRight";

          # Window resize
          "ctrl-left" = "vim::ResizePaneLeft";
          "ctrl-down" = "vim::ResizePaneDown";
          "ctrl-up" = "vim::ResizePaneUp";
          "ctrl-right" = "vim::ResizePaneRight";
        };
      }
      {
        ### Dock context
        context = "Dock";
        bindings = {
          "ctrl-w q" = "workspace::CloseActiveDock";
        };
      }
      {
        ### Project Panel context
        context = "ProjectPanel && not_editing";
        bindings = {
          a = "project_panel::NewFile";
          A = "project_panel::NewDirectory";
          r = "project_panel::Rename";
          d = "project_panel::Delete";
          x = "project_panel::Cut";

          # Toggle project panel
          "-" = "vim::ToggleProjectPanelFocus";
          "_" = "workspace::ToggleLeftDock";
        };
      }
    ];
  };

  stylix.targets.zed.enable = false;

  home.persistence."/nix/persist".directories = [
    ".config/zed"
    ".local/share/zed"
  ];
}
