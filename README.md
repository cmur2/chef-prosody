# chef-prosody

[![Build Status](https://travis-ci.org/cmur2/chef-prosody.png)](https://travis-ci.org/cmur2/chef-prosody)

## Description

Installs [Prosody](http://prosody.im/) (XMPP/Jabber server written in Lua) via package and configures core settings, VirtualHosts and some modules.

## Usage

Include `recipe[prosody::default]` in your `run_list` and do further configuration via node attributes. 

If you want a more recent version of Prosody (Debian Squeeze has 0.7.0 and Wheezy has 0.8.2 but 0.9.2 is available from [here](http://prosody.im/download/package_repository) for both) you might use `recipe[prosody::use_community_repos]` to enable APT repositories maintained by the Prosody community (needs the apt cookbook).

## Limitations

* no support for managing the user database (cause `prosodyctl` is interactive and limited)
* no logrotate support for **non-default** log file location

## Requirements

### Platform

It should work on all OSes that provide a (recent, versions around 0.7.0 or better) prosody package.

## Recipes

### default

Installs Prosody package, downloads specified additional modules and auxillary files by URL (`node["prosody"]["plugins"]`), creates all necessary VirtualHost definitions in `/etc/prosody/conf.avail`, links the enabled ones into `/etc/prosody/conf.d` (directory automatically included in main config) and generates the main configuration dynamically from `node["prosody"]["main"]`. Finally restarts the service.

A working Prosody (with one VirtualHost for localhost) is configured by the default attributes.

Your minimal modifications to customize your Prosody should include specifying an admin account JID (`node["prosody"]["main"]["admins"]`, it's a list), a VirtualHost for your domain (in `node["prosody"]["hosts"]`) and to enable this VirtualHost (via `node["prosody"]["conf_enabled"]`) like so:

```json
"prosody": {
	"main": {
		"admins": ["admin@example.org"]
	},
	"conf_enabled": ["example.org"],
	"hosts": {
		"example.org": {}
	}
}
```

A more elaborated one would be:

```json
"prosody": {
	"main": {
		"admins": ["admin@example.org"],
		"use_ipv6": true,
		"c2s_require_encryption": true
	},
	"conf_enabled": ["example.org"],
	"hosts": {
		"example.org": {
			"proxy65": {
				"hostname": "proxy.example.org",
				"acl": ["example.org"]
			}
		}
	},
	"plugins": {
		"s2s_auth_fingerprint": {
			"modules/mod_s2s_auth_fingerprint.lua": "https://prosody-modules.googlecode.com/hg/mod_s2s_auth_fingerprint/mod_s2s_auth_fingerprint.lua"
		}
	}
}
```

In general all Prosody options and all options supported and used by any plugin are possible.

### use_community_repos

If you're on Debian Wheezy (or Squeeze) this will enable the Prosody community APT repository providing newer versions - include this in your `run_list` before `recipe[apt]`.

## License

chef-prosody is licensed under the Apache License, Version 2.0. See LICENSE for more information.
