define gitdeploy::project ($name = $title,
                           $path,
                           $reponame = $name,
                           $repopath = '/var/repositories',
                           $branch = 'master') {
  $repo = "${repopath}/${name}.git"

  file { $path:
    ensure  => directory,
    recurse => true
  }

  exec { 'create-repo':
    command => "git init --bare ${repo}"
  }

  file { 'post-receive':
    require => Exec['createrepo'],
    path    => "${repo}/hooks/post-receive",
    ensure  => present,
    content => template('gitdeploy/post-receive.erb'),
    mode    => 755
  }
}
