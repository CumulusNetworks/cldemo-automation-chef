#
# Cookbook Name:: quagga
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

netvars = search( :networking, "id:common").first


cookbook_file "/etc/quagga/daemons" do
	source "daemons"
	owner "root"
	group "root"
	mode "0644"
	notifies :restart, "service[quagga]"
end

template "/etc/quagga/Quagga.conf" do
	source "Quagga.conf.erb"
	owner "root"
	group "root"
	mode "0644"
	variables({
		:intvars => netvars["interfaces"]["#{node['hostname']}"],
		:networks => netvars["networks"],
		:hostname => "#{node['hostname']}"
		})
	notifies :restart, "service[quagga]"
end

service "quagga" do
	supports :restart => true
	action [ :enable ]
end
