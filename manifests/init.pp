# Class: odoo9
class odoo9 (
  $install_wkhtmltopdf = false,
  $settings            = {},
  $version             = present,
  ) {
  if $install_wkhtmltopdf {
    package { 'wkhtmltopdf':
      ensure => present,
      notify => Service['odoo']
    }
  }

  package { 'odoo':
    ensure => $version,
    notify => Service['odoo']
  }

  $defaults = {
    path    => '/etc/odoo/openerp-server.conf',
    require => Package['odoo'],
    notify  => Service['odoo'],
  }

  create_ini_settings($settings, $defaults)

  service { 'odoo':
    ensure => running,
    enable => true,
  }
}
