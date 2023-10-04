# configuring your server with Puppet
package { 'nginx':
  ensure => 'installed',
}

$custom_header_config = 'add_header X-Served-By $hostname;'
$config_file = '/etc/nginx/sites-available/default'

file_line { 'add_custom_header':
  ensure => present,
  line   => $custom_header_config,
  match  => 'server_name _;',
  path   => $config_file,
}
