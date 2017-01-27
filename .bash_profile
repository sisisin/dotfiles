export CLICOLOR=1
LS_OPTIONS='--color=auto'
export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:../node_modules/.bin
export PATH=$PATH:${HOME}/dev/aplscript/bin
export PLAY_MAILER_PORT=25000
export PGDATA=/usr/local/var/postgres

PS1='[\w]$ '

[[ -s ${HOME}/.nvm/nvm.sh ]] && . ${HOME}/.nvm/nvm.sh
nvm use default 
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir

eval "$(rbenv init -)"

test -r ~/.bashrc && . ~/.bashrc

# extends bash_profile
if [ -e ~/.bash_profile_optional ]; then
    bash ~/.bash_profile_optional
fi
