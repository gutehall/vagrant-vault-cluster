Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04-arm64"
  #config.vm.box_check_update = false

  config.vm.provision "shell", inline: "dpkg-reconfigure --frontend noninteractive tzdata"
  config.vm.provision "file", source: "vault-server.hcl", destination: "/vagrant/vault-server.hcl"
  config.vm.provision "shell", path: "install.sh"

  config.vm.network "forwarded_port", guest: 8200, host: 8200
  config.vm.network "forwarded_port", guest: 8500, host: 8500
  config.vm.network "forwarded_port", guest: 2183, host: 2183
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  #config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.network "public_network"

  #config.vm.synced_folder "../data", "/vagrant_data"

  # config.vm.provider "virtualbox" do |vb|
  #   vb.memory = 4096
  #   vb.cpus = 2
  #   vb.check_guest_additions = false
  # end

  config.vm.provider "parallels" do |prl|
    prl.memory = 4096
    prl.cpus = 2
    prl.update_guest_tools = false
  end
end