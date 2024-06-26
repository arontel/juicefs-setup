#!/bin/bash

set -e

DOWNLOAD_VERSION="$1"

wget "https://github.com/arontel/juicefs/releases/download/${DOWNLOAD_VERSION}/juicefs" -O juicefs-download


get_version()
{
  $1 --version | awk '{print $3}'
}

JUICE_PATH="/usr/local/bin/juicefs"
if [ -f $JUICE_PATH ] && [ ! -L $JUICE_PATH ]
then
  CURRENT_VERSION="$(get_version ${JUICE_PATH})"
  mv "${JUICE_PATH}" "/usr/local/bin/${CURRENT_VERSION}"
  rm -f "$JUICE_PATH"
fi

chmod +x juicefs-download
NEW_VERSION="$(get_version ./juicefs-download)"
mv juicefs-download "/usr/local/bin/${NEW_VERSION}"
ln -sTf "/usr/local/bin/${NEW_VERSION}" $JUICE_PATH
