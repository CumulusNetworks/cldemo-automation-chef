apache Cookbook
===============
Example cookbook - installs apache webserver.

Requirements
------------
None

Attributes
----------
None

Usage
-----
Just include `apache` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apache]"
  ]
}
```
