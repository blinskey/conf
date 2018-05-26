.POSIX:

install: plugins helptags

plugins:
	@cd pack/git-plugins/start && make install

helptags:
	@vim -c 'packloadall | silent! helptags ALL | quit'

uninstall:
	@cd pack/git-plugins/start && make uninstall
	@rm pack/tags pack/tags-cn
