# odoo

[![CircleCI](https://circleci.com/gh/locp/puppet-odoo/tree/master.svg?style=svg)](https://circleci.com/gh/locp/puppet-odoo/tree/master)
[![Build Status](https://travis-ci.org/locp/puppet-odoo.png?branch=master)](https://travis-ci.org/locp/puppet-odoo)
[![Coverage Status](https://coveralls.io/repos/github/locp/puppet-odoo/badge.svg?branch=master)](https://coveralls.io/github/locp/puppet-odoo?branch=master)
[![Join the chat at https://gitter.im/locp/puppet-odoo](https://badges.gitter.im/locp/puppet-odoo.svg)](https://gitter.im/locp/puppet-odoo?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with odoo](#setup)
    * [What odoo affects](#what-odoo-affects)
    * [Beginning with odoo](#beginning-with-odoo)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Install Odoo Communinty edition in a manner similar to that described in
*[Installing Odoo](https://www.odoo.com/documentation/9.0/setup/install.html)*.

## Setup

### What odoo affects

* Installs the `odoo` package from the Odoo repository.
* Configures `/etc/odoo/odoo.conf`.
* Manipulates the running state of the `odoo` service.
* Optionally configures repositories to enable package installations from
  the Odoo nightly builds.
* Optionally installs the `wkhtmltopdf` package from the Odoo repository.

### Beginning with odoo

```puppet
include ::odoo::repo10
include ::odoo
```

or for Odoo 9:

```puppet
include ::odoo::repo9
include ::odoo
```

Do not have both `::odoo::repo9` and `::odoo::repo10` in your catalogue for
the same node as they will both be attempting to update the repository file.

## Usage

The following example will install a basic PostgreSQL database on the
node (using
`[puppetlabs-postgresql](https://forge.puppet.com/puppetlabs/postgresql)`)
it then configures the the Odoo 9 repositories.  It then installs the
`odoo` and `wkhtmltopdf` packages with some settings for the Odoo
server:

```puppet
class { 'postgresql::server':
  before => Class['odoo']
}

class { '::odoo::repo9':
  before => Class['odoo']
}

class { '::odoo':
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
}
```

To do the same for Odoo 10:

```puppet
#
class { 'postgresql::server':
  before => Class['odoo']
}

class { '::odoo::repo10':
  before => Class['odoo']
}

class { '::odoo':
  install_wkhtmltopdf => true,
  settings            => {
    'options' => {
      'admin_passwd' => 'XXX_TOP_SECRET_XXX',
      'db_host'      => 'False',
      'db_port'      => 'False',
      'db_user'      => 'odoo',
      'db_password'  => 'False',
      'addons_path'  => '/usr/lib/python2.7/dist-packages/odoo/addons',
    }
  },
}
```

## Reference

### Public Classes

* [odoo]
  (http://locp.github.io/puppet-odoo/puppet_classes/odoo.html)
* [odoo::repo9]
  (http://locp.github.io/puppet-odoo/puppet_classes/odoo_3A_3Arepo9.html)
* [odoo::repo10]
  (http://locp.github.io/puppet-odoo/puppet_classes/odoo_3A_3Arepo10.html)

## Limitations

This module does not in anyway configure PostgreSQL.

## Development

Contributions will be gratefully accepted. Please go to the project page, fork
the project, make your changes locally and then raise a pull request. Details
on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.
