# configuring your server with Puppet
package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => "
server {
    listen 80 default_server;
    server_name _;

    location / {
        root   /var/www/html;
        index  index.html;
	add_header X-Served-By \$HOSTNAME;
    }
    
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}
",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

file { '/var/www/html/custom_404.html':
  ensure  => 'file',
  content => "Ceci n'est pas une page",
  require => Package['nginx'],
}

exec { 'configure_404':
  command => 'sed -i "/server_name _;/a \\\\error_page 404 /custom_404.html;\\nlocation = /custom_404.html {\\n    root /var/www/html;\\n    internal;\\n}\n    add_header X-Served-By $HOSTNAME;\n" /etc/nginx/sites-available/default',
  path    => '/bin:/usr/bin',
  require => File['/var/www/html/custom_404.html'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
