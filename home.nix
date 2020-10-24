{ config, pkgs, lib, ... }:

let

  foreground = "#c5c8c6";
  background = "#1d1f21";
  cursorColor = "#c5c8c6";
  color0 = "#282a2e";
  color8 = "#373b41";
  color1 = "#a54242";
  color9 = "#cc6666";
  color2 = "#8c9440";
  color10 = "#b5bd68";
  color3 = "#de935f";
  color11 = "#f0c674";
  color4 = "#5f819d";
  color12 = "#81a2be";
  color5 = "#85678f";
  color13 = "#b294bb";
  color6 = "#5e8d87";
  color14 = "#8abeb7";
  color7 = "#707880";
  color15 = "#c5c8c6";

in {

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";


  home.packages = [
      pkgs.tree
      pkgs.wesnoth
      pkgs.htop
      pkgs.nmap
      pkgs.ncpamixer
      pkgs.bashmount
      pkgs.pandoc
      pkgs.docker
      pkgs.discord
      pkgs.teams
      pkgs.youtube-dl
      pkgs.spotify
      pkgs.lazygit
      pkgs.dmenu
      pkgs.wpgtk
      pkgs.syncthing
      pkgs.kitty
      pkgs.unzip
      pkgs.udisks
      pkgs.fasd
      pkgs.zathura
      pkgs.kak-lsp
      pkgs.ghc
      ];


  programs.firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [dark-night-mode];
      profiles = {
          myprofile = {
              settings = {
                  "general.smoothScroll" = false;
                  "browser.startup.homepage" = "https://lugarun.github.io/bookmarks";
                  };
              };
          };
      };
  programs.browserpass.enable = true;

  gtk = {
      enable = true;
      theme = {
          package =pkgs.arc-theme;
          name="Arc-Dark";
          };
      iconTheme = {
          package = pkgs.paper-icon-theme;
          name = "Paper";
          };
      };

  programs.git = {
      enable = true;
      userName = "Lukas Schmidt";
      userEmail= "lfschmidt.me@gmail.com";
      
      };

  programs.kakoune = {
      enable = true;
      extraConfig = ''
          # Visula Options
          # ─────────────────────────
          set global ui_options ncurses_set_title=false
          addhl global/ wrap
          # Increase menu contrast
          face global MenuBackground white,black
          set global indentwidth 2
          
          # Fuzzy Finders
          # ─────────────────────────
          def find-new -params 1 -shell-script-candidates %{ find -type f } %{ edit %arg{1}}
          def find -params 1 -shell-script-candidates %{ fasd -f -l } %{ edit %arg{1}}
          alias global f find
          
          
          # Snippets
          # ─────────────────────────
          #set-option global snippets_auto_expand true
          
          
          # Default terminal
          # ─────────────────────────
          hook global ModuleLoaded "x11" %{
            set-option global termcmd "terminal bash -i -c"
          }
          
          # kak-lsp
          # ─────────────────────────
          eval %sh{kak-lsp --kakoune --session $kak_session}
          set global lsp_cmd "kak-lsp -s %val{session} -vvv --log /tmp/kak-lsp.log"
          hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp|haskell|bash) %{
            map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
            lsp-enable-window
            lsp-auto-hover-enable
            lsp-auto-hover-insert-mode-disable
            set-option window lsp_hover_anchor true
          
          }
          
          
          # System clipboard handling
          # ─────────────────────────
          hook global NormalKey y|d|c %{ nop %sh{
            printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
          }}
          
          
          # Repl Interaction
          # ─────────────────────────
          hook global WinSetOption filetype=python %{
            set window repl_send_command "python -i"
            set window repl_send_exit_command "exit()"
          }
          hook global WinSetOption filetype=r %{
            set window repl_send_command "R"
            set window repl_send_exit_command "q(save = \"no\")"
          }
          
          
          
          # Markdown
          # ─────────────────────────
          
          # This function is from https://github.com/TeddyDD/kakoune-wiki
          # 
          # ISC License
          # 
          # Copyright (c) 2018, Daniel Lewan
          # 
          # Permission to use, copy, modify, and/or distribute this software for any
          # purpose with or without fee is hereby granted, provided that the above
          # copyright notice and this permission notice appear in all copies.
          # 
          # THE SOFTWARE IS PROVIDED \"AS IS\" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
          # WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
          # MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
          # ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
          # WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
          # ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
          # OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
          
          define-command wiki-follow-link \
          -docstring %{ Follow markdown link and open or create file } %{
              evaluate-commands %{
                  execute-keys %{
                      <esc><a-a>c\[,\)<ret><a-:>
                      <a-i>b
                  }
                  evaluate-commands %sh{
                      FILE="$(readlink -f "''${kak_buffile%/*}/$kak_selection")"
                      EXTENSION="''${FILE##*.}"
          
                      openAsync () {
                        ABDUCO_SESSIONS=$(abduco | awk 'NR > 1 {print $NF}')
                        ABDUCO_NEW=$(echo $ABDUCO_SESSIONS | step)
                        abduco -f -n $ABDUCO_NEW "$1" "$FILE" 
                      }
          
                      if [[ $EXTENSION == md ]]; then
                        echo "edit" "'"$FILE"'"
                      else
                        openAsync xdg-open
                      fi
                  }
                  try %{ focus %opt{jumpclient} }
              }
          }
          
          
          # Key Bindings
          # ─────────────────────────
          
          
          hook global BufSetOption filetype=haskell %{
            map buffer user = -docstring 'repl-eval' ': repl-bridge haskell send<ret>R'
            map buffer user s -docstring 'repl-send' ': repl-bridge haskell send<ret>'
          }
          
          hook global BufSetOption filetype=r %{
            map buffer user = -docstring 'repl-eval' ': repl-bridge r send<ret>R'
            map buffer user s -docstring 'repl-send' ': repl-bridge r send<ret>'
          }
          
          hook global BufSetOption filetype=python %{
            map buffer user = -docstring 'repl-eval' ': repl-bridge python send<ret>R'
            map buffer user s -docstring 'repl-send' ': repl-bridge python send<ret>'
          }
          
          hook global BufSetOption filetype=markdown %{
            map buffer user e -docstring 'wiki-follow' ': wiki-follow-link<ret>'
          }
          
          hook global BufSetOption filetype=kak %{
            define-command sys-eval 'eval %val{selection}'
            map buffer user r -docstring 'eval selection' ':sys-eval<ret>'
          }
          
          map global user d ':edit "%val{config}/../nixpkgs/home.nix"<ret>' -docstring 'edit kakrc'
          
          '';
      };

  home.file.".config/kitty/kitty.conf".text = ''
  background ${background}
  foreground ${foreground}
  color0 ${color0}
  color1 ${color1}
  color2 ${color2}
  color3 ${color3}
  color4 ${color4}
  color5 ${color5}
  color6 ${color6}
  color7 ${color7}
  color8 ${color8}
  color9 ${color9}
  color10 ${color10}
  color11 ${color11}
  color12 ${color12}
  color13 ${color13}
  color14 ${color14}
  color15 ${color15}
  background_opacity 0.5
  '';

  programs.tmux = {
      enable = true;
      clock24 = true;
      extraConfig = ''
      set -sg escape-time 25
      set-window-option -g mode-keys vi
      
      # modal
      
      set-option -g prefix C-g
      
      # mouse mode
      set -g mouse on
      
      # navigation keybindings
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      bind H resize-pane -L
      bind J resize-pane -D
      bind K resize-pane -U
      bind L resize-pane -R
      
      bind Right next-window
      bind Left previous-window
      
      
      bind | split-window -h
      bind - split-window -v
      
      bind c new-window
      
      bind q kill-pane
      bind Q kill-window
      
      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "clipcat"
      
      '';
      };

  programs.zathura = {
      enable = true;
      extraConfig = ''
      set selection-clipboard clipboard
      set recolor "true"
      
      set completion-bg "#0f0f16"
      set completion-fg "#ffffd6"
      set completion-group-bg "#0f0f16"
      set completion-group-fg "#8F6349"
      set completion-highlight-bg "#ffffd6"
      set completion-highlight-fg "#0f0f16"
      
      set recolor-lightcolor "#0f0f16"
      set recolor-darkcolor "#ffffd6"
      set default-bg "#0f0f16"
      
      set inputbar-bg "#0f0f16"
      set inputbar-fg "#ffffd6"
      set notification-bg "#0f0f16"
      set notification-fg "#ffffd6"
      set notification-error-bg "#C17C45"
      set notification-error-fg "#ffffd6"
      set notification-warning-bg "#C17C45"
      set notification-warning-fg "#ffffd6"
      set statusbar-bg "#0f0f16"
      set statusbar-fg "#ffffd6"
      set index-bg "#0f0f16"
      set index-fg "#ffffd6"
      set index-active-bg "#ffffd6"
      set index-active-fg "#0f0f16"
      set render-loading-bg "#0f0f16"
      set render-loading-fg "#ffffd6"
      
      set window-title-home-tilde true
      set statusbar-basename true
      set selection-clipboard clipboard
      '';
      };

  xdg.configFile."kak-lsp/kak-lsp.toml".text = ''
  [language.haskell]
  filetypes = ["haskell"]
  roots = ["Setup.hs", "stack.yaml", "*.cabal"]
  command = "haskell-language-server-wrapper"
  args = ["--lsp"]
  
  [language.c_cpp]
  filetypes = ["c", "cpp"]
  roots = ["compile_commands.json", ".ccls", ".git"]
  command = "ccls"
  # Disable additional information in autocompletion menus that Kakoune inserts into the buffer until https://github.com/ul/kak-lsp/issues/40 gets fixed
  args = ["--init={\"completion\":{\"detailedLabel\":false}}"]
  '';

  programs.bash = {
      enable = true;
      initExtra = ''
      set -o vi
      export EDITOR=kak
      export BROWSER=firefox
      export XDG_CONFIG_HOME=/home/lukas/.config
      alias w3md="(cd ~/Downloads; w3md duckduckgo.com)"
      alias cp="cp -i"
      eval "$(fasd --init auto)"
      '';
      };

  services.syncthing.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "curses";
  programs.password-store.enable = true;

  xsession.enable = true;
  xsession.windowManager.xmonad.enable = true;
  xsession.windowManager.xmonad.enableContribAndExtras = true;
  xsession.windowManager.xmonad.config = ./xmonad.hs;


}
