# Author:: Dan Shumaker
# Cookbook Name::  drush
# Recipe:: composer
#
# limitations under the License.
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

execute 'composer-drush' do
  command <<-EOH
composer global require drush/drush:dev-master
mv /root/.composer /home/vagrant/
chown -R vagrant.vagrant /home/vagrant/.composer
EOH
    not_if { File.exists?("/home/vagrant/.composer") }
end
