Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.hostname = "debian"

  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "dns-paso-a-paso-nueva"
    vb.memory = 1024
    vb.cpus = 1
  end

  config.vm.provision "shell", path: "config/01_install_dns.sh"
  config.vm.provision "shell", path: "config/02_configure_dns.sh"
  config.vm.provision "shell", path: "config/03_test_dns.sh", privileged: true
end
