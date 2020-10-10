#!/bin/sh

/etc/init.d/postgresql start && sleep 5
echo "start postgresql server..."

/etc/init.d/apache2 start && sleep 5
echo "start apache server..."

/etc/init.d/php7.1-fpm start && sleep 5

/bin/bash
