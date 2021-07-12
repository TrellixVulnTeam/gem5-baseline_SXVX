#!/bin/bash
sudo docker run -p 27017:27017 -v /data/sungkeun/mongdb:/data/db -d mongo
