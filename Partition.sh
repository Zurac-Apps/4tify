#!/bin/bash
#  Script.sh
#
#
#  Created by Zane Kleinberg on 4/18/20.
#
set -e
IP=$1
rm ~/.ssh/known_hosts
cd support_files/4.3/File_System
/usr/bin/expect <(cat << EOF
set timeout -1
spawn ssh -o StrictHostKeyChecking=no -p 22 root@$IP
expect "root@$IP's password:"
send "alpine\r"
expect "#"
send "TwistedMind2 -d1 3221225472 -s2 879124480 -d2 max\r"
expect "#"
send "exit\r"
expect eof
)
sleep 2
echo "Fetching Patch File"
srcdirs=$(ssh -n -p 22 root@$IP "find / -name '*TwistedMind2-*'")
echo "$srcdirs"
/usr/bin/expect <(cat << EOF
set timeout -1
spawn scp -P 22 root@$IP:$srcdirs $(pwd)
expect "root@$IP's password:"
send "alpine\r"
expect eof
)
echo "Done!"
