wpsh
====

This script downloads and installs the latest version of WordPress in french with a simple command in your terminal using an alias in your .bashrc (or .bash_profile, .zshrc...) file. You can also initialize the wp-config.php file, set up a minimal theme and create your database.

Usage
-----

```
git clone https://github.com/dflorent/wpsh.git
mv wpsh ~/.wpsh
echo "alias wpsh='sh -c ~/.wpsh/wp.sh'" >> ~/.bashrc
chmod a+x ~/.wpsh/wp.sh
cd /path/to/your/project
wpsh
```
