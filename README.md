drushu-vagrant
==============

Vagrant files for drupal shu site


Requirements:

Vagrant:
Vagrant Guest Additions:4.3.10
Chef: 10.12.0

Start the machine with:

vagrant up    

# This will fail when it tries to mount the shared-files directory.  Here is a sample output failure.
=> default: Mounting shared folders...
    default: /var/www => /Users/dan/vagrant/drushu-vagrant/shared-files
Failed to mount folders in Linux guest. This is usually because
the "vboxsf" file system is not available. Please verify that
the guest additions are properly installed in the guest and
can work properly. The command attempted was:

mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` /var/www /var/www
mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` /var/www /var/www


After it fails you can run this to fix it:

vagrant ssh -c "sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions"; 

Then run this to proceed with the setup:

vagrant reload



The software that is installed is:

Ubuntu: 13.04.1
Apache:  2.2.22
Mysql: 5.5.34
PHP:   5.4.9
git: 1.8.1.2
stackcheck:   this just prints out what's installed.  It's my own little python script.
.bash_profile_*:   several bash profile dot files for my own comfy cozy homey feel.

Composer: -- the latest (5.1.2014 tested) 
Drupal: -- the latest  (tested with Drupal 7.27 on 5/2/2014)
Drushu-theme: My own simple (seven based) drupal theme.
Drushu-profile: A small collection of modules that I commonly use.

The installation takes approximately 16 minutes depending on your internet download speed.


You should be able to use the site at this url:

http://localhost:4567/dd/?q=user/login

or:

if you put the ip address in your host /etc/hosts file then you could use this url:

http://drushu:4567/user/login

Todo:  Fix it so that we don't need the forwarded port.

