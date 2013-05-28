#!/bin/bash

set -e

if [ 0 == $# ]; then
    echo "usage: $0 s3_bucket_root";
    exit 1;
fi

BUCKET_ROOT="$1"
URL_ENDPOINT=https://citibikenyc.com/stations/json/
THIS_FILE=`date --utc  +%F-%H-%M`.json



echo "Downloading $URL_ENDPOINT to /tmp/$THIS_FILE"
curl "$URL_ENDPOINT" > "/tmp/$THIS_FILE"

echo "S3 Putting /tmp/$THIS_FILE to $BUCKET_ROOT"
s3cmd put "/tmp/$THIS_FILE" "$BUCKET_ROOT/$THIS_FILE"

rm -rf "/tmp/$THIS_FILE"
