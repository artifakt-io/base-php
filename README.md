# base-php
Artifakt base repository for PHP Runtime

## Getting started

Artifakt PaaS provides specialized [base docker images](https://github.com/artifakt-io/artifakt-docker-images) to build your application images.
Artifakt PaaS also includes sample base repositories like this one to showcase how to build locally and test your code before pushing it to production.

##Pre-requisites

To enjoy the best experience, a recent version of Docker (>=20.10) is required.
Older versions like 19.03 can work by enabling experimental features.

Docker-compose is also required. See [official instructions](https://docs.docker.com/compose/install/) for your own OS.

## Run a basic container

```
docker run -d -p 8000:80 registry.artifakt.io/php:8-apache
```

## Adding custom code

Our standard Dockerfile defines a default workdir in /var/www/html to put your code into. By default, it is copied inside the custom docker image when you build it.

We also have a development mode, with the included docker-compose file that will mount code inside the container directly, without the need to rebuild on each file update. This is a good practice and enables a fast iteration cycle.

## Persistent data

To persist data between container updates, we inittialize a /data/ folder inside the docker image. You can use it for images, assets, uploads, cache, etc.

## Building Workflow

What happens when you build the image with our standard Dockerfile?

1. base image is pulled from Artifakt free registry
2. local Docker file is built
3. if custom build args exists that are sourced from local repo
4. if a build.sh script is available, it is executed
5. overall, during build step we add code source and install packages and internal dependencies
6. if the special folder ‘.artifakt’ is found it is copied at the container root file system for later use.

End of build step!

# Starting workflow

Here is what happens when the container runs on your workstation. We apply the same workflow in production for predictible results.

1. environment variables for all dependencies are gathered: mysql, redis, elasticache, etc.
2. container is created with standard volumes on /data and /var/log/artifakt.
3. container is configured with standard env. variables
4. container is started and runs the base image entrypoint
5. base image entrypoint will look for a custom entrypoint script in /.artifakt folder and run it for you.
