#
# Cookbook Name:: dreadnot
# Recipe:: bundle
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

cleanup '/usr/src/dn-bundle*.tar.gz' do
  keep_last 3
  except "/usr/src/dn-bundle-#{node['dreadnot']['version']}.tar.gz"
end

cleanup '/opt/dn-bundle-*' do
  keep_last 3
  except "/opt/dn-bundle-#{node['dreadnot']['version']}"
end

remote_file "/usr/src/dn-bundle-#{node['dreadnot']['version']}.tar.gz" do
  source node['dreadnot']['bundle_url']
  mode 00600
  action :create_if_missing
end

untar_archive 'dn-bundle' do
  path "/usr/src/dn-bundle-#{node['dreadnot']['version']}.tar.gz"
  container_path '/opt'
  creates "/opt/dn-bundle-#{node['dreadnot']['version']}/lib"
  notifies :run, 'execute[dn_npm_install]', :immediately
end

execute 'dn_npm_install' do
  command 'npm install'
  cwd "/opt/dn-bundle-#{node['dreadnot']['version']}"
  user "ele-#{node.chef_environment}-dreadnot"
  action :nothing
end

link 'dn-bundle' do
  target_file '/opt/dn'
  to "/opt/dn-bundle-#{node['dreadnot']['version']}"
  %w(dreadnot).each do |service|
    if ::File.exist?("/service/#{service}")
      notifies :restart, "service[#{service}]", :delayed
    end
  end
end
