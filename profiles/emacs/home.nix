{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
  };

  home.file.".emacs.d" = {
    # don't make the directory read only so that impure melpa can still happen
    # for now
    recursive = true;
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "develop";
      sha256 = "01f9cb3iqlz5x0wdgymaxkqrsl0hbws5x0kbj52mfpqcid3s2dl0";
    };
  };

  home.file.".spacemacs.d/init.el".source = ./init.el;
}
