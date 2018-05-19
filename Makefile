.POSIX:

help:
	@echo "Available targets: "
	@echo
	@echo "  freebsd"
	@echo "  linux"
	@echo "  mac"
	@echo "  openbsd"

freebsd openbsd: common ksh

linux: common ksh bash

mac: common bash

common: vim tmux ctags inputrc git go mutt

vim:
	mkdir -p ~/.vim/ftplugin
	cp -f  .vimrc ~
	cp -rf .vim/ftplugin/* ~/.vim/ftplugin
	cp -rf .vim/autoload/plug.vim ~/.vim/autoload

tmux:
	cp -f .tmux.conf ~

ctags:
	cp -f .ctags ~

ksh:
	cp -f .profile ~
	cp -f .kshrc ~
	cp -f .aliases ~

bash:
	cp -f .bash_profile ~
	cp -f .bashrc ~
	cp -f .aliases ~

inputrc:
	cp -f .inputrc ~

editrc:
	cp -f .edirc ~

git:
	# Note that .gitconfig isn't copied here, since it needs to be manually
	# customized in certain environments.
	cp -f .gitignore_global ~

go:
	mkdir -p ~/go
	ln -fs ~/go ~/src

mutt:
	mkdir -p ~/.mutt ~/.cache/mutt
	cp -f .mutt/muttrc ~/.mutt
	cp -f .mailcap ~

lynx:
	mkdir ~/.lynx
	cp -f .lynxrc ~
	cp -f lynx.cfg ~/.lynx
