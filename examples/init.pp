# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# https://docs.puppet.com/guides/tests_smoke.html
#
class { 'postgresql::server':
  before => Class['odoo9']
}

class { '::odoo9::repo':
  before => Class['odoo9']
}

class { '::odoo9':
  install_wkhtmltopdf => true,
  settings            => {
    'options' => {
      'admin_passwd' => 'XXX_TOP_SECRET_XXX',
      'db_host'      => 'False',
      'db_port'      => 'False',
      'db_user'      => 'odoo',
      'db_password'  => 'False',
      'addons_path'  => '/usr/lib/python2.7/dist-packages/openerp/addons',
    }
  },
  version             => '9.0c.20161009',
}
