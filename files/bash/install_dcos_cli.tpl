#!/bin/bash
export basepath=$(pwd)
echo $basepath
mkdir -p ~/dcos-cli && cd ~/dcos-cli &&
  curl -O https://bootstrap.pypa.io/get-pip.py &&
  sudo python get-pip.py &&
  sudo pip install virtualenv
echo http://${master_elb_dns_name}
sleep 30
until $(curl --output /dev/null --silent --head --fail http://${master_elb_dns_name}); do
  echo "Waiting for DC/OS to be live and running ..."
  sleep 10
done
curl -O https://downloads.mesosphere.com/dcos-cli/install.sh
sleep 20
until $(curl --output /dev/null --silent --head --fail http://${master_elb_dns_name}); do
  echo "Waiting for DC/OS to be live and running ..."
  sleep 10
done
echo yes | bash ./install.sh . http://${master_elb_dns_name}
source ./bin/env-setup
echo dcos_url = \"http://${master_elb_dns_name}\" >> $HOME/terraform.out
