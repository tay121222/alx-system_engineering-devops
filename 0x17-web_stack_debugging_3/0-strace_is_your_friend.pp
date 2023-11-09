# Script that fix why Apache is returning a 500 error
file { '/var/www/html/wp-settings.php':
  ensure  => file,
  require => File['/var/www/html'],
  notify  => Service['apache2'],
  before  => Exec['fix-wordpress'],
}

$file_path = '/var/www/html/wp-settings.php'
exec { 'fix_wordpress':
  command => "sed -i 's/class-wp-locale.phpp/class-wp-locale.php/' ${file_path}",
  path    => ['/bin', '/usr/bin'],
  refreshonly => true,
}
