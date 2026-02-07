Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.hostname = "udemx-devops"
  config.vm.network "private_network", ip: "192.168.56.50"

  config.vm.provider :libvirt do |lv|
    lv.memory = 16384
    lv.cpus = 6
    lv.nested = true
    lv.storage :file, size: '20G', path: 'vdb.img', bus: 'virtio'
    lv.storage :file, size: '20G', path: 'vdc.img', bus: 'virtio'
  end

  config.vm.synced_folder ".", "/vagrant",
    type: "rsync",
    rsync__auto: true

  config.vm.provision "shell", inline: <<-SHELL
    mkfs.ext4 -F /dev/vdb
    mount /dev/vdb /opt
    chmod 0755 /opt
    echo '/dev/vdb /opt ext4 defaults 0 2' >> /etc/fstab
    mkfs.ext4 -F /dev/vdc
    mount /dev/vdc /tmp
    chmod 1777 /tmp
    echo '/dev/vdc /tmp ext4 defaults 0 2' >> /etc/fstab
  SHELL

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.inventory_path = "ansible/inventory.ini"
    ansible.limit = "all"
  end
end
