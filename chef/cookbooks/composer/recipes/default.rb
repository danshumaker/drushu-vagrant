#
# Cookbook Name:: composer
# Recipe:: default
#
# Copyright 2012-2014, Escape Studios
#

include_recipe 'composer::self_update'

if node['composer']['install_globally']
  include_recipe 'composer::global_configs'
end

bash "install-composer-path" do
  code <<-EOH
sed -i '1i export PATH="/home/vagrant/.composer/vendor/bin:$PATH"' /home/vagrant/.bashrc
  EOH
end

