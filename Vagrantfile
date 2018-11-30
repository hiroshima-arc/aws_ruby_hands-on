# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "hiroshima-arc/amazonlinux2"
  config.vm.box_version = ">=0"
  config.vm.network :private_network, ip:"192.168.33.10"
  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=777']
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
  end
  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    yum install -y docker
    service docker start
    usermod -a -G docker vagrant
    systemctl enable docker
    curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    curl -kL https://bootstrap.pypa.io/get-pip.py | python
    yum install -y git
    yum install -y java-1.8.0-openjdk-headless.x86_64
    yum install -y graphviz
    wget http://jaist.dl.sourceforge.net/project/plantuml/plantuml.jar
    mv plantuml.jar /usr/local/bin
  SHELL
end