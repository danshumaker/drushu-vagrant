#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# DON'T ECHO ANYTHING BECAUSE IT CAUSES SCP'S TO FAIL.
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# order of LOGIN execution /etc/profile -> ~/.bash_profile -> ~/.bash_login -> ~/.profile
# order of NON-login execution /etc/bash.bashrc -> ~/.bashrc

if [[ -s $HOME/.bash_profile_functions ]]; then
  . $HOME/.bash_profile_functions
  prep .
  addp /usr/sbin
  addp /sbin
  addp /opt/local/bin
  addp /opt/local/apache2/bin
  addp /var/lib/gems/1.8/bin
  addp $HOME/.composer/vendor/bin
  addp $HOME/bin
  addp $HOME/bin/python
  addp $HOME/bin/bash
  addp $HOME/bin/tcsh
  addp $HOME/bin/applescripts
  addp $HOME/bin/php
  addp $HOME/.rvm/bin
fi

export PATH
export HISTSIZE=5000
export HISTTIMEFORMAT="%F %T "
export PS1="BASH\[\033[40m\]\[\033[1;36m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h \[\033[1;33m\]\w \[\033[1;31m\]>>\[\033[0m\]"

if [ -e "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
    mvim="/Applications/MacVim.app/Contents/MacOS/Vim"
    VIM_APP_DIR=/Applications
    export VIM_APP_DIR
fi
mvim=`which vi`

export EDITOR=$mvim
export VISUAL=$mvim
export SVN_EDITOR=$mvim

umask 002

export DRUPAL_ENV_NAME="dan"

# Loads NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . /home/dan/.nvm/nvm.sh 

# Load RVM into a shell session *as a function*
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm 

[[ -s $HOME/.bash_profile_aliases ]] && . $HOME/.bash_profile_aliases
[[ -s $HOME/.bash_profile_projects ]] && . $HOME/.bash_profile_projects
