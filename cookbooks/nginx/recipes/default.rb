#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx' do
  action :install
end

file "generate_ssl_certificates" do
  action :create_if_missing
  notifies :run, "bash[generate_ssl_certificates]", :immediately
end

bash "generate_ssl_certificates" do
  cwd node[:nginx][:path]
  code <<-EOH
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout #{node[:nginx][:crt_k_path]} -out #{node[:nginx][:crt_path]} -subj "/C=LV/ST=None/L=Riga/O=Dis/CN=www.example.com"
  EOH
  action :nothing
end

file "update_nginx_config" do
  action :create_if_missing
  notifies :create, "template[#{node[:nginx][:template_config]}]", :immediately
end

template node[:nginx][:template_config] do
  path node[:nginx][:config_path]
  source "#{node[:nginx][:template_config]}.erb"
  owner "root"
  group "root"
  mode "0744"
  action :nothing
end

service "nginx" do
  action [ :enable, :restart ]
end