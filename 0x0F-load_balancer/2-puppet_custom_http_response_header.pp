# configuring your server with Puppet
package { 'nginx':
  ensure => 'installed',
}

$custom_header_config = 'add_header X-Served-By $HOSTNAME;'
$config_file = '/etc/nginx/sites-available/default'

file_line { 'add_custom_header':
  ensure => present,
  line   => $custom_header_config,
  match  => 'listen 80 default_server;',
  path   => $config_file,
  require => Package['nginx'],
  before => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File_line['add_custom_header'],
}
