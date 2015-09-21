group node[:webservice][:group]

user node[:webservice][:user] do
  group node[:webservice][:group]
  action :create
  system true
  shell "/bin/bash"
end

directory node[:webservice][:dir] do
  owner node[:webservice][:user]
  mode "0755"
  action :create
end

cookbook_file node[:webservice][:jar_path] do
  source node[:webservice][:jar]
  owner node[:webservice][:user]
  group node[:webservice][:group]
  mode "0755"
  action :create_if_missing
end

package ["openjdk-7-jre-headless"] do
  action :install
end

service node[:webservice][:name] do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
end

template node[:webservice][:upstart]  do
  path node[:webservice][:upstart_path]
  source "#{node[:webservice][:upstart]}.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => node[:webservice][:name])
end

service node[:webservice][:name] do
  action [:enable, :start]
end