name "spines"
description "Configure quagga and ifupdown2"
run_list "recipe[ifupdown2]", "recipe[quagga]" 
