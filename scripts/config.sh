#!/bin/bash

SCRIPT_PATH=$(dirname `which $0`)

# The file to play when the stream is offline, should be full path, and must be readable by nginx
# The file should have the same resolution and bitrate as your actual stream
offfi="$SCRIPT_PATH/black_10.mp4"

name="$(cat $SCRIPT_PATH/name.param)"
dest="$(cat $SCRIPT_PATH/dest.param)"
to="$(cat $SCRIPT_PATH/timeout.param)"

# The RTMP endpoint, ie: your Twitch RTMP link
if [ -z "$dest" ]
then
      rtmpe="rtmp://127.0.0.1:1935/out/$name"
else
      rtmpe="$dest"
fi


# The RTMP ingest stream, you probaly don't need to change this if you're using streamRIP nginx config
rtmpi="rtmp://127.0.0.1:1935/in/$name"

echo "-------------Configuration-------------"
echo "input_rtmp: $rtmpi"
echo "output_rtmp: $rtmpe"
echo "timeout=$to seconds"
echo "---------------------------------------"


###############
# Don't touch #
###############
wd=/tmp/streamrip
pfi=$wd/streamrip
offpidfi=$wd/offline_pid
onpidfi=$wd/online_pid
offlo=$wd/offline_lock
onlo=$wd/online_lock

