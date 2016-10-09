# odoo9

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with odoo9](#setup)
    * [What odoo9 affects](#what-odoo9-affects)
    * [Beginning with odoo9](#beginning-with-odoo9)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Install Odoo 9 Communinty edition in a manner similar to that described in
*[Installing Odoo](https://www.odoo.com/documentation/9.0/setup/install.html)*.

## Setup

### What odoo9 affects

* Installs the `odoo` package from the Odoo repository.
* Configures `/etc/odoo/openerp-server.conf`.
* Manipulates the running state of the `odoo` service.
* Optionally configures repositories to enable package installations from
  the Odoo nightly builds.
* Optionally installs the `wkhtmltopdf` package from the Odoo repository.

### Beginning with odoo9

```puppet
include ::odoo9
```

## Usage

The following example will install a basic PostgreSQL database on the
node (using
`[puppetlabs-postgresql](https://forge.puppet.com/puppetlabs/postgresql)`)
it then configures the the Odoo repositories.  It then installs the
`odoo` and `wkhtmltopdf` packages with some settings for the Odoo
server:

```puppet
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
```

## Reference

### Attributes

#### Class odoo9

##### `install_wkhtmltopdf`
Whether or not to install the optional `wkhtmltopdf` package from the Odoo
repository.
Default value **false**.

##### `settings`
A hash of settings to be passed to the `create_ini_settings` (see
https://forge.puppet.com/puppetlabs/inifile#manage-multiple-ini_settings
for details).  The following defaults are provided:

```puppet
{
  path    => '/etc/odoo/openerp-server.conf',
  require => Package['odoo'],
  notify  => Service['odoo'],
}
```

##### `version`
The version of the `odoo` package to be installed.  Valid values are
**present**, **latest** or the version of the version of the package to be
installed ('i.e. *9.0c.20161009*).

#### Class odoo9::repo

##### `descr`
The name of the repository to be configured.
Default value 'Odoo Nightly repository'

##### `key_id`
The key for the Debian APT repository.  This option is ignored on the
Red Hat family.
Default value '5D134C924CB06330DCEFE2A1DEF2A2198183CBB5'

##### `pkg_url`
The URL to the package on the repository.  It defaults to
**http://nightly.odoo.com/9.0/nightly/rpm/** on the Red Hat family and
**http://nightly.odoo.com/9.0/nightly/deb/**.

##### `pkg_url`
The release for the Debian APT repository.  This option is ignored on the
Red Hat family.
Default value './'

##### `repos`
The repos for the Debian APT repository.  This option is ignored on the
Red Hat family.
Default value ''

## Limitations

At the moment this module has only been tested against Ubuntu 14.  Also this
module does not in anyway configure PostgreSQL.

## Development

Contributions will be gratefully accepted. Please go to the project page, fork
the project, make your changes locally and then raise a pull request. Details
on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.
