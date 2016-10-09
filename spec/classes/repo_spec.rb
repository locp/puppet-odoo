require 'spec_helper'
describe 'odoo9::repo' do
  let(:pre_condition) do
    [
      'class apt() {}',
      'define apt::key($id, $source) {}',
      'define apt::source($location, $comment, $release, $repos, $include) {}',
      'class apt::update() {}'
    ]
  end

  let!(:stdlib_stubs) do
    MockFunction.new('create_ini_settings', type: :statement) do |_f|
    end
  end

  context 'with defaults for all parameters' do
    let :facts do
      {
        osfamily: 'Debian'
      }
    end

    it do
      should contain_class('odoo9::repo')
      should contain_apt__key('odookey')
      should contain_apt__source('odoo')
      should contain_exec('update-odoo-repos')
    end
  end
end
