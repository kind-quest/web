# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "ubuntu/trusty64"
    # config.vm.network :forwarded_port, guest: 80, host: 8088
    config.vm.network "private_network", ip: "192.168.60.77"
    config.vm.hostname = "kind-quest-vagrant"

    config.vm.synced_folder ".", "/vagrant", id: "vagrant-root",
        owner: "vagrant",
        group: "vagrant",
        mount_options: ["dmode=777,fmode=777"]

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "2048"]
    end

    config.vm.provision :shell, path: "devops/bootstrap.sh", privileged: false

end
