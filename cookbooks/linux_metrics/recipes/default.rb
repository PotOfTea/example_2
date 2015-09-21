#
# Cookbook Name:: linux_metrics
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group node['linux_metrics']['group']

user node['linux_metrics']['user'] do
  group node['linux_metrics']['group']
  action :create
  system true
  shell "/bin/bash"
end

directory node['linux_metrics']['dir'] do
  owner node['linux_metrics']['user']
  mode "0755"
  action :create
end

package ["python-pip"] do
  action :install
end

template node['linux_metrics']['file'] do
  path node['linux_metrics']['full_path']
  source "#{node['linux_metrics']['file']}.erb"
  owner node['linux_metrics']['user']
  group node['linux_metrics']['group']
  mode "0744"
  action :create_if_missing
  #not_if { ::File.exists?(node['linux_metrics']['full_path']) }
end

file "install_python_dep" do
  action :create_if_missing
  notifies :run, "bash[install_python_denpendecies]", :immediately
end

bash "install_python_denpendecies" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    pip install linux_metrics
  EOH
  action :nothing
end


service node['linux_metrics']['name'] do
  provider Chef::Provider::Service::Upstart
  subscribes :restart, resources(:bash => "install_python_denpendecies")
  supports :restart => true, :start => true, :stop => true
end

template node['linux_metrics']['upstart']  do
  path node['linux_metrics']['upstart_path']
  source "#{node['linux_metrics']['upstart']}.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :restart, "service[#{node['linux_metrics']['name']}]"
end

service node['linux_metrics']['name'] do
  action [:enable, :start]
end