#! /bin/bash

sudo yum -y install epel-release
sudo yum -y install borgbackup
sudo yum -y install vim
sudo useradd -m borg
sudo mkdir /home/borg/.ssh
sudo cp /vagrant/id_rsa /home/borg/.ssh/
sudo cp /vagrant/id_rsa.pub /home/borg/.ssh/

export BORG_PASSPHRASE="borg"
borg init --encryption=repokey borg@192.168.56.160:/var/backup/borg
cp /vagrant/BackupScript.sh /opt
sudo chmod +x /opt/BackupScript.sh
echo "*/5 * * * * sudo runuser -l borg -c /opt/BackupScript.sh > /dev/null 2>&1" >> /etc/crontab
