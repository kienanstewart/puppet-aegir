# Installs a hostmaster on a debian system using the available repos.
# This module should be called from a profile where the other major software
# eg, webserver and db server are decided on.
class aegir::hostmaster (
  # A hash with 'user', 'host', 'password'. Currently only mysql is supported by
  # aegir.
  $database,
  $frontend_url = $::fqdn,
  $version = 3,
  $user = 'aegir', # Unused
  $home = '/var/aegir', # Unused
  # The webserver, apache2 or nginx.
  $server = 'apache2',
  # Commonly available releases: stable, unstable.
  $release = 'stable',
  $makefile = '',
  $email = '',
  $working_copy = false,
  $drush_version = ''
) {
  include apt
  #include stdlib
  apt::source { 'aegir':
    location => 'http://debian.aegirproject.org',
    release  => $release,
    key      => {
      id     => '12782E2257B468806EF36D165ADF93A03376CCF9',
      source => 'http://debian.aegirproject.org/key.asc',
    },
    repos    => 'main'
  }
  $package_name = "aegir${version}"
  $debconf_settings = [
    "${package_name}-hostmaster aegir/site string ${frontend_url}",
    "${package_name}-hostmaster aegir/db_password string ${database['password']}",
    "${package_name}-hostmaster aegir/db_host string ${database['host']}",
    "${package_name}-hostmaster aegir/db_user string ${database['user']}"
  ]
  if $email {
    $debconf_settings += "${package_name}-hostmaster aegir/email string ${email}"
  }
  if $makefile {
    $debconf_settings += "${package_name}-hostmaster aegir/makefile string ${makefile}"
  }
  if $working_copy {
    $debconf_settings += "${package_name}-hostmaster aegir/working-copy boolean true"
  }
  if $drush_version {
    $debconf_settings += "aegir${version}-provision aegir/drush_version string ${drush_version}"
  }
  file { '/etc/dpkg/aegir.response':
    ensure  => 'file',
    content => join($debconf_settings, "\n")
  }
  package { 'aegir':
    ensure       => 'installed',
    name         => $package_name,
    responsefile => '/etc/dpkg/aegir.response',
    require      => [
      Apt::Source['aegir'],
      Class['apt::update'],
      File['/etc/dpkg/aegir.response']
    ]
  }
}
