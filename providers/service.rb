#
# Cookbook Name:: dreadnot
# Provider:: service
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

include Dreadnot::Helper

use_inline_resources if defined?(use_inline_resources)

action :enable do
  # htpasswd
  configure_htpasswd 'dreadnot' do
    path node['dreadnot']['dir']
    # suffix '' if new_resource.suffix
  end

  # template
  template node['dreadnot']['config'] do
    owner 'root'
    group 'root'
    mode 00644
    source 'stack.js.erb'
    variables(dreadnot_servername: dreadnot_servername,
              cloudmonitoring_username: node['cloud_monitoring']['raxusername'],
              cloudmonitoring_apikey: node['cloud_monitoring']['raxapikey'],
              ele_buildbot_username: dn_credentials['ele_buildbot_username'],
              ele_buildbot_password: dn_credentials['ele_buildbot_password'],
              agent_buildbot_username: dn_credentials['agent_buildbot_username'],
              agent_buildbot_password: dn_credentials['agent_buildbot_password'],
              pagerduty_api_key: dn_credentials['pagerduty_api_key'])
  end

  # vhost

  # cleanup

  # bundle & link

  # service
  poise_service_user 'www-data'

  poise_service 'apache2' do
    command '/usr/sbin/apache2 -f /etc/apache2/apache2.conf -DFOREGROUND'
    directory node['dreadnot']['dir']
    environment HOME: "/home/ele-#{node['ele']['env']}-dreadnot"
  end
end

action :disable do
  poise_service 'dreadnot' do
    action [:disable, :stop]
  end
end

def initialize(*args)
  super
end
