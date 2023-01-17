#!/bin/env bash



fzf_remote () {
  USER=$1
  HOST=$(cat ~/.ssh/known_hosts | awk '{print $1}' | fzf)
  FILE_PATH=$(ssh $USER@$HOST fdfind | fzf)
  LOCAL_PATH=$(mktemp -d)
  sftp $USER@$HOST:$FILE_PATH $LOCAL_PATH &> /dev/null 
  echo $LOCAL_PATH
}
