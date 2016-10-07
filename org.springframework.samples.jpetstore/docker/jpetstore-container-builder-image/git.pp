exec {'git-clone':
  command => '/usr/bin/git clone git@github.com:avidunixuser/petstore.git',
  cwd => '/tmp/',
}

file {'/opt/jetty/webapps/root.war':
  ensure => 'present',
  replace => true,
  source => '/tmp/org.springframework.samples.jpetstore/builds/jpetstore.war',
  require => Exec['git-clone'],
}

file {'/opt/jpetstore-db':
  ensure => directory,
  source => '/tmp/org.springframework.samples.jpetstore/builds/hsqldb',
  recurse => true,
  replace => true,
  owner => 'root',
  group => 'root',
  mode => 644,
  require => Exec['git-clone'],
}
