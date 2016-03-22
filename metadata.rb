name 'rubyzip'
maintainer 'John Bellone'
maintainer_email 'jbellone@bloomberg.net'
license 'Apache 2.0'
description 'Library cookbook which installs and configures rubyzip.'
long_description 'Library cookbook which installs and configures rubyzip.'
version '1.2.2'

supports 'centos'
supports 'redhat'
supports 'ubuntu'
supports 'solaris2'
supports 'freebsd'
supports 'arch'
supports 'windows'

depends 'compat_resource', '~> 12.0'

source_url 'https://github.com/johnbellone/rubyzip-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/johnbellone/rubyzip-cookbook/issues' if respond_to?(:issues_url)
