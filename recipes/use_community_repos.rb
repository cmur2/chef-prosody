
case node['platform']
when "debian"
  case node['platform_version'].to_i
  when 5
    apt_repository "prosody-lenny" do
      uri "http://packages.prosody.im/debian"
      components ["lenny", "main"]
      key "http://prosody.im/files/prosody-debian-packages.key"
    end
  when 6
    apt_repository "prosody-squeeze" do
      uri "http://packages.prosody.im/debian"
      components ["squeeze", "main"]
      key "http://prosody.im/files/prosody-debian-packages.key"
    end
  end
end
