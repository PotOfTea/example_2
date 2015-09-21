#
# Cookbook Name:: dashboard
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package ["ruby1.9.1-dev", "nodejs", "g++"] do
  action :install
end

gem_package "dashing" do
  options("--no-ri --no-rdoc")
  action :install
end
gem_package "bundler" do
  options("--no-ri --no-rdoc")
  action :install
end

group node['dashboard']['group']

user node['dashboard']['user'] do
  group node['dashboard']['group']
  action :create
  system true
  shell "/bin/bash"
end

directory node['dashboard']['dir'] do
  owner node['dashboard']['user']
  mode "0755"
  action :create
end

cookbook_file node['dashboard']['tmp_path'] do
  source node['dashboard']['tar']
  owner node['dashboard']['user']
  group node['dashboard']['group']
  mode "0755"
  action :create_if_missing
end

bash "extract_dashboard" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxf #{node['dashboard']['tmp_path']} -C #{node['dashboard']['dir']}
  EOH
  not_if { ::File.exists?("#{node['dashboard']['dir']}/Gemfile") }
end

file "install_dashboard_dep" do
  action :create_if_missing
  notifies :run, "bash[install_gem_denpendecies]", :immediately
end

bash "install_gem_denpendecies" do
  cwd node['dashboard']['dir']
  code <<-EOH
    bundle
  EOH
  action :nothing
end

service "dashboard" do
  provider Chef::Provider::Service::Upstart
  subscribes :restart, resources(:bash => "install_gem_denpendecies")
  supports :restart => true, :start => true, :stop => true
end


template node['dashboard']['upstart']  do
  path node['dashboard']['upstart_path']
  source "#{node['dashboard']['upstart']}.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
  notifies :restart, "service[#{node['dashboard']['name']}]"
end

service node['dashboard']['name'] do
  action [:enable, :start]
end