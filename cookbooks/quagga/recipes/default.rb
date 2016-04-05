#
# Cookbook Name:: quagga
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

networkingvars = search( :networking, "id:common")
intvars = networkingvars["interfaces"]["#{node['hostname']}"]
networks = networkingvars["networks"]


cookbook_file "/etc/quagga/daemons" do
	source "daemons"
	owner "root"
	group "root"
	mode "0644"
	notifies :restart, "service[quagga]"
end

interface_items.each do |item|
	template "/etc/quagga/Quagga.conf" do
		source "Quagga.conf.erb"
		owner "root"
		group "root"
		mode "0644"
		variables({
			:interfaces => item
			})
		notifies :restart, "service[quagga]"
	end
end

service "quagga" do
	supports :restart => true
	action [ :enable ]
end
