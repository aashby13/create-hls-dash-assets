#! /bin/bash

path=$(pwd)
fswatch -o ./ -l 10 -e ".*" -i "${path}/[^/]*\\.mp4$" -x Created Renamed | xargs -n1 -I{} ./hls_dash.sh
