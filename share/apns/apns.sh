#!/bin/sh

token="YOUR TOKEN HERE"
pemfile="PEM FILE PATH HERE"
bundleIdentifier="BUNDLE IDENTIFIER HERE"
data='{"aps":{"alert":"Push Alert Contnet","sound":"default"}}'
debug=true

CMDNAME=`basename $0`
if [ ! -e $pemfile ]; then
    echo "$CMDNAME pem:$pemfile is not found"
    exit 1
fi

appleUri=""
if $debug; then
  appleUri="https://api.development.push.apple.com/3/device/"
else
  appleUri="https://api.push.apple.com/3/device/"
fi

curl -v \
-d ${data} \
-H "apns-priority: 10" \
-H "apns-expiration: 0" \
-H "apns-topic: ${bundleIdentifier}" \
--http2 \
--cert ${pemfile} \
${appleUri}${token}
