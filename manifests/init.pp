# Install and configure Odoo Community.
# @param install_wkhtmltopdf [boolean] Whether or not to install the optional `wkhtmltopdf` package.
# @param settings [hash] A hash of settings to be passed to the `create_ini_settings` (see
#   https://forge.puppet.com/puppetlabs/inifile#manage-multiple-ini_settings for details).
# @param version [string] The version of the `odoo` package to be installed.  Valid values are **present**, **latest**
#   or the version of the version of the package to be installed ('i.e. *9.0c.20161009*).
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
