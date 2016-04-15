#
# Cookbook Name:: dreadnot
# Recipe:: default
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

include_recipe 'dreadnot::bundle'

# Apache Virtualhost
include_recipde 'dreadnot::vhost'

runit_service 'dreadnot' do
  owner 'daemon'
  group 'daemon'
  finish true
  options(
    username: node['dreadnot']['user'],
    servicename: 'dreadnot'
  )
  env(
    HOME: node['dreadnot']['homedir']
  )
end

# Open Firewall
iptables_rule 'ports_dreadnot' unless node.roles.include?('dev')
