# 4tify - v0.1_beta
iOS 4 Dualbooting Made Simple By @zzanehip

## What and Why?

* In my opinion, iOS 4 has always been the illusive iOS. Methods to install it are either dificult to find, or dificult to use.
* Which is ironic, I honestly belive iOS 4 is the gold standard of iOS.
* The goal in this project is to make running iOS 4 less of challenge, and more of a convient reality. 
* Why dualbooting? Simple, keep your most up to date iOS, but still be able to use a cherished iOS.
* This is still very much an early phase project, use this at *your own risk.* If you have any issues, or find any bugs please report them. I hope to simplify the process even further as well.
* I hope this brings a little you a little joy while you're cooped up inside ;)  

## What's Supported
* iPhone 4 (3,1)
	* iOS 4.3
* Tested on Mac OS 10.13-10.15

This is by all means extremely limited right now. It's my goal to work on getting most what's soon to come done fairly quickly. This is still early stages, so stay tuned.

## Soon to Come (Probably in this Order)
* iPhone 4 (3,1)
	* iOS 4.3.1 - 4.3.5
* iPhone 4 (3,3)
	* iOS 4.3 - 4.3.5	 
* iPhone 3gs (2,1) 
	* iOS 4.3 - 4.3.5
* iPad 1 (1,1)
	* iOS 4.3 - 4.3.5
* Possibly iPad 2 (2,1) and (2,2)
	* iOS 4.3 - 4.3.5
	* This is dependent on ssh ramdisk support for a5
* More primary (7.x, 6.x, 5.x) OS support. 

#  Instructions:

- Before starting, ensure your phone is Jailbroken with a tfp0 exploit, and OpenSSH + Core Utilities + Core Utilities (/bin) Installed.
- While conducting the process, keep your phone plugged into your computer (obviously).
- Keep your root password as alpine throughout the process. 
- Lastly, don't be dismayed if you see errors with ipwndfu (USB Error 5, etc) when loading in to Ramdisk, just keep retrying, ipwndfu is really finicky.


##  1. Restore and Jailbreak:
We need to get our device onto a modified version of iOS 7.1.2 with lwvm patched out and replaced with GPT. Afterwards, we need to jailbreak it. Before you start, make sure you are jailbroken, have Core Utilities installed, and OpenSSH.

1. First, build patched IPSW and grab blobs:			
`./Create-Restore.sh <Decimal-ECID> `
2. Restore to IPSW (If the restore process doesn't start after e.g. fish: storing file 65536 (65536) just click your home button):		
`./Restore.sh <ip-address>`
3. Set up your device.
4. We need to use SSH Ramdisk to Jailbreak, but as of right now the orginal tool doesn't wok on the latest versions of Mac OS. I managed to fix this by making my own version. (It might take a few tries to get this going, ipwndfu tends to error out.)*:		
`./Jailbreak.sh`	
5. Done, you should see Cydia on your Springboard, open it, and let it do it's thing. Reopen, click upgrade essential (you might have to open and close a few times).		

**Note, if you're doing this process on a version of Mac OS where @msft_guy's SSH Ramdisk does work, just launch the jar, let it do it's thing, and run Jailbreak-Old.sh. Once it's done, exit recovery mode with your tool of choice.*

##  2. iOS 4 and the Second Partition:
Now, we'll partition our device, install iOS 4, and patch it. Once this is done, you'll be good to go!

1. First, we'll partition the device (It will ask for your root password twice to confirm, as always, enter alpine):		
`./Partition.sh <ip-address>`
2. Next, we'll boot into SSH Ramdisk and perform patch our new partition (It might take a few tries to get this going, ipwndfu tends to error out.):*	
`./Patch-Partition.sh`
3. Lastly, we'll initalize our partition, build our filesystem, restore it, and patch it. This step generally takes about an hour, so just sit back and relax:	
`./ios4.sh <ip-address>`
4. That's it, your done, and your device will respring. To boot into iOS 4, lauch the 4tify app. Once your screen goes black wait a sec, then tap your homebutton, and should see your device start to verbose boot within 10-15 seconds.

**Same note as above, if @msft_guy's SSH Ramdisk does work, just launch the jar, let it do it's thing, and run Patch-Partition-Old.sh*

## Thanks to:
* @Nyansatan for most of this proccess and the support. I merely modified their process and packed it into a (convienent) tool so that it could be utilized by more people.
* @winocm and @xerub for kloader.
* @ShadowLee19 for useful info. 
* @msft_guy for ssh ramdisk.
* @axi0mx for ipwndfu.
* @Billy-Ellis for runasroot.
* @Tommymossss for entertaining me while I made this.
 
