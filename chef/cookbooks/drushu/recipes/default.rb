# Author:: Dan Shumaker
# Cookbook Name::  drush
#

#results = "/tmp/output.txt"
#file results do
#    action :delete
#end
#
#cmd = "composer global require drush/drush:dev-master"
#bash cmd do
#    user 'vagrant'
#    group 'vagrant'
#    code <<-EOH
#    #{cmd} &> #{results}
#    EOH
#end
#
#ruby_block "Results" do
#    only_if { ::File.exists?(results) }
#    block do
#        print "\n"
#        File.open(results).each do |line|
#            print line
#        end
#    end
#end
#
#

# execute "install q and zombiejs" do                                             
#    cwd "/home/vagrant"                                                           
#    user "vagrant"                                                                
#    action :run   
#    environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})                                                             
#    command "npm install -g q zombie should mocha coffee-script"                  
#end

#execute "npm_install" do
#    command "su vagrant -l -c 'cd /shared-with-host/helperScripts/ && bash -i npm install -g q zombie should mocha coffee-script'" 
#    action :run
#end
#
#execute 'composer-drush' do
#  command <<-EOH
#composer global require drush/drush:dev-master
#mv /root/.composer /home/vagrant/
#chown -R vagrant.vagrant /home/vagrant/.composer
#EOH
#    not_if { File.exists?("/home/vagrant/.composer") }
#end
#case node[:platform]
#when "debian", "ubuntu"
#  bash "install-drush" do
#    code <<-EOH
#(cd /tmp; wget http://ftp.drupal.org/files/projects/drush-7.x-5.8.tar.gz)
#(cd /tmp; tar zxvf drush-7.x-5.8.tar.gz)
#(cd /tmp; mv drush /usr/share/)
#(ln -s /usr/share/drush/drush /usr/bin/drush)
#(pear install Console_Table)
#    EOH
#    not_if { File.exists?("/usr/share/drush/drush") }
#  end
#end
case node[:platform]
when "debian", "ubuntu"

  execute "chown /usr/local/bin" do
    command "chown -R vagrant.vagrant /usr/local/bin"
  end

# this git didn't work for some reason: so moving to raw wget
#  git "/usr/local/bin/stackcheck" do
#    repository "git://github.com/danshumaker/stackcheck.git"
#    revision "master"
#    action :sync
#  end
  
#  execute "wget stackcheck" do
#    cwd "/usr/local/bin"
#    command "wget https://raw.githubusercontent.com/danshumaker/stackcheck/master/stackcheck"
#    chmod 755 stackcheck
#    not_if { File.exists?("/usr/local/bin/stackcheck") }
#  end

  remote_file "Stack Check Python Script from github" do
    path "/usr/local/bin/stackcheck"
    source "https://raw.githubusercontent.com/danshumaker/stackcheck/master/stackcheck"
    mode 0755 
    not_if { File.exists?("/usr/local/bin/stackcheck") }
  end

  cookbook_file "PERSONAL BASH PROFILE" do
    path "/home/vagrant/.bash_profile"
    user "vagrant"
    group "vagrant"
    source ".bash_profile"
    mode 0700
  end
  cookbook_file "PERSONAL BASH PROFILE Aliases" do
    path "/home/vagrant/.bash_profile_aliases"
    user "vagrant"
    group "vagrant"
    source ".bash_profile_aliases"
    mode 0700
  end
  cookbook_file "PERSONAL BASH PROFILE functions" do
    path "/home/vagrant/.bash_profile_functions"
    user "vagrant"
    group "vagrant"
    source ".bash_profile_functions"
    mode 0700
  end

  execute "wget drushu.make" do
    cwd "/var/www"
    command "wget https://raw.githubusercontent.com/danshumaker/drushu/master/drushu.make"
    not_if { File.exists?("/var/www/drushu.make") }
  end

  execute "add vagrant user to sudoers" do
    command "sudo adduser vagrant sudo"
  end

  ## Will not delete full directories
  #directory node['drushu']['site-dir'] do
  #  action:delete
  #end

  execute "delete old site dir" do
    command "rm -rf #{node['drushu']['site-dir']}"
  end

  directory node['drushu']['site-dir'] do
    owner "vagrant"
    group "vagrant"
    mode 0755
    action:create
    not_if { File.exists?(node['drushu']['site-dir']) }
  end

  execute "drush make drushu.make" do
    environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant', 'PATH' => '/home/vagrant/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:.'})                                                             
    user 'vagrant'
    group 'vagrant'
    cwd node['drushu']['site-dir']
    command "drush make ../drushu.make -y"
    only_if { File.exists?("/var/www/drushu.make") }
    not_if { File.exists?("#{node['drushu']['site-dir']}/.htaccess") }
  end

  execute "drush si drushu" do
    environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant', 'PATH' => '/home/vagrant/.composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:.'})                                                             
    user 'vagrant'
    group 'vagrant'
    cwd node['drushu']['site-dir']
    command "drush -vd si drushu --account-name=#{node['drupal']['account-name']} --account-pass=#{node['drupal']['account-pass']} --account-mail=#{node['drupal']['account-mail']} --db-url=#{node['drupal']['db-url']} --db-su=#{node['drupal']['db-su']} --db-su-pw=#{node['drupal']['db-su-pw']} --locale=#{node['drupal']['locale']} --site-name=#{node['drupal']['site-name']} --site-mail=#{node['drupal']['site-mail']} -y"
  end

  web_app node['drupal']['site-name'] do
    cookbook 'drushu'
    docroot node['drushu']['site-dir']
    server_name node['drupal']['site-name'] 
    #server_aliases [ "blog.#{node['domain']}", node['fqdn'] ]
  end
end
