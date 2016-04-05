#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get update" do
  command "apt-get update"
end

package 'apache2' do
  action :install
end

service 'apache2' do
  action [ :enable, :start ]
end
