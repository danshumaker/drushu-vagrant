maintainer       "Dan Shumaker"
maintainer_email "danpshumaker@gmail.com"
license          "Apache 2.0"
description      "Installs drupal drushu profile"
version          "0.9.0"
depends         "drush"
recipe "drushu", "Installs drupal via drush si and github makefile"

%w{ debian ubuntu arch }.each do |os|
  supports os
end
