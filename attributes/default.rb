default['prosody']['admins'] = ["admin@localhost"]
default['prosody']['use_libevent'] = false
default['prosody']['use_ipv6'] = false
default['prosody']['modules_enabled'] = [
  # -- Generally required --
  "roster", # Allow users to have a roster. Recommended ;)
  "saslauth", # Authentication for clients and servers. Recommended if you want to log in.
  "tls", # Add support for secure TLS on c2s/s2s connections
  "dialback", # s2s dialback support
  "disco", # Service discovery

  # -- Not essential, but recommended --
  "private", # Private XML storage (for room bookmarks, etc.)
  "vcard", # Allow users to set vCards
  "privacy", # Support privacy lists
  #"compression", # Stream compression

  # -- Nice to have --
  "legacyauth", # Legacy authentication. Only used by some old clients and bots.
  "version", # Replies to server version requests
  "uptime", # Report how long server has been running
  "time", # Let others know the time here on this server
  "ping", # Replies to XMPP pings with pongs
  "pep", # Enables users to publish their mood, activity, playing music and more
  "register", # Allow users to register on this server using a client and change passwords
  "adhoc", # Support for "ad-hoc commands" that can be executed with an XMPP client

  # -- Admin interfaces --
  "admin_adhoc", # Allows administration via an XMPP client that supports ad-hoc commands
  "admin_telnet", # Opens telnet console interface on localhost port 5582

  # -- Other specific functionality --
  #"console", # Opens admin telnet interface on localhost port 5582
  #"bosh", # Enable BOSH clients, aka "Jabber over HTTP"
  #"httpserver", # Serve static files from a directory over HTTP
  #"groups", # Shared roster support
  "announce", # Send announcement to all online users
  #"welcome", # Welcome users who register accounts
  #"watchregistrations", # Alert admins of registrations
  "lastactivity", # Query how long another user has been idle

  # Debian: do not remove this module, or you lose syslog support
  "posix"
]
default['prosody][:modules_disabled] = [
  #"presence",
  #"message",
  #"iq"
]
default['prosody']['allow_registration'] = false
default['prosody']['daemonize'] = true
default['prosody']['pidfile'] = "/var/run/prosody/prosody.pid"
default['prosody']['ssl']['key'] = "/etc/prosody/certs/localhost.key"
default['prosody']['ssl']['certificate'] = "/etc/prosody/certs/localhost.cert"
default['prosody']['log'] = [
  { 'levels' => ["error"], 'to' => "syslog" },
  { 'levels' => ["error"], 'to' => "file", 'filename' => "/var/log/prosody/prosody.err" },
  { 'levels' => { 'min' => "info" }, 'to' => "file", 'filename' => "/var/log/prosody/prosody.log" }
]

default['prosody']['conf_enabled'] = ["localhost"]

default[:prosody][:hosts] = {}

default[:prosody][:plugins] = {}
