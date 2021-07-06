{ pkgs, ... }:
pkgs.runCommandLocal "ide" {
  script = ./ide;
  nativeBuildInputs = [ pkgs.makeWrapper ];
} ''
  makeWrapper $script $out/bin/ide \
    --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash pkgs.yq ]}
''
