# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "raring386"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 4567
  #
  # attempt to get dynamic ips to work.
  #config.vm.network :private_network, type:  :dhcp

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "shared-files", "/var/www"

  #config.vm.hostname "drushu"

  # Upgrade Chef before proceeding
  # For this to work you must have installed the vagrant omnibus plugin.
  # $ vagrant plugin install vagrant-omnibus
  # config.omnibus.chef_version = "10.30.2"

  # Enable provisioning with chef solo, specifying paths for cookbooks and roles
  # (relative to this Vagrantfile)
  #
  config.vm.provision :chef_solo do |chef|
     
     # Cookbooks: a collection of recipes used to configure a machine ("node").
     chef.cookbooks_path = "chef/cookbooks"

     # Roles: used to define which servers get what cookbooks.
     # Each role consists of zero (or more) config details ("attributes")
     # and a run list of recipes to execute.
     chef.roles_path = "chef/roles"
     
     # The name of the role file must be the same as the role name. 
     # For example the web role must be in the roles_path as web.json 
     # or web.rb. This is required by Chef itself, and isn't a limitation 
     # imposed by Vagrant. You can choose from a LAMP stack, or a LAMP stack
     # with Drupal dev tools and Drupal-specific PHP libraries. 
     # The Drupal LAMP Stack (damp_stack) is selected by default.
     # chef.add_role "lamp_stack"
     chef.add_role "shu_stack"

     # override the settings for any of your recipes
     chef.json = {
       "apache" => { 
         "docroot_dir" => "/var/www/",
         "default_site_enabled" => "false",
       },
       "mysql" => { 
         "server_root_password" => "tacoshop",
         "server_repl_password" => "root",
         "server_debian_password" => "root",
       },
     }

     # Additional recipes to execute (in order!)
     # Recipes need to be downloaded, and added to chef-recipes/cookbooks
     # chef.add_recipe "recipe_name"
  
  end

  #config.vm.provision "shell", inline: "echo IP\ Address:\ `ip addr show dev eth1 scope global 2>&1 | grep inet | awk '{print $2}' | awk -F / '{print $1}'`"
end
