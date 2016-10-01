file {'p4config':
   ensure => 'present',
   replace => true,
   path => '/tmp/p4config',
   mode => 644,
   owner => 'root',
   group => 'root',
   content => "P4CLIENT=$hostname\nP4PORT=$dockerhostip:1666\nP4USER=deploy\n",
   before => Exec['createp4client'], 
}


exec {'createp4client':
  command => '/usr/bin/p4 client -o -S //petshop/trunk-deploy | /usr/bin/p4 client -i',
  cwd => '/tmp',
  environment => 'P4CONFIG=/tmp/p4config',
}


exec {'p4-sync':
  command => '/usr/bin/p4 sync',
  environment => 'P4CONFIG=/tmp/p4config',
  cwd => '/tmp/',
  require => Exec['createp4client'],
}

file {'/opt/jetty/webapps/root.war':
  ensure => 'present',
  replace => true,
  source => '/tmp/org.springframework.samples.jpetstore/builds/jpetstore.war',
  require => Exec['p4-sync'],
}

file {'/opt/jpetstore-db':
  ensure => directory,
  source => '/tmp/org.springframework.samples.jpetstore/builds/hsqldb',
  recurse => true,
  replace => true,
  owner => 'root',
  group => 'root',
  mode => 644,
  require => Exec['p4-sync'],
}
