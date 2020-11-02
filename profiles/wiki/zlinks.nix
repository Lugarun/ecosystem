{ pkgs, ... }:
pkgs.runCommandLocal "zlinks.sh" {
  script = ./zlinks.sh;
  nativeBuildInputs = [ pkgs.makeWrapper ];
} ''
  makeWrapper $script $out/bin/zlinks.sh \
    --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash pkgs.jq ]}
''
