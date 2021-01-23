{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [ dark-night-mode browserpass vimium honey privacy-badger ublock-origin];
    profiles = {
      myprofile = {
        settings = {
          "general.smoothScroll" = false;
          "browser.startup.homepage" = "https://lugarun.github.io/bookmarks";
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "signon.rememberSignons" = false;
        };
      };
    };
  };

  programs.browserpass.enable = true;
}
