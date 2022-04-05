#! /bin/bash

for file in *.mp4; 
do 
  if [ ${file} != "*.mp4" ]
  then
    rm -rf "processed/${file%.*}"
    rm -rf "output/${file%.*}"
    mkdir "processed/${file%.*}"
    ffmpeg -y -i "$file" -c:v libx264 -b:v 5200k -x264-params keyint=60:scenecut=0 -pass 1 -f mp4 /dev/null && \
    ffmpeg -i "$file" -an -c:v libx264 -b:v 1872k -x264-params keyint=60:scenecut=0 -pass 2 "processed/${file%.*}/${file%.*}_hi".mp4
    ffmpeg -i "$file" -an -c:v libx264 -b:v 1172k -x264-params keyint=60:scenecut=0 -pass 2 "processed/${file%.*}/${file%.*}_md".mp4
    ffmpeg -i "$file" -an -c:v libx264 -b:v 672k -x264-params keyint=60:scenecut=0 -pass 2 "processed/${file%.*}/${file%.*}_lo".mp4
    ffmpeg -i "$file" -vn -c:a aac -b:a 128k -ac 2 -r 48k -pass 2 "processed/${file%.*}/${file%.*}_audio".mp4
    mp4fragment "processed/${file%.*}/${file%.*}_hi".mp4 "processed/${file%.*}/${file%.*}_hi_frag".mp4
    mp4fragment "processed/${file%.*}/${file%.*}_md".mp4 "processed/${file%.*}/${file%.*}_md_frag".mp4
    mp4fragment "processed/${file%.*}/${file%.*}_lo".mp4 "processed/${file%.*}/${file%.*}_lo_frag".mp4
    mp4fragment "processed/${file%.*}/${file%.*}_audio".mp4 "processed/${file%.*}/${file%.*}_audio_frag".mp4

    if [[ ${file} == *"_es.mp4"* || ${file} == *"-es.mp4"* ]]
    then
      mp4dash --language-map=en:es --hls --output-dir="output/${file%.*}" --use-segment-list [language=en]"processed/${file%.*}/${file%.*}_audio_frag".mp4 "processed/${file%.*}/${file%.*}_lo_frag".mp4 "processed/${file%.*}/${file%.*}_md_frag".mp4 "processed/${file%.*}/${file%.*}_hi_frag".mp4
    else 
      mp4dash --hls --output-dir="output/${file%.*}" --use-segment-list "processed/${file%.*}/${file%.*}_audio_frag".mp4 "processed/${file%.*}/${file%.*}_lo_frag".mp4 "processed/${file%.*}/${file%.*}_md_frag".mp4 "processed/${file%.*}/${file%.*}_hi_frag".mp4
    fi

  mv "$file" "processed/${file%.*}"
  fi
done
