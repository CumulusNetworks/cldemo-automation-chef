ifupdown Cookbook
=================
Example cookbook - configures legacy ifupdown on servers.

Requirements
------------
Requires a data_bag networking::common

Attributes
----------
None

Usage
-----
Just include `ifupdown` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ifupdown]"
  ]
}
```
