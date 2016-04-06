current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "cumulus"
client_key               "#{current_dir}/cumulus.pem"
validation_client_name   "cldemo-validator"
validation_key           "#{current_dir}/cldemo-validator.pem"
chef_server_url          "https://oob-mgmt-server.lab.local/organizations/cldemo"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            ["#{current_dir}/../cookbooks"]
