default['nginx']['name'] 				= "nginx"
default['nginx']['user'] 				= node['nginx']['name']
default['nginx']['group'] 				= node['nginx']['name']
default['nginx']['path'] 				= "/etc/nginx"
default['nginx']['config_path'] 		= "#{node['nginx']['path']}/sites-available/default"
default['nginx']['crt_k_path'] 			= "#{node['nginx']['path']}/cert.key"
default['nginx']['crt_path'] 			= "#{node['nginx']['path']}/cert.crt"
default['nginx']['template_config']		= node['nginx']['name']