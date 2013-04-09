pkg-mgmt
========

OpenLSS package management scripts

Put these scripts into your ~/lss folder where the sub folders all all packages

Example tree:

  * lss
   * func-ui
   * lib-config
   * autorelease.sh
   * release_pkg.sh
   * to_release

Then edit the "to_release" file and add 1 package name per line that will be released.

push_pkg
====
Usage

```bash
./push_pkg.sh func-ui "new features"
```

autorelease
====
Added more scripts for commiting and pushing mass amounts of repos.

Also made the grep fixes for to_release better so the following works.

```bash
ls -l | grep lib > to_release
./autorelease.sh
```
