{ writeShellScriptBin, zotero-remarkable, inotify-tools }:
writeShellScriptBin "zotero-watch" ''
  while true; do
      ${inotify-tools}/bin/inotifywait $1
      ${zotero-remarkable}/bin/zotero-remarkable $1 $2
  done
''
