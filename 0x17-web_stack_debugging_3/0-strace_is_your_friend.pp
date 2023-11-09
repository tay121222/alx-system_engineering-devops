# Script that fix why Apache is returning a 500 error
file { '/var/www/html/wp-includes/wp-settings.php':
  ensure  => 'file',
  content => file('/var/www/html/wp-includes/wp-settings.php')
    =~ s/(require\( ABSPATH . WPINC . '\/class-wp-locale.phpp' \);)/require_once( ABSPATH . WPINC . '\/class-wp-locale.php' );/r,
}
