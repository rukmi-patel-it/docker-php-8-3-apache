# docker-php-8-3-apache

This repository is designed to run projects in Docker environment for below technologies.
 - PHP 8.3
 - Composer 2.3
 - Node.js 18.x
 - MySql 8.3

To install and run containers, you must install `docker` and `docker-compose` in your system. Follow below URLs to install dependencies.

 - https://docs.docker.com/engine/install/
 - https://docs.docker.com/compose/install/


## How to run project 

1. First, you must create `mysql` folder in the same hierarchy as `conf` so you can see the folders side by side.
2. Run `docker-compose up -d --build` command to download and run docker containers in background.