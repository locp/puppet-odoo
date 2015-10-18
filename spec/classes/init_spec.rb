require 'spec_helper'
describe 'odoo9' do
  let(:pre_condition) { [
    'class postgresql::server () {}',
    'define ini_setting($ensure = nil,
       $path,
       $section,
       $key_val_separator       = nil,
       $setting,
       $value                   = nil) {}',
  ] }

  context 'with defaults for all parameters' do
    it { should contain_class('odoo9') }
    it { should contain_class('postgresql::server') }
    it { should contain_package('wkhtmltopdf') }
    it { should contain_yumrepo('odoo-nightly') }
    it { should contain_package('odoo') }
  end
end
