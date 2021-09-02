FROM registry.artifakt.io/php:8-apache

ARG ARTIFAKT_COMPOSER_COMMAND=${ARTIFAKT_COMPOSER_COMMAND:-"--no-cache --optimize-autoloader --no-interaction --no-ansi --no-dev"}
ARG CODE_ROOT=.

COPY --chown=www-data:www-data $CODE_ROOT /var/www/html/

WORKDIR /var/www/html/

RUN if [ -f composer.lock ]; then if [[ ! -v $ARTIFAKT_COMPOSER_COMMAND ]]; then echo "Artifakt composer install" && composer install --no-cache --optimize-autoloader --no-interaction --no-ansi --no-dev; else echo "Custom composer install" && composer install $ARTIFAKT_COMPOSER_COMMAND;	fi fi
RUN echo "${ARTIFAKT_COMPOSER_COMMAND}" >> "test.txt"

# copy the artifakt folder on root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN  if [ -d .artifakt ]; then cp -rp /var/www/html/.artifakt /.artifakt/; fi

# run custom scripts build.sh
# hadolint ignore=SC1091
RUN --mount=source=artifakt-custom-build-args,target=/tmp/build-args \
  if [ -f /tmp/build-args ]; then source /tmp/build-args; fi && \
  if [ -f /.artifakt/build.sh ]; then /.artifakt/build.sh; fi

# fix perms/owner
RUN chown -R www-data:www-data /var/www/html/

