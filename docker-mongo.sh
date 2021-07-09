#!/bin/bash
sudo docker run -p 27017:27017 -v $PWD/db:/data/db -d mongo
