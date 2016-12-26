# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'json'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'.freeze

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'node0'
  config.vm.box = 'puppetlabs/ubuntu-14.04-64-nocm'
  config.puppet_install.puppet_version = '3.8.2'
  config.vm.synced_folder '.', '/etc/puppet/modules/odoo'
  metadata_json_file = "#{File.dirname(__FILE__)}/metadata.json"
  if File.exist?(metadata_json_file)
    JSON.parse(
      File.read(metadata_json_file)
    )['dependencies'].each do |key, _value|
      module_name = key['name'].to_s
      config.vm.provision 'shell', inline: "puppet module install #{module_name}"
    end
  else
    puts 'metadata.json not found; skipping install of dependencies'
  end
  config.vm.provision 'shell', inline: 'puppet module install puppetlabs-postgresql'
  config.vm.provision 'puppet' do |puppet|
    puppet.manifests_path = 'examples'
    puppet.manifest_file = 'odoo9.pp'
  end
  config.vm.network 'forwarded_port', guest: 8069, host: 8069
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
  end
end
