require 'spec_helper_acceptance'

describe 'odoo module' do
  install_odoo9_pp = <<-EOS
    class { 'postgresql::server':
      before => Class['odoo']
    }

    class { '::odoo::repo9':
      before => Class['odoo']
    }

    class { '::odoo':
      config_file         => '/etc/odoo/openerp-server.conf',
      install_wkhtmltopdf => true,
      settings            => {
        'options' => {
          'admin_passwd' => 'XXX_TOP_SECRET_XXX_9',
          'db_host'      => 'False',
          'db_port'      => 'False',
          'db_user'      => 'odoo',
          'db_password'  => 'False',
          'addons_path'  => '/usr/lib/python2.7/dist-packages/openerp/addons',
        }
      },
      version             => present,
    }
  EOS

  describe 'Odoo 9 installation.' do
    it 'should work with no errors' do
      apply_manifest(install_odoo9_pp, catch_failures: true)
      expect(apply_manifest(install_odoo9_pp,
                            catch_failures: true).exit_code).to be_zero
    end
  end

  describe package('odoo') do
    it { is_expected.to be_installed }
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  uninstall_odoo9_pp = <<-EOS
    service { 'odoo':
      ensure => stopped,
    } ->
    package { 'odoo':
      ensure => purged,
    } ->
    class { '::odoo::repo9':
      ensure => absent,
    }
  EOS

  describe 'Uninstall Odoo 9.' do
    it 'should work with no errors' do
      apply_manifest(uninstall_odoo9_pp, catch_failures: true)
    end
  end

  install_odoo10_pp = <<-EOS
    class { 'postgresql::server':
      before => Class['odoo']
    }

    class { '::odoo::repo10':
      before => Class['odoo']
    }

    class { '::odoo':
      install_wkhtmltopdf => true,
      settings            => {
        'options' => {
          'admin_passwd' => 'XXX_TOP_SECRET_XXX_10',
          'db_host'      => 'False',
          'db_port'      => 'False',
          'db_user'      => 'odoo',
          'db_password'  => 'False',
          'addons_path'  => '/usr/lib/python2.7/dist-packages/odoo/addons',
        }
      },
      version             => present,
    }
  EOS

  describe 'Odoo 10 installation.' do
    it 'should work with no errors' do
      apply_manifest(install_odoo10_pp, catch_failures: true)
      expect(apply_manifest(install_odoo10_pp,
                            catch_failures: true).exit_code).to be_zero
    end
  end

  describe package('odoo') do
    it { is_expected.to be_installed }
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
