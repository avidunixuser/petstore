package {'wget':
   ensure => 'installed',
   before => Exec['add-perforce-key'],
}

exec {'add-perforce-key':
   command => '/usr/bin/wget -q http://package.perforce.com/perforce.pubkey -O - | /usr/bin/apt-key add -',
   require => Package['wget'],
}

exec {'apt-get-update':
   command => '/usr/bin/apt-get -y update',
   require => File['perforce.sources.list'],
}

file {'perforce.sources.list':
   ensure => 'present',
   replace => true,
   path => '/etc/apt/sources.list.d/perforce.sources.list',
   content => 'deb http://package.perforce.com/apt/ubuntu precise release',
   mode => 644,
   owner => 'root',
   group => 'root',
   require => Exec['add-perforce-key'],
}

package {'perforce-cli':
   ensure => installed,
   require => Exec['apt-get-update'],
}


package {'ssh':
  ensure => installed,
  require => Exec['apt-get-update'],
}

package {'supervisor':
  ensure => installed,
  require => Exec['apt-get-update'],
}

package {'openjdk-7-jdk':
  ensure => installed,
  require => Exec['apt-get-update'],
}


file {'/var/run/sshd':
  ensure => directory,
  mode => 644,
  owner => 'root',
  group => 'root',
}


class { 'jetty':
    version => "9.0.4.v20130625",
    home => "/opt",
    user => "jetty",
    group => "jetty",
}
