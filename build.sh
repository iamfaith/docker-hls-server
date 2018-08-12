#!/bin/bash

cd `dirname $0`
sudo docker build -t hls-server --build-arg STREAM_SERVER=$STREAM_SERVER --build-arg STREAM_KEY=$STREAM_KEY .
