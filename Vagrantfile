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

Vagrant.configure("2") do |config|
  config.vm.provision "shell", inline: $script

  config.vm.box = "ubuntu/jammy64"
  #config.vm.box = "bento/ubuntu-22.04-arm64"
  #config.vm.box_check_update = false

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # NOTE: This will enable public access to the opened port

  config.vm.network "forwarded_port", guest: 8200, host: 8200
  config.vm.network "forwarded_port", guest: 8500, host: 8500
  #config.vm.network "forwarded_port", guest: 2183, host: 2183
  #config.vm.network "forwarded_port", guest: 3000, host: 3000
  #config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  #config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.network "public_network"

  #config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
    vb.check_guest_additions = false
end

config.vm.provider "parallels" do |prl|
    prl.memory = 4096
    prl.cpus = 2
    prl.update_guest_tools = false
end
  
    # View the documentation for the provider you are using for more
    # information on available options.
    # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.

  #config.vm.provision "shell", inline: <<-SHELL
  #  apt-get update
  #  apt-get install -y apache2
  #SHELL
end