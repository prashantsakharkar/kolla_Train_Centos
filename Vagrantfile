# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
     config.vm.define "compute" do |compute|
     compute.vm.provider :libvirt do |compute|
        compute.machine_virtual_size = 100
        compute.cpus = 4
        compute.cputopology :sockets => '2', :cores => '2', :threads => '1'
        compute.memory = 8140
    end

    compute.vm.box = "generic/centos7"
    compute.vm.hostname = "compute"
    compute.vm.network "public_network", :type => "bridge", :dev => "br0", :ip => "172.172.3.238", :netmask => "255.255.255.0", :gateway => "172.172.3.1"
    compute.vm.network "public_network", :type => "bridge", :dev => "virbr2", :ip => "10.10.10.238", :netmask => "255.255.0.0", :gateway => "10.10.10.1"
    compute.vm.network "public_network", :type => "bridge", :dev => "br0", auto_config: true, use_dhcp_assigned_default_route: true
    compute.vm.provision "shell",run: "always",inline: "route add default gw 172.172.3.1 dev eth1"
    compute.vm.provision :shell, :path => "prerequi.sh"
    #compute.vm.provision :reload
    compute.vm.provision :shell, :path => "disk-extend.sh"
    compute.vm.provision :shell, :path => "epel.sh"
    compute.vm.provision :shell, :path => "enable-root-login.sh"
    compute.vm.provision :shell, :path => "computedep.sh"
    end

    config.vm.define "controller" do |controller|
    controller.vm.provider :libvirt do |libvirt|
        libvirt.machine_virtual_size = 100
        libvirt.cpus = 12
        libvirt.storage :file, :size => '40G', :device => 'vdb', :type => 'raw'
        libvirt.cputopology :sockets => '4', :cores => '3', :threads => '1'
        libvirt.memory = 12240
    end

    controller.vm.box = "generic/centos7"
    controller.vm.hostname = "controller"
    controller.vm.network "public_network", :type => "bridge", :dev => "br0", :ip => "172.172.3.239", :netmask => "255.255.255.0", :gateway => "172.172.3.1"
    controller.vm.network "public_network", :type => "bridge", :dev => "virbr2", :ip => "10.10.10.239", :netmask => "255.255.0.0",:gateway => "10.10.10.1"
    controller.vm.network "public_network", :type => "bridge", :dev => "br0", auto_config: true, use_dhcp_assigned_default_route: true
    controller.vm.provision "shell",run: "always",inline: "route add default gw 172.172.3.1 dev eth1"
    controller.vm.provision :shell, :path => "prerequi.sh"
    #controller.vm.provision :reload
    controller.vm.provision :shell, :path => "epel.sh"
    controller.vm.provision :shell, :path => "disk-extend.sh"
    controller.vm.provision :shell, :path => "enable-root-login.sh"
    controller.vm.provision :shell, :path => "sshpass"
    controller.vm.provision :shell, :path => "dependecy.sh"
    controller.vm.provision :shell, :path => "docker.sh"
    controller.vm.provision :shell, :path => "Kolla-ansible.sh"
    controller.vm.synced_folder "/mnt/build-vault/file-manager", "/opt/file-manager",type: "rsync"
    controller.vm.provision :shell, :path => "createresources.sh"
    controller.vm.provision :shell, :path => "policy.sh"
    end

# The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
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
