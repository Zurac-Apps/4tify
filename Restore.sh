#!/bin/bash
#  Script.sh
#
#
#  Created by Zane Kleinberg on 4/18/20.
#
set -e
IP=$1
cd support_restore/
./sshtool -k kloader -b pwnediBSS -p 22 $IP &
while !(system_profiler SPUSBDataType 2> /dev/null | grep " Apple Mobile Device" 2> /dev/null); do
    sleep 1
done
set +e
./idevicerestore -e -y custom.ipsw
echo "Done!"
