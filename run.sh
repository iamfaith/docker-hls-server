#!/bin/bash

cd `dirname $0`
sudo docker run -d -p 7000:80 -p 1935:1935 -ti --name hls hls-server
