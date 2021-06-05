#!/bin/bash

echo "BUILD.SH CUSTOM SCRIPT - BEGIN >>>>>>>>"

RUNTIME_NAME="PHP"
RUNTIME_LOGO="php.png"
ARCHIVE_FILE=static-page-main

env

curl -sSLO https://gitlab.com/djalal/static-page/-/archive/main/${ARCHIVE_FILE}.tar.gz && \
  tar -xzf ${ARCHIVE_FILE}.tar.gz -C /tmp && \
  mv /tmp/${ARCHIVE_FILE}/* /var/www/html && \
  chown -R www-data:www-data /var/www/html && \
  rm ${ARCHIVE_FILE}.tar.gz

sed -i "s/__RUNTIME_NAME__/${RUNTIME_NAME}/" /var/www/html/index.html
sed -i "s/__RUNTIME_LOGO__/${RUNTIME_LOGO}/" /var/www/html/index.html

rm /var/www/html/index.php

echo "BUILD.SH CUSTOM SCRIPT - END <<<<<<<<<"
