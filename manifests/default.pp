exec { "apt-get update":
  path => "/usr/bin",
}
class apache {
  package { "apache2":
    ensure  => present,
    require => Exec["apt-get update"],
  }
  service { "apache2":
    ensure  => "running",
    require => Package["apache2"],
  }
}
class php {
  package { "php5":
    ensure  => present,
  }
  #package { "libapache2-mod-php5":
  #  ensure => present,
  #}
  package { "php5-cli":
    ensure  => present,
  }
  package { "php5-mysql":
    ensure  => present,
  }
  package { "libaugeas-ruby":
    ensure => present,
  }
  # php.ini config
  augeas { 'php_dev_config':
    #context => '/files/etc/php5/cli/php.ini',
    changes => [
      'set /files/etc/php5/cli/php.ini/max_execution_time 60',
    ],
    require => Package['php5'],
    #notify => Exec['reload apache']
  }
}
class mysql {
  package { "mysql-server":
    ensure  => present,
  }
  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }
  exec { "set-mysql-password":
    path    => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password root",
    require => Service["mysql"],
  }
  #package { "phpmyadmin":
  #  ensure  => present,
  #}
}
