# fix stack to get 0 requests failed

$ulimit_value = '1048576'

file { '/etc/default/nginx':
  ensure  => file,
  content => "ULIMIT=\"-n ${ulimit_value}\"\n",
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/default/nginx'],
}
