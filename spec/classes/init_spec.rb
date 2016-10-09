require 'spec_helper'
describe 'odoo9' do
  let(:pre_condition) do
    [
      'define create_ini_settings($settings, $defaults) {}',
      'define ini_setting($ensure = nil,
         $path,
         $section,
         $key_val_separator       = nil,
         $setting,
         $value                   = nil) {}'
    ]
  end

  context 'with defaults for all parameters' do
    it do
      should contain_class('odoo9')
      should contain_package('odoo')
      should contain_service('odoo')
    end
  end
end
