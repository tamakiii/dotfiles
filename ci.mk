install: update deploy init
	make install

init:
  make -f brew.mk
	make -f config.mk
	make -C etc/init
	fish -c "fisher"

update:
	make update

init:
	make init