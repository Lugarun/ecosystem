{ pkgs, ... }:
{
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
}
