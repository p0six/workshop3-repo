#
# Cookbook:: users
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

current_time = Time.now
# if (current_time.hour >= 9) && (current_time.hour <= 17)
if (current_time.hour >= 9) && (current_time.hour <= 20)
  ::File.new('/tmp/usersallowed', 'w+')
elsif ::File.exist?('/tmp/usersallowed')
  ::File.delete('/tmp/usersallowed')
end

search(:users, 'id:*').each do |my_user|
  user my_user[:id] do
    uid my_user[:uid]
    gid my_user[:gid]
    comment my_user[:comment]
    home my_user[:home]
    shell my_user[:shell]
    only_if { ::File.exist?('/tmp/usersallowed') }
    manage_home true
    action :create
    notifies :create, 'file[/tmp/timestamp]', :immediately
  end

  user my_user[:id] do # ~FC022
    not_if { ::File.exist?('/tmp/usersallowed') }
    not_if { !node['etc']['passwd'][my_user[:id]].nil? }
    action :remove
    notifies :create, 'file[/tmp/timestamp]', :immediately
  end
end

file '/tmp/timestamp' do
  content lazy { Time.now.to_s }
  action :nothing
end

search(:groups, 'id:*').each do |my_group|
  group my_group[:id] do
    gid my_group[:gid]
    members my_group[:members] if ::File.exist?('/tmp/usersallowed')
    action :create
  end
end

user 'chef' do
  password '$1$wsO.xok0$LPYxrRBOzEWOd/44YzEv4/'
  notifies :create, 'cookbook_file[/etc/ssh/sshd_config]', :immediately
  home '/home/chef'
  manage_home true
  shell '/bin/bash'
  comment 'Some dumb shit..'
  action :create
end

cookbook_file '/etc/ssh/sshd_config' do
  source 'sshd_config'
  action :create
  mode '0640'
  notifies :restart, 'service[sshd]', :immediately
end

service 'sshd' do
  action :nothing
end
