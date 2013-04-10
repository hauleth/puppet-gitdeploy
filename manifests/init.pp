# == Class: gitdeploy
#
# Full description of class gitdeploy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { gitdeploy:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Łukasz Niemier <lukasz@niemier.pl>
#
# === Copyright
#
# Copyright 2013 Łukasz Niemier, unless otherwise noted.
#
class gitdeploy ($gituser = 'git', $gitgroup = $gituser, $path = '/var/repositories', $authkeyspath = undef) {
  package { 'git':
    ensure => present
  }

  user { $gituser:
    ensure     => present,
    gid        => $gitgroup,
    home       => $path,
    managehome => true
  }

  file { 'ssh':
    require => User[$gituser],
    path    => "${path}/.ssh",
    ensure  => directory,
    mode    => 700
  }

  if $authkeyspath != undef {
    file { 'authorized_users':
      require => File['ssh'],
      path    => "${path}/.ssh/authorized_keys",
      ensure  => present,
      source  => $authkeyspath,
      mode    => 600
    }
  }
}
