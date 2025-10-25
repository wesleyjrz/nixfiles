# Pending review
{
  lib,
  config,
  ...
}: {
  programs.zsh = {
    localVariables = {
      # Extended colour support
      TERM = "xterm-256color";
      COLORTERM = "truecolor";
    };
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # If not running interactively, don't do anything
        [[ $- != *i* ]] && return
      '')
      ''
        # Enable extended glob (to use features like `^` for exclusion)
        setopt EXTENDEDGLOB

        # Enable parameter expansion, command substitution, and arithmetic
        # expansion in the prompt
        setopt PROMPT_SUBST

        # Disable beeps
        unsetopt BEEP

        # On an ambiguous completion, instead of listing possibilities or beeping,
        # insert the first match immediately
        unsetopt MENU_COMPLETE

        # Automatically use menu completion after the second consecutive request
        # NOTE: This option is overwritten by MENU_COMPLETE.
        setopt AUTO_MENU

        # Remove extra blanks from each command line being added to history
        setopt HIST_REDUCE_BLANKS

        # Add commands as they are typed, don't wait until shell exit
        setopt INC_APPEND_HISTORY
      ''
      (lib.mkOrder 550 ''
        # Completers to use
        zstyle ":completion:*::::" completer _complete _ignored _correct _approximate

        # Enable selection menu (show the current selection)
        zstyle ":completion:*" menu select=1 _complete _ignored _approximate

        # Formatting and messages
        zstyle ":completion:*" verbose yes
        zstyle ":completion:*:descriptions" format "%B%d%b"
        zstyle ":completion:*:messages" format "%d"
        zstyle ":completion:*:warnings" format "No matches for: %d"
        zstyle ":completion:*:corrections" format "%B%d (errors: %e)%b"
        zstyle ":completion:*" group-name ""

        # Colors for `kill` command
        zstyle ":completion:*:*:kill:*" list-colors "=(#b) #([0-9]#)*( *[a-z])*=34=31=32"

        # Allow completion from within a word/phrase
        setopt COMPLETE_IN_WORD

        # When completing from the middle of a word, move the cursor to the end of the word
        setopt ALWAYS_TO_END

        #zprof
      '')
    ];
    envExtra = "export GPG_TTY=$TTY";
    autocd = true;
    history = rec {
      # Where to save history
      path = "${config.xdg.cacheHome}/zsh/zsh-history.log";
      ignorePatterns = [
        "l"
        "l[lrs]"
        "cd"
        "pwd"
        "clear"
        "exit"
        "history"
        "c"
        "cd -"
        "-"
        "cd .."
      ];
      append = true;
      findNoDups = true;
      ignoreAllDups = true;
      save = 1000;
      size = save;
    };
  };
}
