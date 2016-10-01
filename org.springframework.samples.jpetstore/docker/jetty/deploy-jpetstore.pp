exec {'setip.sh':
   command => /tmp/setip.sh",
   before => File['p4config'],
}



file {'p4config':
   ensure => 'present',
   replace => true,
   path => '/tmp/p4config',
   mode => 644,
   owner => 'root',
   group => 'root',
   content => "P4CLIENT=p4deploy\nP4PORT=$docker_host_ip:1666\nP4USER=perforce\nP4PASSWD=C4FD4B741DFC58FA01CA26D3BF85C528",
   before => Vcsrepo['jpetstore'],
}
   

vcsrepo {'jpetstore':
   provider => 'p4',
   ensure => latest,
   source => '//streamsDepot/mainline/org.springframework.samples.jpetstore/builds/...',
   p4config => '/tmp/p4config',
   path => '/tmp/p42',
   require => File['p4config'],
}

file { 'jpetstore-war':
   ensure => '/var/lib/tomcat6/webapps/jpetstore.war',
   path => '/var/lib/tomcat6/webapps/jpetstore.war',
   replace => true,
   source => '/tmp/p42/org.springframework.samples.jpetstore/builds/org.springframework.samples.jpetstore-1.0.42-SNAPSHOT.war',
   mode => 644,
   owner => 'root',
   group => 'root',
   require => Vcsrepo['jpetstore'],
}
