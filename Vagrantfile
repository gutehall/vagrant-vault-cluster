# -*- mode: ruby -*-
# vi: set ft=ruby :
$script = <<-SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
echo Installing Vault...
sudo apt-get update && sudo apt-get -y install vault
echo Installing Consul...
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get -y install consul
IP=$(ifconfig | awk -F '[:]' '/inet addr/ { print $3 }' | cut -d ' ' -f 1 | awk 'NR==2')
cat > /vagrant/vault-server.hcl <<EOF
disable_mlock = true
ui            = true
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = "true"
}
storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault/"
}
EOF
sleep 5s ; echo Ready To Start the Consul Server.
mkdir consul-dir
consul agent -server -bind=127.0.0.1 -data-dir=consul-dir --node master_consul -server -ui -client=0.0.0.0 -bootstrap-expect=1 >> /dev/null 2>&1 &
sleep 20s ; echo Ready To Start the VAULT Server.
vault server -config /vagrant/vault-server.hcl
echo ">>>>>>USE THE BELOW COMMAND TO CHECK THE SERVER STATUS"
echo ">>>>>>vagrant ssh"
echo ">>>>>>vault status"
echo ">>>>>>consul members"
echo ">>>>>>To Acces vault and Consul"
echo ">>>>>>$IP:8200"
echo ">>>>>>$IP:8500"
SCRIPT
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: $script
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  config.vm.network "forwarded_port", guest: 8200, host: 8200
  config.vm.network "forwarded_port", guest: 8500, host: 8500
  #config.vm.network "forwarded_port", guest: 2183, host: 2183

  #config.vm.network "forwarded_port", guest: 3000, host: 3000
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"
  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
      vb.memory = "4096"
  #   # Customize the amount of memory on the VM:
  #
   end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end