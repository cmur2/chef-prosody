
case node['platform']
when "debian"
  case node['platform_version'].to_i
  when 5
    # deprecated since unsupported by official prosod repo
    apt_repository "prosody-lenny" do
      uri "http://packages.prosody.im/debian-old"
      components ["lenny", "main"]
      key "http://prosody.im/files/prosody-debian-packages.key"
    end
  when 6
    apt_repository "prosody-squeeze" do
      uri "http://packages.prosody.im/debian"
      components ["squeeze", "main"]
      key "http://prosody.im/files/prosody-debian-packages.key"
    end
  when 7
    apt_repository "prosody-wheezy" do
      uri "http://packages.prosody.im/debian"
      components ["wheezy", "main"]
      key "http://prosody.im/files/prosody-debian-packages.key"
    end
  end
end
