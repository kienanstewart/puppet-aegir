# aegir

## Module Description

This module is intended to install aegir simply.

## Requirements

Modules from forge.puppet.com:

* puppetlabs-stdlib (tested with 4.13.1)
* puppetlabs-apt (tested with 2.3.0)

Currently only supports installation through debian packages.

## Setup

Nothing special.

## Usage

@TODO

## Reference

### Classes

#### Public Classes

* aegir::hostmaster

### Class: aegir::hostmaster

Debian package based hostmaster installation.

Parameters:

* database: A hash containing user, host, and password. Required.
* frontend_url: The url for the hostmaster drupal installation. Optional, defaults to the fully qualified domain name.
* version: The major aegir version to install. Optional, default: 3
* user: The user name to use for the installation of aegir. Optional, default: aegir
* home: The home directory of the user. Optional, default: /var/aegir
* server: Which webserver to use. Optional, default: apache. Supports: apache2, nginx
* release: Which release to use from the package source. Optional, default: stable.
* makefile: If a custom makefile should be used, specify it here. Optional, default: ''
* email: The email to set for the admin user in the hostmaster installation. Optional, default: '' (aegir will pick the user@fqdn).
* working_copy: Keep the hostmaster platform git directories? Optional, default: false.
* drush_version: Which version of drush to install with provision. Optional, default '' (stable).
