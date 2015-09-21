# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
	config.vm.define :dashboard do |dashboard_config|
	  dashboard_config.vm.hostname = "dashboard"
	  dashboard_config.vm.box = "ubuntu/trusty64"
	  dashboard_config.vm.network :forwarded_port, guest: 9090, host: 9090
	  dashboard_config.vm.network :forwarded_port, guest: 443, host: 443
	  dashboard_config.vm.network :forwarded_port, guest: 8888, host: 8888
	  dashboard_config.vm.network :private_network, ip: "10.0.15.10"
	  dashboard_config.vm.provider "virtualbox" do |vb|
		vb.memory = "512"
	  end
	  dashboard_config.vm.provision "chef_solo" do |chef|
	  	chef.version = "12.4.1"
		chef.log_level = :debug
		chef.roles_path = "roles"
    	chef.add_role("config")
    	chef.add_recipe "apt"
		chef.add_recipe "dashboard"
		chef.add_recipe "linux_metrics"
    	chef.add_recipe "nginx"
	  end
	end
	
	config.vm.define :webservice do |wbservice_config|
	  wbservice_config.vm.box = "ubuntu/trusty64"
	  wbservice_config.vm.hostname = "webservice"
	  wbservice_config.vm.network :private_network, ip: "10.0.15.11"
	  wbservice_config.vm.provider "virtualbox" do |vb|
		vb.memory = "512"
	  end
	  wbservice_config.vm.provision "chef_solo" do |chef|
	  	chef.version = "12.4.1"
		chef.log_level = :debug
		chef.roles_path = "roles"
    	chef.add_role("config")
    	chef.add_recipe "apt"
		chef.add_recipe "webservice"
	  end
	end
end
