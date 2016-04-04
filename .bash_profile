export CLICOLOR=1
LS_OPTIONS='--color=auto'
export LSCOLORS=gxfxcxdxbxegedabagacad
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:../node_modules/.bin
export PATH=$PATH:${HOME}/dev/aplscript/bin

PS1='[\w]$ '

[[ -s ${HOME}/.nvm/nvm.sh ]] && . ${HOME}/.nvm/nvm.sh
nvm use node
npm_dir=${NVM_PATH}_modules
export NODE_PATH=$npm_dir

. dnvm.sh
eval "$(rbenv init -)"

test -r ~/.bashrc && . ~/.bashrc
