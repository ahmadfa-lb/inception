<?php

define('DB_NAME', ${MYSQL_DATABASE});
define('DB_USER', ${MYSQL_USER});
define('DB_PASSWORD', ${MYSQL_PASSWORD});
define('DB_HOST', ${MYSQL_HOSTNAME});
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

define('WP_HOME', 'https://localhost/');
define('WP_SITEURL', 'https://localhost/');
define('ABSPATH', '/var/www/wordpress/');


//since we are using wordpress
$table_prefix = 'wp_';

define( 'WP_DEBUG', false );



//Absolute path to the WordPress directory.
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', '/var/www/wordpress' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';