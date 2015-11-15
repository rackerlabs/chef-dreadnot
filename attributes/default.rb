# Encoding: utf-8

default['dreadnot']['user'] = 'dreadnot'
default['dreadnot']['group'] = 'dreadnot'
default['dreadnot']['home'] = "/home/#{node['dreadnot']['user']}"

default['dreadnot']['dir'] = '/opt/dreadnot'
default['dreadnot']['config'] = '/opt/dreadnot/settings.js'
default['dreadnot']['instance_prefix'] = '/opt/dreadnot/instances'

# default['dreadnot']['embedded_stacks'] = false
# default['dreadnot']['install_nodejs'] = true

default['dreadnot']['domain'] = 'example.com'
# default['dreadnot']['port'] = 8000
default['dreadnot']['port'] = 8443

default['dreadont']['version'] = ''

default['dreadnot']['bundle_url'] = ''
default['dreadnot']['stack_url'] = ''
