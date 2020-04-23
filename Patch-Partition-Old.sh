#!/bin/bash
#  Script.sh
#
#
#  Created by Zane Kleinberg on 4/18/20.
#
set -e
cd support_files/4.3/File_System
srcdirs=$(find . -name '*TwistedMind2-*')
cd ../../7.1.2/Ramdisk
cd ../../4.3/File_System
echo "Establishing Patching Environment (8s)..."
sleep 8
echo "Sending Patch..."
sleep 2
/usr/bin/expect <(cat << EOF
#log_user 0
set timeout -1
spawn scp -P 2022 ${srcdirs:2} root@localhost:/
expect "root@localhost's password:"
send "alpine\r"
expect eof
)
echo "Sending dd..."
sleep 2
/usr/bin/expect <(cat << EOF
#log_user 0
set timeout -1
spawn scp -P 2022 dd root@localhost:/bin
expect "root@localhost's password:"
send "alpine\r"
expect eof
)
echo "Patching..."
sleep 2
/usr/bin/expect <(cat << EOF
set timeout -1
spawn ssh -o StrictHostKeyChecking=no -p 2022 root@localhost
expect "root@localhost's password:"
send "alpine\r"
expect "sh-4.0#"
send "dd if=${srcdirs:1} of=/dev/rdisk0 bs=8192 \r"
expect "sh-4.0#"
send "ls -la /dev/disk* \r"
expect "sh-4.0#"
send "reboot_bak\r"
expect eof
)
echo "Done!"
