#!/usr/bin/env bash

help(){
  echo "not much help yet"
}

findDirectoriesFile() {
  directoriesFile=${directory}/directories.yaml
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
  echo No link given.
  echo link: $link
  help
  exit 1
fi

if [[ $directory == "0" ]]; then
  directory=$(pwd)
fi


findDirectoriesFile

if [[ $directoriesFile == "0" ]]; then
  echo No link given.
  help
  exit 1
fi

if [[ $link =~ ^z\:[a-z]+ ]]; then
  echo ${BASH_REMATCH[1]}
  exit 1
else
  if [[ -f  ${directory}/${link#*:}.md ]]; then
    echo ${directory}/${link#*:}.md
  else
    echo ${directory}/staging/${link#*:}.md
  fi
fi



