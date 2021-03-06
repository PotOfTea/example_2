default['linux_metrics']['name'] 			= "linux_metrics"
default['linux_metrics']['user'] 			= node['linux_metrics']['name']
default['linux_metrics']['group']			= node['linux_metrics']['name']
default['linux_metrics']['file']      		= "gather_stats.py"
default['linux_metrics']['dir']       		= "/opt/#{node['linux_metrics']['name']}"
default['linux_metrics']['full_path'] 		= "#{node['linux_metrics']['dir']}/#{node['linux_metrics']['file']}"
default['linux_metrics']['upstart']			= "#{node['linux_metrics']['name']}.upstart.conf"
default['linux_metrics']['upstart_path']	= "/etc/init/#{node['linux_metrics']['name']}.conf"
