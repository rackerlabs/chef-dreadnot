#
# Cookbook Name:: dreadnot
# Recipe:: vhost
#
# Copyright (C) 2015 Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

configure_htpasswd 'dreadnot' do
  path '/opt/ele-conf/'
  suffix '-htpasswd'
  files(
    node.chef_environment => data_bag_item('htpasswd', 'dev')['users']
  )
end

# install vhost template to the apache dir.
template "#{node['apache']['dir']}/sites-available/dreadnot.conf" do
  source 'dreadnot.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
  variables(dreadnot_servername: node['dreadnot']['name'])
end

# Tell apache to also listen on 8443 - where stunnel used to listen
node.override['apache']['listen_ports'] = %w(80 443 8443)

# Install the vhost and required apache modules
include_recipe 'apache2'
include_recipe 'apache2::mod_status'
include_recipe 'apache2::mod_authz_host'
include_recipe 'apache2::mod_ssl'
include_recipe 'apache2::mod_alias'
include_recipe 'apache2::mod_deflate'
include_recipe 'apache2::mod_headers'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

apache_site 'dreadnot.conf'

apache_site '000-default' do
  enable false
end
