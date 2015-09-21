default['webservice']['name'] 			= "webservice"
default['webservice']['user'] 			= node['webservice']['name']
default['webservice']['group'] 			= node['webservice']['name']
default['webservice']['dir'] 			= "/opt/#{node['webservice']['name']}"
default['webservice']['jar'] 			= "rs-webservice-1.0-jar-with-dependencies.jar"
default['webservice']['jar_path'] 		= "#{node['webservice']['dir']}/#{node['webservice']['jar']}"
default['webservice']['bind']			= "http://#{node['webservice']['ip']}"
default['webservice']['service'] 		= "ws/passgen"
default['webservice']['url_full'] 		= "http://#{node['webservice']['ip']}:#{node['webservice']['port']}/#{node['webservice']['service']}"
default['webservice']['dashboard_url'] 	= "http://#{node['dashboard']['ip_ext']}:#{node['dashboard']['port']}/widgets/request_count"
default['webservice']['upstart']      	= "#{node['webservice']['name']}.upstart.conf"
default['webservice']['upstart_path']	= "/etc/init/#{node['webservice']['name']}.conf"
