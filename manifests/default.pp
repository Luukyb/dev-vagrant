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
  package { "php5-cli":
    ensure  => present,
  }
  package { "php5-mysql":
    ensure  => present,
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
