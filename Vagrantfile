# Vagrant.configure(2) do |config|
#     config.vm.box = "solidnerd/vault"
#     config.vm.synced_folder ".", "/vagrant"

#     config.vm.define "vault" do |control|
#         control.vm.hostname = "vault"
#         control.vm.network "public_network", bridge: [
#             "en0: Wi-Fi (AirPort)",    
#             "en1: Wi-Fi (AirPort)",
#         ]
#         control.vm.provider "virtualbox" do |v|
#             v.customize ["modifyvm", :id, "--name", "vault"]
#             v.memory = 2048
#             v.cpus = 1
#         end
#         control.vm.provision "shell", inline: <<-SHELL
#             cd /vagrant
#             # chmod +x ./processing.sh
#             # ./processing.sh
#             mkdir -p vault/data
#             mkdir log
#             vault server -config=config.hcl
#         SHELL
#     end
# end

Vagrant.configure(2) do |config|
    config.vm.box = "generic/debian10"
    # config.ssh.username = 'root'
    # config.ssh.password = 'vagrant'
    # config.ssh.insert_key = 'true'
    # config.vm.synced_folder ".", "/vagrant"

    config.vm.define "vault" do |control|
        control.vm.hostname = "vault"
        control.vm.network "public_network", bridge: [
            "en0: Wi-Fi (AirPort)",    
            "en1: Wi-Fi (AirPort)",
        ]
        control.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--name", "vault"]
            v.memory = 2048
            v.cpus = 1
        end
        control.vm.provision "shell", inline: <<-SHELL
	        sudo apt install net-tools
        SHELL
    end
end
