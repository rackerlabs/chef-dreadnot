#
# Cookbook Name:: test
# Recipe:: default
#
# License:: Apache License, Version 2.0
#

dreadnot_service 'default' do
  action [:create, :start]
end

dreadnot_config 'default' do
  notifies :restart, 'dreadnot_service[default]'
  action :create
end
