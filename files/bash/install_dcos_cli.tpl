#!/bin/bash
export basepath=$(pwd)
echo $basepath
mkdir -p ~/dcos-cli && cd ~/dcos-cli &&
  curl -O https://bootstrap.pypa.io/get-pip.py &&
  sudo python get-pip.py &&
  sudo pip install virtualenv
echo http://${master_alb_dns_name}
sleep 30
until $(curl --output /dev/null --silent --head --fail http://${master_alb_dns_name}); do
  echo "Waiting for DC/OS to be live and running ..."
  sleep 10
done
curl -O https://downloads.mesosphere.com/dcos-cli/install.sh
sleep 20
until $(curl --output /dev/null --silent --head --fail http://${master_alb_dns_name}); do
  echo "Waiting for DC/OS to be live and running ..."
  sleep 10
done
echo yes | bash ./install.sh . http://${master_alb_dns_name}
source ./bin/env-setup
dcos config set core.dcos_url http://${dcos_username}:${dcos_password}@${master_alb_dns_name}
dcos config show
dcos auth login
pwd
sleep 10
echo $basepath
cd $basepath
dcos config show core.dcos_acs_token > dcos_acs_token.txt
echo dcos_url = \"http://${master_alb_dns_name}\" >> $HOME/terraform.out
echo dcos_acs_token = \"$(cat dcos_acs_token.txt)\" >> $HOME/terraform.out
