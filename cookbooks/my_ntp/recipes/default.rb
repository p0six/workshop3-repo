#
# Cookbook:: my_ntp
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

case node['platform']
when 'centos'
  node.default['ntp']['servers'] = node['my_ntp']['servers']['centos']
when 'ubuntu'
  node.default['ntp']['servers'] = node['my_ntp']['servers']['ubuntu']
end

include_recipe 'ntp::default'
