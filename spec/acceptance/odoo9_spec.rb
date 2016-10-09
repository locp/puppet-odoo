require 'spec_helper_acceptance'

describe 'odoo9 class' do
  odoo_pp = <<-EOS
    class { 'odoo9::repo':
      before => Class['odoo9']
    }

    class {'odoo9':
    }
  EOS

  describe 'Odoo 9 installation.' do
    it 'should work with no errors' do
      apply_manifest(odoo_pp, :catch_failures => true)
      expect(apply_manifest(odoo_pp,
        :catch_failures => true).exit_code).to be_zero
    end
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
