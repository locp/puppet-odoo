# odoo9

[![CircleCI](https://circleci.com/gh/locp/puppet-odoo/tree/master.svg?style=svg)](https://circleci.com/gh/locp/puppet-odoo/tree/master)
[![Build Status](https://travis-ci.org/locp/puppet-odoo.png?branch=master)](https://travis-ci.org/locp/puppet-odoo)
[![Coverage Status](https://coveralls.io/repos/github/locp/puppet-odoo/badge.svg?branch=master)](https://coveralls.io/github/locp/puppet-odoo?branch=master)
[![Join the chat at https://gitter.im/locp/puppet-odoo](https://badges.gitter.im/locp/puppet-odoo.svg)](https://gitter.im/locp/puppet-odoo?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Table of Contents

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

This module has now been renamed to locp-odoo.  Please see the following:

* https://forge.puppet.com/locp/odoo
* https://github.com/locp/puppet-odoo

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

### Public Classes

* [odoo9]
  (http://locp.github.io/puppet-odoo/puppet_classes/odoo9.html)
* [odoo9::repo]
  (http://locp.github.io/puppet-odoo/puppet_classes/odoo9_3A_3Arepo.html)

## Limitations

At the moment this module has only been tested against Ubuntu 14.  Also this
module does not in anyway configure PostgreSQL.

## Development

Contributions will be gratefully accepted. Please go to the project page, fork
the project, make your changes locally and then raise a pull request. Details
on how to do this are available at
https://guides.github.com/activities/contributing-to-open-source.
