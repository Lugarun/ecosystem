{ stdenv, rmapi, zotero-remarkable, inotify-tools }:
stdenv.mkDerivation {
  name = "zotero-watch";
  buildInputs = [ zotero-remarkable rmapi inotify-tools ];
  unpackPhase = "true";
  installPhase = ''
    mkdir -p $out/bin
    cp ${./zotero-watch.bash} $out/bin/zotero-watch
    sed -i "2 i export PATH=$PATH" $out/bin/zotero-watch
    chmod +x $out/bin/zotero-watch
    '';
}
