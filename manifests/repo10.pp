# Install a repository to install an Odoo 10 package from.
#
# @param ensure [absent | present] Ensure the the repository is either
#   absent or present.
# @param descr [string] A string to describe the repository.
# @param key_id [string] The key for the Debian APT repository.  This option
#   is ignored on the Red Hat family.
# @param key_url [string] A URL to the key for the Debian APT repository.
#   This option is ignored on the Red Hat family.
# @param pkg_url [string] The URL to a package.  This defaults to
#   'http://nightly.odoo.com/10.0/nightly/rpm/' on the Red
#   Hat family and 'http://nightly.odoo.com/9.0/nightly/deb/' on Debian.
# @param release [string] The release for the Debian APT repository.  This
#   option is ignored on the Red Hat family.
# @param repos [string] The repos for the Debian APT repository.  This option
#   is ignored on the Red Hat family.
class odoo::repo10 (
  $ensure  = present,
  $descr   = 'Odoo Nightly repository',
  $key_id  = '5D134C924CB06330DCEFE2A1DEF2A2198183CBB5',
  $key_url = 'https://nightly.odoo.com/odoo.key',
  $pkg_url = undef,
  $release = './',
  $repos = '',
  ) {
  case $::osfamily {
    'RedHat': {
      if $pkg_url != undef {
        $baseurl = $pkg_url
      } else {
        $baseurl = 'http://nightly.odoo.com/10.0/nightly/rpm/'
      }

      yumrepo { 'odoo':
        ensure   => $ensure,
        descr    => $descr,
        baseurl  => $baseurl,
        enabled  => 1,
        gpgcheck => 0,
      }
    }
    'Debian': {
      include apt
      include apt::update

      apt::key {'odookey':
        ensure => $ensure,
        id     => $key_id,
        source => $key_url,
        before => Apt::Source['odoo'],
      }

      if $pkg_url != undef {
        $location = $pkg_url
      } else {
        $location = 'http://nightly.odoo.com/10.0/nightly/deb/'
      }

      apt::source {'odoo':
        ensure   => $ensure,
        location => $location,
        comment  => $descr,
        release  => $release,
        repos    => $repos,
        include  => {
          'src' => false,
        },
        notify   => Exec['update-odoo-repos'],
      }

      # Required to wrap apt_update
      exec {'update-odoo-repos':
        refreshonly => true,
        command     => '/bin/true',
        require     => Exec['apt_update'],
      }
    }
    default: {
      warning("OS family ${::osfamily} not supported")
    }
  }
}
