require 'spec_helper'
describe 'odoo' do
  let(:pre_condition) do
    [
      'define ini_setting($ensure = nil,
         $path,
         $section,
         $key_val_separator       = nil,
         $setting,
         $value                   = nil) {}'
    ]
  end

  let!(:stdlib_stubs) do
    MockFunction.new('create_ini_settings', type: :statement) do |_f|
    end
  end

  context 'with defaults for all parameters' do
    it do
      should compile
      should contain_class('odoo')
      should contain_package('odoo')
      should contain_service('odoo')
    end
  end
end
