require 'spec_helper'
describe 'odoo9' do

  context 'with defaults for all parameters' do
    it { should contain_class('odoo9') }
  end
end
