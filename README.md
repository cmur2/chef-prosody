# chef-prosody

[![Build Status](https://travis-ci.org/cmur2/chef-prosody.png)](https://travis-ci.org/cmur2/chef-prosody)

## Description

Installs [Prosody](http://prosody.im/) (XMPP/Jabber server written in Lua) via package and configures core settings, VirtualHosts and some modules.

## Usage

Include `recipe[prosody::default]` in your `run_list` and do further configuration via node attributes. 

If you want a more recent version of Prosody (Debian Squeeze has 0.7.0 but 0.8.2 is available from [here](http://prosody.im/download/package_repository)) you might use `recipe[prosody::use_community_repos]` to enable APT repositories maintained by the Prosody community (needs the apt cookbook).

## Limitations

* no support for managing the user database (cause `prosodyctl` is interactive and limited)
* no logrotate support for **non-default** log file location

## Requirements

### Platform

It should work on all OSes that provide a (recent, versions around 0.7.0 or better) prosody package.

## Recipes

### default

Installs Prosody package, downloads specified additional modules by URL (`node["prosody"]["plugins"]`), creates all necessary VirtualHost definitions in `/etc/prosody/conf.avail`, links the enabled ones into `/etc/prosody/conf.d` (directory automatically included in core config) and generates the core configuration. Finally restarts the service.

A working Prosody (with one VirtualHost for localhost) is configured by the default attributes.

Your minimal modifications to customize your Prosody should include specifying an admin account JID (`node["prosody"]["admins"]`, it's a list), a VirtualHost for your domain (in `node["prosody"]["hosts"]`) and to enable this VirtualHost (via `node["prosody"]["conf_enabled"]`).

### use_community_repos

If you're on Debian Squeeze (or Lenny) this will enable the Prosody community APT repository providing newer versions - include this in your `run_list` before `recipe[apt]`.

## License

chef-prosody is licensed under the Apache License, Version 2.0. See LICENSE for more information.
