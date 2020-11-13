{ pkgs, ... }:
pkgs.runCommandLocal "bandwidth-blame.sh" {
  script = ./bandwidth-blame.sh;
  nativeBuildInputs = [ pkgs.makeWrapper ];
} ''
  makeWrapper $script $out/bin/bandwidth-blame.sh \
    --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash pkgs.wireshark pkgs.nmap ]}
''
