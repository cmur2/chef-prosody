
package node['prosody']['package']

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
  variables :node => node, :config => node['prosody']
  owner "root"
  group "prosody"
  mode 00640
  notifies :restart, "service[prosody]"
end

# download specified plugins into modules directory
node['prosody']['plugins'].each do |plugin_name,plugin_files|
  plugin_files.each do |rel_path,url|
    remote_file "/usr/lib/prosody/#{rel_path}" do
      source url
      mode 00644
    end
  end
end

# place conf for every VirtualHost in conf.avail
node['prosody']['hosts'].each do |host_name,host|
  file "/etc/prosody/conf.avail/#{host_name}.cfg.lua" do
    content node.generate_virtualhost_cfg(host_name)
    owner "root"
    group "prosody"
    mode 00640
    notifies :restart, "service[prosody]"
  end
end

# link all enabled confs into conf.d which is included by prosody.cfg.lua
node['prosody']['conf_enabled'].each do |conf_name|
  link "/etc/prosody/conf.d/#{conf_name}.cfg.lua" do
    to "/etc/prosody/conf.avail/#{conf_name}.cfg.lua"
    owner "root"
    group "prosody"
  end
end

file "/etc/prosody/prosody.cfg.lua" do
  content node.generate_prosody_cfg
  owner "root"
  group "prosody"
  mode 00640
  notifies :restart, "service[prosody]"
end

service "prosody" do
  action [:enable, :start]
end
