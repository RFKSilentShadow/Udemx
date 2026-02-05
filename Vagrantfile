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

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.inventory_path = "ansible/inventory.ini"
    ansible.limit = "all"
  end
end
