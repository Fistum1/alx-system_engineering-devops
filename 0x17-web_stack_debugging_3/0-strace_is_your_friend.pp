# It fixes bad `phpp` extensions to `php` in the WP file `wp-settings.php`.

exec { 'fix-wordpress':
  command => 'sed -i s/phpp/php/g /var/www/html/wordpress/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
}
