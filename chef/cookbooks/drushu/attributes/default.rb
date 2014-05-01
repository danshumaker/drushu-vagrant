#
# Cookbook Name:: drushu 
# Attributes:: drupal
#
# Copyright 2008-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


default['drushu']['site-dir'] = '/var/www/dd'

## Parameters for drush si
default['drupal']['account-name'] = 'dan'
default['drupal']['account-pass'] = 'dan'
default['drupal']['account-mail'] = 'danpshumaker@gmail.com'
default['drupal']['host'] = 'localhost'
default['drupal']['database'] = 'drushu'
default['drupal']['db-url'] = "mysql://#{node['drupal']['account-name']}:#{node['drupal']['account-pass']}@#{node['drupal']['host']}/#{node['drupal']['database']}"
default['drupal']['db-su'] = 'root'
default['drupal']['db-su-pw'] = node['mysql']['server_root_password']
default['drupal']['locale'] = 'en'
default['drupal']['site-name'] = 'drushu'
default['drupal']['site-mail'] = 'danpshumaker@gmail.com'

