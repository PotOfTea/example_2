#Dashing parameters
default['dashboard']['name'] 			= "dashboard"
default['dashboard']['dir']       		= "/opt/#{node['dashboard']['name']}"
default['dashboard']['tar']       		= "#{node['dashboard']['name']}.tar.gz"
default['dashboard']['tmp_path'] 		= "#{Chef::Config["file_cache_path"]}/#{node['dashboard']['tar']}"
default['dashboard']['log_dir']   		= "/var/log/#{node['dashboard']['name']}"
default['dashboard']['loglevel']  		= "info"
default['dashboard']['user']      		= node['dashboard']['name']
default['dashboard']['group']     		= node['dashboard']['name']
default['dashboard']['upstart']      	= "#{node['dashboard']['name']}.upstart.conf"
default['dashboard']['upstart_path']	= "/etc/init/#{node['dashboard']['name']}.conf"
