# Class: odoo9
# ===========================
#
class odoo9 {
  class { 'postgresql::server':
    before => Package['odoo'],
  }

  package { 'wkhtmltopdf':
    ensure          => 'present',
    name            => 'http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm',
    provider        => 'rpm',
    before          => Package['odoo'],
  }

  yumrepo { 'odoo-nightly':
    ensure   => 'present',
    baseurl  => 'http://nightly.odoo.com/9.0/nightly/rpm/',
    descr    => 'Odoo Nightly repository',
    enabled  => True,
    gpgcheck => True,
    gpgkey   => 'https://nightly.odoo.com/odoo.key',
    before   => Package['odoo'],
  }

  package { 'odoo':
    ensure => 'present',
  }
}
