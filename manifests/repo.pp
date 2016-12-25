# Install a repository to install an Odoo 9 package from.
#
# @param descr [string] A string to describe the repository.
class odoo9::repo (
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
        $baseurl = 'http://nightly.odoo.com/9.0/nightly/rpm/'
      }

      yumrepo { 'odoo':
        ensure   => present,
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
        id     => $key_id,
        source => $key_url,
        before => Apt::Source['odoo'],
      }

      if $pkg_url != undef {
        $location = $pkg_url
      } else {
        $location = 'http://nightly.odoo.com/9.0/nightly/deb/'
      }

      apt::source {'odoo':
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
