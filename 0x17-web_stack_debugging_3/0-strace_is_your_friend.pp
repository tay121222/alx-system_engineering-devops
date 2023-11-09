# Script that fix why Apache is returning a 500 error
file { '/var/www/html/wp-settings.php':
  ensure  => file,
  require => File['/var/www/html'],
  notify  => Service['apache2'],
  before  => Exec['fix-wordpress'],
}

exec { 'fix-wordpress':
  command     => 'sed -i "s/require( ABSPATH . WPINC . \'\/class-wp-locale.phpp\' );/' \
  'require_once( ABSPATH . WPINC . \'\/class-wp-locale.php\' );/g" ' \
  '/var/www/html/wp-settings.php',
  refreshonly => true,
}
