# Change the OS configuration so that it is possible to login with the holberton user

user {'holberton':
  ensure => present,
}

file { '/etc/security/limits.conf':
  ensure  => present,
  content => "holberton soft nofile 4096\nholberton hard nofile 8192\n",
  notify  => Exec['apply_limits'],
}

exec { 'apply_limits':
  command     => '/sbin/sysctl -p',
  refreshonly => true,
}
