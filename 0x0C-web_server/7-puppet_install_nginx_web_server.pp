# configuring your server with Puppet
package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.nginx-debian.html':
  content => 'Hello World!',
  ensure  => 'file',
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure => 'present',
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify => Service['nginx'],
}

file { '/var/www/html/custom_404.html':
  content => "Ceci n'est pas une page",
  ensure  => 'file',
  require => Package['nginx'],
}

exec { 'configure_404':
  command => 'sed -i "/server_name _;/a \\\\nerror_page 404 /custom_404.html;\\nlocation = /custom_404.html {\\n    root /var/www/html;\\n    internal;\\n}" /etc/nginx/sites-available/default',
  path    => '/bin:/usr/bin',
  require => File['/var/www/html/custom_404.html'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
}
