ifupdown2 Cookbook
==================
Example cookbook - configures ifupdown2 on switches.

Requirements
------------
Requires a data_bag networking::common

Attributes
----------
None

Usage
-----
Just include `ifupdown2` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ifupdown2]"
  ]
}
```
