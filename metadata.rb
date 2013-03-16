name             "prosody"
maintainer       "Christian Nicolai"
maintainer_email "cn@mycrobase.de"
license          "Apache 2.0"
description      "Installs Prosody via package and configures core settings, VirtualHosts and some modules."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.1"

suggests "apt" # for prosody::use_community_repos

supports "debian"
