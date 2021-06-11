#!/bin/bash

echo "BUILD.SH CUSTOM SCRIPT - BEGIN >>>>>>>>"

RUNTIME_NAME="PHP"
RUNTIME_LOGO="php.png"
ARCHIVE_FILE=main
WORKDIR=/var/www/html

env

mkdir -p $WORKDIR
curl -sSLO https://github.com/artifakt-io/base-html/archive/refs/heads/${ARCHIVE_FILE}.tar.gz && \
  tar -xzf ${ARCHIVE_FILE}.tar.gz -C /tmp && \
  mv /tmp/${ARCHIVE_FILE}/* ${WORKDIR} && \
  chown -R www-data:www-data ${WORKDIR} && \
  rm ${ARCHIVE_FILE}.tar.gz

sed -i "s/__RUNTIME_NAME__/${RUNTIME_NAME}/" ${WORKDIR}/index.html
sed -i "s/__RUNTIME_LOGO__/${RUNTIME_LOGO}/" ${WORKDIR}/index.html

rm /var/www/html/index.php

echo "BUILD.SH CUSTOM SCRIPT - END <<<<<<<<<"
