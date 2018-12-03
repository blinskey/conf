.POSIX:

GIT=git -c advice.detachedHead=false
CLONE=$(GIT) clone --quiet
CHECKOUT=$(GIT) checkout --quiet

install: uninstall
	$(CLONE) --branch v0.3.3 https://github.com/editorconfig/editorconfig-vim.git
	$(CLONE) --branch v1.8.0 https://github.com/w0rp/ale.git
	$(CLONE) https://github.com/Vimjas/vim-python-pep8-indent.git \
		&& cd vim-python-pep8-indent \
		&& $(CHECKOUT) 5f4184fb1200b329e810c1e4c866c86fdf44c135
	$(CLONE) https://github.com/ctrlpvim/ctrlp.vim.git \
		&& cd ctrlp.vim \
		&& $(CHECKOUT) 4b9e7cac612902a25498cca49f13475fe1a821a4
	$(CLONE) https://github.com/blinskey/btl.vim.git \
		&& cd btl.vim \
		&& $(CHECKOUT) 825dfaa15146c585d5138276f8535175d01c7194

uninstall:
	rm -rf */
