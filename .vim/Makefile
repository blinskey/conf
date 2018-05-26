.POSIX:

install: plugins helptags

plugins:
	@cd pack/git-plugins/start && make install

helptags:
	@vim -c 'packloadall | silent! helptags ALL | quit'

clean:
	@cd pack/git-plugins/start && make clean
	@rm pack/tags pack/tags-cn
