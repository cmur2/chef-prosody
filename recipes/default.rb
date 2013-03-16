
package "prosody" do
  action :upgrade
end

# create missing directories and apply permissions
["/etc/prosody/certs", "/etc/prosody/conf.avail", "/etc/prosody/conf.d"].each do |dir|
  directory dir do
    owner "root"
    group "prosody"
    mode 00750
  end
end

# place localhost example conf in conf.avail
template "/etc/prosody/conf.avail/localhost.cfg.lua" do
  source "localhost.cfg.lua.erb"
  variables :node => node, :config => node["prosody"]
  owner "root"
  group "prosody"
  mode 00640
  notifies :restart, "service[prosody]"
end

# download specified plugins into modules directory
node["prosody"]["plugins"].each do |plugin_name,url|
  remote_file "/usr/lib/prosody/modules/mod_#{plugin_name}.lua" do
    source url
    mode 00644
  end
end

# place conf for every VirtualHost in conf.avail
node["prosody"]["hosts"].each do |host_name,host|
  template "/etc/prosody/conf.avail/#{host_name}.cfg.lua" do
    source "virtualhost.cfg.lua.erb"
    variables :node => node, :host_name => host_name, :host => host
    owner "root"
    group "prosody"
    mode 00640
    notifies :restart, "service[prosody]"
  end
end

# link all enabled confs into conf.d which is included by prosody.cfg.lua
node["prosody"]["conf_enabled"].each do |conf_name|
  link "/etc/prosody/conf.d/#{conf_name}.cfg.lua" do
    to "/etc/prosody/conf.avail/#{conf_name}.cfg.lua"
    owner "root"
    group "prosody"
  end
end

template "/etc/prosody/prosody.cfg.lua" do
  source "prosody.cfg.lua.erb"
  variables :node => node, :config => node["prosody"]
  owner "root"
  group "prosody"
  mode 00640
  notifies :restart, "service[prosody]"
end

service "prosody" do
  action [:enable, :start]
end
