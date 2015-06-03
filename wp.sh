#!/usr/bin/env bash

if ! which curl >/dev/null; then
    echo "I require curl but it's not installed. Aborting..."
    exit
fi

if ! which mysql >/dev/null; then
    echo "I require mysql but it's not installed. Aborting..."
    exit
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
chmod -R 777 wp-content/uploads

# wp-config
echo 'Do you want create wp-config (y/n)?'
read -e awser
if [ "$awser" == y ] ; then
    cp wp-config-sample.php wp-config.php
    
    echo 'Database name?'
    read -e dbname
    sed -i '' 's/votre_nom_de_bdd/'$dbname'/g' wp-config.php
    
    echo 'Database user?'
    read -e dbuser
    sed -i '' 's/votre_utilisateur_de_bdd/'$dbuser'/g' wp-config.php
    
    echo 'Database password?'
    read -s dbpass
    sed -i '' 's/votre_mdp_de_bdd/'$dbpass'/g' wp-config.php
    
    echo 'Table prefix?'
    read -e prefix
    sed -i '' 's/wp_/'$prefix'/g' wp-config.php
    
    # todo...
    # dowload and insert salt string inside wp-config.php
fi

# database
echo 'Do you want create the database (y/n)?'
read -e awser
if [ "$awser" == y ] ; then
    mysql -u $dbuser -p -e "CREATE DATABASE IF NOT EXISTS "$dbname";"
fi

# theme
echo 'Do you want create a theme (y/n)?'
read -e awser
if [ "$awser" == y ] ; then
    echo 'Do you want remove default themes (y/n)?'
    read -e awser
    if [ "$awser" == y ] ; then
        rm -rf wp-content/themes/*
    fi
    echo 'Theme name?'
    read -e theme_name
    echo 'Theme description?'
    read -e theme_description
    echo 'Theme version?'
    read -e theme_version
    echo 'Theme author?'
    read -e theme_author
    echo 'Theme author uri?'
    read -e theme_author_uri
    mkdir wp-content/themes/$theme_name
    touch wp-content/themes/$theme_name/index.php
    touch wp-content/themes/$theme_name/functions.php
    touch wp-content/themes/$theme_name/style.css
    echo "/*!
 * Theme Name: $theme_name
 * Description: $theme_description
 * Version: $theme_version
 * Author: $theme_author
 * Author URI: $theme_author_uri
 */" >> wp-content/themes/$theme_name/style.css
    curl -o wp-content/themes/$theme_name/screenshot.png http://fakeimg.pl/600x450/?text=$theme_name 
fi

echo "Done."
