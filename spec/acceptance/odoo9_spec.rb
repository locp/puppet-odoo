require 'spec_helper_acceptance'

describe 'odoo9 class' do
  pre_req_install_pp = <<-EOS
    include '::odoo9'
  EOS

  describe 'Odoo 9 installation.' do
    it 'should work with no errors' do
      apply_manifest(pre_req_install_pp, :catch_failures => true)
      expect(apply_manifest(pre_req_install_pp,
        :catch_failures => true).exit_code).to be_zero
    end
  end

  describe service('odoo') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end
end
