#!/bin/bash
#!/bin/bash
sudo apt-get update
sudo apt-get install socat
sudo rpi-update

chmod a+x ./camServer.sh

crontab -l > cronlocal
echo -n "@reboot " >> cronlocal
find "$(pwd)" -name camServer.sh >> cronlocal
crontab cronlocal

sudo reboot
