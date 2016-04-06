#
# Cookbook Name:: ifupdown
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

netvars = search( :networking, "id:common").first


execute 'reset networking legacy' do
  command 'ifdown -a; ifup -a'
  action :nothing
end


template "/etc/network/interfaces" do
	source "interfaces.erb"
	owner "root"
	group "root"
	mode "0644"
	variables({
        :intvars => netvars["interfaces"]["#{node['hostname']}"]
		})
	notifies :run, 'execute[reset networking legacy]'
end
