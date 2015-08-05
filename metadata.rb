name 'dreadnot'
maintainer 'Michael Burns'
maintainer_email 'michael.burns@rackspace.com'
license 'Apache 2.0'
description 'Installs/Configures dreadnot'
long_description 'Installs/Configures dreadnot'
version '0.1.0'

recipe 'dreadnot', 'Installs dreadnot'

depends 'cleanup'
depends 'htpasswd'
depends 'nodejs'
depends 'poise-service-runit'

%w(ubuntu debian freebsd centos redhat fedora amazon scientific).each do |os|
  supports os
end
