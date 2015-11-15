#
# Cookbook Name:: dreadnot
# Provider:: stack
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

action :install do
  execute 'stack_npm_install' do
    command 'npm install'
    cwd '/opt/dn-stacks'
    user node['drednot']['user']
    action :nothing
  end

  remote_directory '/opt/dn-stacks' do
    source 'stacks'
    cookbook node['dreadnot']['cookbook']
    notifies :run, 'execute[dn_npm_install]', :immediately
    notifies :restart, 'service[dreadnot]', :delayed
  end
end

def initialize(*args)
  super
end