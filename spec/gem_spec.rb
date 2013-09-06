require 'chefspec'

describe 'remote_syslog::gem ' do
  let (:chef_run) { ChefSpec::ChefRunner.new }

  it 'should install the gem' do
    chef_run.converge 'remote_syslog::gem'

    chef_run.should install_gem_package 'remote_syslog'
  end

  it 'should install the gem with the specified version' do
    chef_run.node.set['remote_syslog']['version'] = '1.6.7.2'
    chef_run.converge 'remote_syslog::gem'

    chef_run.should install_gem_package_at_version 'remote_syslog', '1.6.7.2'
  end
end
