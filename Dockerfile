
# docker run -d \
#       -v $(pwd)/data/:/usr/data/recordings \
#       -e TZ=Europe/Bratislava \
#       --name nvr-camera1 \
#       theglow666/tiny-nvr \
#       rtsp://username:password@address:port//Streaming/Channels/2 \
#       camera1

FROM alpine

LABEL version="1.0" \
      maintainer="P1-Ro"

# TZ                    : set your timezone, lookup your location in the "tz database"
# DIR_NAME_FORCE        : if set to "true", forces the use of the folder name **WARNING: FILES COULD BE OVERWRITTEN BY ANOTHER PROCESS IF ENABLED!**
# HOUSEKEEP_ENABLED     : if set to "true", will clean old files
# HOUSEKEEP_DAYS        : files older than these days will be removed
# VIDEO_SEGMENT_TIME    : seconds of each clip - default 10 minutes
# VIDEO_FORMAT          : save output as mkv or mp4 file (if you get format errors try changing the format)

ENV TZ=Europe/Bratislava \
    DIR_NAME_FORCE=false \
    HOUSEKEEP_ENABLED=true \
    HOUSEKEEP_DAYS=3 \
    VIDEO_SEGMENT_TIME=600 \
    VIDEO_FORMAT=mp4

RUN apk update \
    && apk add bash tzdata ffmpeg \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /usr/data/recordings

COPY ./docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
