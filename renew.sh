#!/bin/bash

# get the absolute path to the directory of this script
# code taken from https://gist.github.com/TheMengzor/968e5ea87e99d9c41782
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# get additional environment variables
source $DIR/ENV.sh

count=0
while [ "x${DOMAINS[count]}" != "x" ]
do
  echo "/usr/bin/certbot certonly -n --manual --manual-public-ip-logging-ok --preferred-challenges=dns --email joost.v.someren@gmail.com --manual-auth-hook $DIR/authenticator.sh --manual-cleanup-hook $DIR/cleanup.sh -d ${DOMAINS[count]}"
  count=$(( $count + 1 ))
done
