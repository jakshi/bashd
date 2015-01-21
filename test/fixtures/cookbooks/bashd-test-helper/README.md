bashd-test-helper Cookbook
============================

This a cookbook for testing bashd cookbook LWRP

Requirements
------------

### OS

* Debian 7

Attributes
----------

Usage
-----
#### bashd-test-helper::default

Include `bashd-test-helper` in your test-kitchen .kitchen.yml like:

```
suites:
- name: server
  run_list:
  - recipe[bashd-test-helper]
```

# Author

Author:: Lysenko Kostiantyn (<gshaud@gmail.com>)
