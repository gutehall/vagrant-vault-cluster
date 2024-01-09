#!/bin/bash

sudo ex +"%s@DPkg@//DPkg" -cwq /etc/apt/apt.conf.d/70debconf
sudo dpkg-reconfigure debconf -f noninteractive -p critical

echo Installing Net-Tools
sudo apt-get install -y net-tools

echo Installing Vault and Consul
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg &&
    gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list &&
    sudo apt update && sudo apt install -y vault consul

sleep 5s
echo Ready To Start the Consul Server.
mkdir consul-dir
consul agent -server -bind=127.0.0.1 -data-dir=consul-dir --node master_consul -server -ui -client=0.0.0.0 -bootstrap-expect=1 >>/dev/null 2>&1 &
sleep 20s
echo Ready To Start the VAULT Server.
vault server -config /vagrant/vault-server.hcl

echo ">>>>>>USE THE BELOW COMMAND TO CHECK THE SERVER STATUS"
echo ">>>>>>vagrant ssh"
echo ">>>>>>vault status"
echo ">>>>>>consul members"
echo ">>>>>>To Acces vault and Consul"
echo ">>>>>>$IP:8200"
echo ">>>>>>$IP:8500"
