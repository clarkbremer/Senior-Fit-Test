# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "precise64"
  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.1.200"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get -y install curl
  SHELL

 config.vm.provision :shell, :path => "vagrant_setup/pg_bootstrap.sh"
 config.vm.provision :shell, :path => "vagrant_setup/install-rvm.sh",  :args => "stable", :privileged => false
 config.vm.provision :shell, :path => "vagrant_setup/install-ruby.sh", :args => "2.2.1", :privileged => false

end
