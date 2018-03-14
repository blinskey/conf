.POSIX:

SRC_DIR = ~/src/config-files

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

common: vim tmux ctags inputrc git

vim:
	mkdir -p ~/.vim/ftplugin
	ln -fs $(SRC_DIR)/.vimrc ~
	ln -fs $(SRC_DIR)/.vim/ftplugin/* ~/.vim/ftplugin
	ln -fs $(SRC_DIR)/.vim/autoload/plug.vim ~/.vim/autoload

tmux:
	ln -fs $(SRC_DIR)/.tmux.conf ~

ctags:
	ln -fs $(SRC_DIR)/.ctags ~

ksh:
	ln -fs $(SRC_DIR)/.profile ~
	ln -fs $(SRC_DIR)/.kshrc ~

bash:
	ln -fs $(SRC_DIR)/.bash_profile ~
	ln -fs $(SRC_DIR)/.bashrc ~

inputrc:
	ln -fs $(SRC_DIR)/.inputrc ~

git:
	# .gitconfig needs to be customized in certain environments, so we don't
	# link it.
	cp $(SRC_DIR)/.gitconfig ~
	ln -fs $(SRC_DIR)/.gitignore_global ~

go:
	mkdir ~/go
	ln -fs ~/go ~/src
