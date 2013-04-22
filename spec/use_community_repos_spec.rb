require 'chefspec'

describe 'prosody::use_community_repos' do
  let(:chef_runner) do
    cb_path = [Pathname.new(File.join(File.dirname(__FILE__), '..', '..')).cleanpath.to_s, 'spec/support/cookbooks']
    ChefSpec::ChefRunner.new(:cookbook_path => cb_path, :step_into => ['apt_repository'])
  end

  let(:chef_run) do
    chef_runner.converge 'apt', 'prosody::use_community_repos'
  end
  
  it 'creates prosody-lenny list on Debian 5' do
    chef_runner.node.automatic_attrs['platform'] = 'debian'
    chef_runner.node.automatic_attrs['platform_version'] = '5.0.0'
    chef_run = chef_runner.converge 'apt', 'prosody::use_community_repos'
    expect(chef_run).to create_file "/etc/apt/sources.list.d/prosody-lenny.list"
  end
  
  it 'creates prosody-squeeze list on Debian 6' do
    chef_runner.node.automatic_attrs['platform'] = 'debian'
    chef_runner.node.automatic_attrs['platform_version'] = '6.0.0'
    chef_run = chef_runner.converge 'apt', 'prosody::use_community_repos'
    expect(chef_run).to create_file "/etc/apt/sources.list.d/prosody-squeeze.list"
  end
end
