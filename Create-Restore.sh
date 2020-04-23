#!/bin/bash
set -e
ECID=$1
cd support_restore/
echo "Fetching Blobs for:" $ECID
./tsschecker -d iPhone3,1 -i 7.1.2 -s --save-path shsh/ -e $ECID --boardconfig N90AP
for file in shsh/*.shsh2
do
   mv "$file" "shsh/$ECID-iPhone3,1-7.1.2.shsh"
done
echo "Downloading 7.1.2 IPSW..."
curl -O https://secure-appldnld.apple.com/iOS7.1/031-4812.20140627.cq6y8/iPhone3,1_7.1.2_11D257_Restore.ipsw --progress-bar
echo "Patching IPSW.."
./ipsw iPhone3,1_7.1.2_11D257_Restore.ipsw custom.ipsw -memory
./xpwntool `unzip -j custom.ipsw 'Firmware/dfu/iBSS*' | awk '/inflating/{print $2}'` pwnediBSS
mv `unzip -j custom.ipsw 'Firmware/dfu/iBEC*' | awk '/inflating/{print $2}'` pwnediBEC
echo "Patching Devicetree"
cd ../support_files/7.1.2/Restore/
zip -d -qq ../../../support_restore/custom.ipsw "Downgrade/DeviceTree.n90ap.img3"
zip -qq ../../../support_restore/custom.ipsw Downgrade/DeviceTree.n90ap.img3
echo "Done!"
