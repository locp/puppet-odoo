require 'spec_helper'
describe 'odoo::repo9' do
  let(:pre_condition) do
    [
      'class apt() {}',
      'define apt::key($ensure, $id, $source) {}',
      'define apt::source($ensure, $location, $comment, $release, $repos, $include) {}',
      'class apt::update() {}'
    ]
  end

  let!(:stdlib_stubs) do
    MockFunction.new('create_ini_settings', type: :statement) do |_f|
    end
  end

  context 'with defaults for all parameters (Debian)' do
    let :facts do
      {
        osfamily: 'Debian'
      }
    end 

    it do
      should contain_class('odoo::repo9').only_with(
        ensure: 'present',
        descr: 'Odoo Nightly repository',
        key_id: '5D134C924CB06330DCEFE2A1DEF2A2198183CBB5',
        key_url: 'https://nightly.odoo.com/odoo.key',
        pkg_url: nil,
        release: './',
        repos: ''
      )

      should contain_apt__key('odookey').with(
        ensure: 'present',
        id: '5D134C924CB06330DCEFE2A1DEF2A2198183CBB5',
        source: 'https://nightly.odoo.com/odoo.key'
      )

      should contain_apt__source('odoo').with(
        ensure: 'present',
        location: 'http://nightly.odoo.com/9.0/nightly/deb/',
        comment: 'Odoo Nightly repository',
        release: './',
        include: { 'src' => false }
      )

      should contain_exec('update-odoo-repos').with(
        refreshonly: true,
        command: '/bin/true'
      )
    end
  end

  context 'with defaults for all parameters (RedHat)' do
    let :facts do
      {
        osfamily: 'RedHat'
      }
    end 

    it do
      should contain_yumrepo('odoo').with(
        ensure: 'present',
        descr: 'Odoo Nightly repository',
        baseurl: 'http://nightly.odoo.com/9.0/nightly/rpm/',
        enabled: 1,
        gpgcheck: 0
      )
    end
  end
end
