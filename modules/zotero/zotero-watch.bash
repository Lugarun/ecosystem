#!/usr/bin/env bash

while true; do
    inotifywait $1
    zotero-remarkable $1 $2
done
