{ pkgs, ... }:
{
  programs.chromium.enable = true;

  programs.chromium.extensions = [
    "bfhkfdnddlhfippjbflipboognpdpoeh" # remarkable
    "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" # add blocker
    "ekhagklcjbdpajgpjgmbionohlpdbjgc" # zotero
    "nkbihfbeogaeaoehlefnkodbefgpgknn" # metamask
  ];

}
