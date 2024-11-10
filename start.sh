  GNU nano 7.2                                                                            start.sh                                                                                      
#!/bin/bash

# Get the desired device serial number from an environment variable
DEVICE_SERIAL=${DEVICE_SERIAL:-00000001}

# Find the device index using rtl_test and awk based on serial number
DEVICE_INDEX=$(rtl_test -t 2>&1 | awk -v serial="$DEVICE_SERIAL" '$0 ~ serial {print $1}' | tr -d ':')

if [ -z "$DEVICE_INDEX" ]; then
  echo "No device with serial number $DEVICE_SERIAL found."
  exit 1
fi

echo "Using device index $DEVICE_INDEX for serial number $DEVICE_SERIAL."

set -e

nginx -g 'pid /tmp/nginx.pid;' -c '/nginx.conf'
mkdir -p '/run/dump1090'

# Run Dump1090 with the specified device serial
/usr/bin/dump1090 --device-index $DEVICE_INDEX "$@" --quiet --net --forward-mlat --write-json '/run/dump1090'
