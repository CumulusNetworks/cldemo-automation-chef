wget -qO - https://downloads.chef.io/packages-chef-io-public.key | sudo apt-key add -
echo "deb https://packages.chef.io/current-apt xenial main" > chef-stable.list
echo "Acquire::ForceHash \"sha1\";" | sudo tee -a /etc/apt/apt.conf.d/02-chefpackagesfix
sudo mv chef-stable.list /etc/apt/sources.list.d/
sudo apt-get update
sudo service apache2 stop
sudo apt-get install chef-server-core -y
sudo chef-server-ctl reconfigure
sudo chef-server-ctl restart
sudo chef-server-ctl user-create cumulus rocket turtle cumulus@example.com 'CumulusLinux!' -f cumulus.pem
sudo chef-server-ctl org-create cldemo cldemo --association_user cumulus -f cldemo-validator.pem
sudo apt-get install chef -y
cp ../cumulus.pem .chef
cp ../cldemo-validator.pem .chef
knife ssl fetch
knife bootstrap -x cumulus --sudo  leaf01
knife bootstrap -x cumulus --sudo  leaf02
knife bootstrap -x cumulus --sudo  spine01
knife bootstrap -x cumulus --sudo  spine02
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
ssh leaf01 sudo chef-client
ssh leaf02 sudo chef-client
ssh spine01 sudo chef-client
ssh spine02 sudo chef-client
ssh server01 sudo chef-client
ssh server02 sudo chef-client
ssh server01 wget 172.16.2.101
