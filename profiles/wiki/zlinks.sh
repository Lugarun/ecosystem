#!/usr/bin/env bash

help(){
  echo "Usage: $0 [OPTION]"
  echo "Convert my wiki links into full paths"
  echo "  -l link 	give a wiki link to convert"
  echo "  -d path 	directory that specifies directories.yaml file, by default it searches parent directories"
  echo "  -h		display this help and exit"
  echo
  echo "Examples:"
  echo "  $0 -l z:a2"
}

findDirectoriesFile() {
  path=$directory
  while [[ "$path" != "" && ! -e "$path/directories.yaml" ]]; do
    path=${path%/*}
  done
  directoriesFile=${path}/directories.yaml
}

args=$(getopt -o "l:h:d" -- "$@")

eval set -- "$args"

link=0
directory=0
directoriesFile=0

while [ $# -ge 1 ]; do
  case "$1" in
    --)
      shift
      break
      ;;
    -l)
      link="$2"
      shift
      ;;
    -d)
      directory="$2"
      shift
      ;;
    -h)
      help
      exit 0
      ;;
  esac
  shift
done

if [[ $link == "0" ]]; then
  echo No link given. 1>&2
  echo link: $link 1>&2
  help
  exit 1
fi

if [[ $directory == "0" ]]; then
  directory=$(pwd)
fi


findDirectoriesFile

if [[ $directoriesFile == "0" ]]; then
  help
  exit 1
fi

if [[ $link =~ ^z\:([a-z]+) ]]; then
  link=$(echo $link | sed -r 's/^z\:[a-zA-Z]+//')
  directory=$(yq -r -M ".fiasco | del(.[] | select(.${BASH_REMATCH[1]} == null)) | .[].${BASH_REMATCH[1]} | ." directorys.yaml)
  for d in $directory; do
    if [[ -f $d/${link}.md ]]; then
      echo $d/${link}.md
      exit 0
    fi
  done
  exit 1
else
  exit 1
fi



