quagga Cookbook
===============
Example cookbook - configures quagga.

Requirements
------------
Requires a data_bag networking::common

Attributes
----------
None

Usage
-----
Just include `quagga` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[quagga]"
  ]
}
```
