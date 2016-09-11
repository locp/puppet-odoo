# Class: odoo9
class odoo9 (
  $version = present
  ) {
  class { 'postgresql::server':
    before => Package['odoo'],
    notify => Service['odoo']
  }

  package { 'odoo':
    ensure => $version,
    notify => Service['odoo']
  }

  service { 'odoo':
    ensure => running,
    enable => true,
  }
}
