#!/bin/bash
set -e
IP=$1
cd support_files/4.3/File_System
echo "Sending runasroot "
/usr/bin/expect <(cat << EOF
set timeout -1
spawn scp -P 22 -o StrictHostKeyChecking=no runasroot root@$IP:/usr/bin
expect "root@$IP's password:"
send "alpine\r"
expect eof
)
echo "Sending Boot..."
/usr/bin/expect <(cat << EOF
set timeout -1
spawn scp -P 22 -o StrictHostKeyChecking=no boot.sh root@$IP:/
expect "root@$IP's password:"
send "alpine\r"
expect eof
)
cd ../App
echo "Sending App..."
/usr/bin/expect <(cat << EOF
set timeout -1
spawn scp -P 22 -o StrictHostKeyChecking=no -r 4tify.app root@$IP:/Applications
expect "root@$IP's password:"
send "alpine\r"
expect eof
)
echo "Moving Everything Into Place..."
sleep 2
/usr/bin/expect <(cat << EOF
set timeout -1
spawn ssh -o StrictHostKeyChecking=no -p 22 root@$IP
expect "root@$IP's password:"
send "alpine\r"
expect "#"
send "chmod 6755 /Applications/4tify.app/4tify\r"
expect "#"
send "chmod 4755 /usr/bin/runasroot\r"
expect "#"
send "chown root:wheel /usr/bin/runasroot\r"
expect "#"
send "chmod 6755 /usr/bin/runasroot\r"
expect "#"
send "chmod 6755  /boot.sh\r"
expect "#"
send "exit\r"
expect eof
)
sleep 2
/usr/bin/expect <(cat << EOF
set timeout -1
spawn ssh -o StrictHostKeyChecking=no -p 22 mobile@$IP
expect "mobile@$IP's password:"
send "alpine\r"
expect "mobile"
send "uicache\r"
expect "mobile"
send "exit\r"
expect eof
)
sleep 2
/usr/bin/expect <(cat << EOF
set timeout -1
spawn ssh -o StrictHostKeyChecking=no -p 22 root@$IP
expect "root@$IP's password:"
send "alpine\r"
expect "#"
send "killall -9 SpringBoard\r"
expect "#"
send "exit\r"
expect eof
)
echo "Done!"
