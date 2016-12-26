require 'spec_helper_acceptance'

describe 'odoo module' do
  odoo9_pp = <<-EOS
    class { 'postgresql::server':
      before => Class['odoo']
    }

    class { '::odoo::repo9':
      before => Class['odoo']
    }

    class { '::odoo':
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
      version             => 'present',
    }
  EOS

  describe 'Odoo 9 installation.' do
    it 'should work with no errors' do
      apply_manifest(odoo9_pp, catch_failures: true)
      expect(apply_manifest(odoo9_pp,
                            catch_failures: true).exit_code).to be_zero
    end
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
