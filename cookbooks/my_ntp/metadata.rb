name 'my_ntp'
maintainer 'Michael Romero'
maintainer_email 'romerom@gmail.com'
license 'MIT'
description 'Small wrapper cookbook for NTP'
long_description 'Installs/Configures my_ntp'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/p0six/workshop3-repo/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/p0six/workshop3-repo'

depends 'ntp', '= 2.0.0'
supports 'centos'
supports 'ubuntu'
