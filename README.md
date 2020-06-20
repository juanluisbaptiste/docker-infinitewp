# docker-infinitewp
Unofficial infinitewp wordpress admin panel docker image. This repository contains the Dockerfiles and all other files needed to build and run the container.

## Build Instructions

We use `docker-compose` to build the images. Clone this repo and then:

    cd docker-infinitewp
    sudo docker-compose build

## How to run it

Edit the _.env.example_ file, rename it as _.env_ and then start the container:

    cd docker-infinitewp
    sudo docker-compose up
