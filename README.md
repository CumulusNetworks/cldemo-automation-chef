Chef Automation Demo
====================
This demo demonstrates how to write a set of cookbooks using Chef to configure switches running Cumulus Linux and servers running Ubuntu. This manifest configures a CLOS topology running BGP unnumbered in the fabric with Layer 2 bridges to the hosts, and installs a webserver on one of the hosts to serve as a Hello World example. When the demo runs successfully, any server on the network should be able to access the webserver via the BGP routes established over the fabric.

This demo is written for the [cldemo-vagrant](https://github.com/cumulusnetworks/cldemo-vagrant) reference topology and applies the reference BGP numbered configuration from [cldemo-config-routing](https://github.com/cumulusnetworks/cldemo-config-routing).


Quickstart: Run the demo
------------------------
(This assumes you are running Ansible 1.9.4 and Vagrant 1.8.4 on your host.)

    git clone https://github.com/cumulusnetworks/cldemo-vagrant
    cd cldemo-vagrant
    vagrant up oob-mgmt-server oob-mgmt-switch leaf01 leaf02 spine01 spine02 server01 server02
    vagrant ssh oob-mgmt-server
    sudo su - cumulus
    wget -qO - https://downloads.chef.io/packages-chef-io-public.key | sudo apt-key add -
    echo "deb https://packages.chef.io/stable-apt trusty main" > chef-stable.list
    sudo mv chef-stable.list /etc/apt/sources.list.d/
    sudo apt-get update
    sudo service apache2 stop
    sudo apt-get install chef-server-core -y
    sudo chef-server-ctl reconfigure
    sudo chef-server-ctl restart
    sudo chef-server-ctl user-create cumulus rocket turtle cumulus@example.com 'CumulusLinux!' -f cumulus.pem
    sudo chef-server-ctl org-create cldemo cldemo --association_user cumulus -f cldemo-validator.pem
    sudo apt-get install chef -y
    sudo /opt/chef/embedded/bin/gem install knife-acl
    git clone https://github.com/cumulusnetworks/cldemo-automation-chef
    cd cldemo-automation-chef
    cp ../cumulus.pem .chef
    cp ../cldemo-validator.pem .chef
    knife ssl fetch
    knife bootstrap -x cumulus --sudo  --bootstrap-install-command 'wget https://packages.chef.io/stable/debian/8/chef_12.10.24-1_amd64.deb && dpkg -i chef_12.10.24-1_amd64.deb' leaf01
    knife bootstrap -x cumulus --sudo  --bootstrap-install-command 'wget https://packages.chef.io/stable/debian/8/chef_12.10.24-1_amd64.deb && dpkg -i chef_12.10.24-1_amd64.deb' leaf02
    knife bootstrap -x cumulus --sudo  --bootstrap-install-command 'wget https://packages.chef.io/stable/debian/8/chef_12.10.24-1_amd64.deb && dpkg -i chef_12.10.24-1_amd64.deb' spine01
    knife bootstrap -x cumulus --sudo  --bootstrap-install-command 'wget https://packages.chef.io/stable/debian/8/chef_12.10.24-1_amd64.deb && dpkg -i chef_12.10.24-1_amd64.deb' spine02
    knife bootstrap -x cumulus --sudo  server01
    knife bootstrap -x cumulus --sudo  server02
    knife cookbook upload apache
    knife cookbook upload ifupdown
    knife cookbook upload ifupdown2
    knife cookbook upload quagga
    knife role from file roles/*
    knife node from file nodes/*
    knife data bag create networking
    knife data bag from file networking data_bags/networking
    knife acl bulk add group clients nodes '.*' update,read
    ssh leaf01 sudo chef-client
    ssh leaf02 sudo chef-client
    ssh spine01 sudo chef-client
    ssh spine02 sudo chef-client
    ssh server01 sudo chef-client
    ssh server02 sudo chef-client
    ssh server01
    wget 172.16.2.101

Topology Diagram
----------------
This demo runs on a spine-leaf topology with two single-attached hosts. Each device's management interface is connected to an out-of-band management switch and bridged with the out-of-band management server that runs the Chef server.

             +------------+       +------------+
             | spine01    |       | spine02    |
             |            |       |            |
             +------------+       +------------+
             swp1 |    swp2 \   / swp1    | swp2
                  |           X           |
            swp51 |   swp52 /   \ swp51   | swp52
             +------------+       +------------+
             | leaf01     |       | leaf02     |
             |            |       |            |
             +------------+       +------------+
             swp1 |                       | swp2
                  |                       |
             eth1 |                       | eth2
             +------------+       +------------+
             | server01   |       | server02   |
             |            |       |            |
             +------------+       +------------+

