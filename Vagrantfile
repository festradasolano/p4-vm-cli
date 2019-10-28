# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Required plugins
  config.vagrant.plugins = "vagrant-disksize"
  # Box config
  config.vm.box = "ubuntu/xenial64"
  config.disksize.size = "20GB"
  # Guest config
  config.vm.hostname = "p4"
  config.vm.define "p4-vm-cli"
  # SSH config
  config.ssh.forward_x11 = true
  # Provider config
  config.vm.provider "virtualbox" do |vb|
    vb.name = "p4-vm-cli"
    # Keep 4096 of memory for 2 CPUs for avoiding compiling errors; can change to 2048
    # of memory after initial installation. Otherwise, assign only 1 CPU.
    vb.memory = 4096
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    vb.customize ["modifyvm", :id, "--nic1", "nat"]
    vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "vboxnet0"]
  end
  # File provisioning
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.provision "file", source: "p4.vim", destination: "/home/vagrant/p4.vim"
  config.vm.provision "shell", path: "root-bootstrap.sh"
  config.vm.provision "shell", privileged: false, path: "user-bootstrap.sh"
end
