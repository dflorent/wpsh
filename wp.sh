#!/usr/bin/env bash

if ! which curl >/dev/null; then
    echo "I require curl but it's not installed. Aborting..."
    exit 1
fi

# wordpress download
curl -O https://fr.wordpress.org/latest-fr_FR.tar.gz
tar -xvzf latest-fr_FR.tar.gz
rm latest-fr_FR.tar.gz
mv wordpress/* .
rm -rf wordpress

# security stuff
rm readme.html

# uploads dir permissions
mkdir wp-content/uploads
chmod 777 wp-content/uploads

# wp-config

# todo...
# copy wp-confip-sample.php into wp-config.php
# dowload and insert salt string inside wp-config.php
# database name ?
# replace database name
# database user ?
# replace database user
# database password ?
# replace database password

# theme creation

# todo...
# do you want create a theme ?
# do you want remove default themes ?
# theme name ?
# description ?
# version ?
# author ?
# author URI ?
rm -rf wp-content/themes/*
mkdir wp-content/themes/mytheme
touch wp-content/themes/mytheme/index.php
touch wp-content/themes/mytheme/functions.php
touch wp-content/themes/mytheme/style.css
curl -o wp-content/themes/mytheme/screenshot.png http://fakeimg.pl/600x450?text=mytheme

echo "Done. You're ready!"
