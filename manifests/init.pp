# Class: odoo9
class odoo9 (
  $version = present
  ) {
  class { 'postgresql::server':
    before => Package['odoo'],
    notify => Service['odoo']
  }

  package { [ 'fontconfig', 'freetype', 'libpng', 'libjpeg-turbo', 'openssl',
              'libX11', 'libXext', 'libXrender', 'xorg-x11-fonts-Type1',
              'xorg-x11-fonts-75dpi', 'epel-release' ]:
    ensure => $version,
    before => Package['wkhtmltopdf'],
    notify => Service['odoo']
  }

  package { 'wkhtmltopdf':
    ensure   => 'present',
    name     => 'wkhtmltox',
    source   => 'http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm',
    provider => 'rpm',
    before   => Package['odoo'],
    notify   => Service['odoo']
  }

  yumrepo { 'odoo-nightly':
    ensure   => 'present',
    baseurl  => 'http://nightly.odoo.com/9.0/nightly/rpm/',
    descr    => 'Odoo Nightly repository',
    enabled  => True,
    gpgcheck => True,
    gpgkey   => 'https://nightly.odoo.com/odoo.key',
    before   => Package['odoo'],
    notify   => Service['odoo']
  }

  package { 'odoo':
    ensure => 'present',
    notify => Service['odoo']
  }

  service { 'odoo':
    ensure => running,
    enable => true,
  }
}
