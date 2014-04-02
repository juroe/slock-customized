default: build

require-root:
	@if [ "$$(id -u)" '!=' '0' ]; then (echo 'You must be root for this action.'; exit 1); fi

build:
	$(MAKE) clean
	$(MAKE) checkout
	$(MAKE) inject-patch-colors

clean:
	@-rm -rf slock 

checkout:
	git clone http://git.suckless.org/slock

inject-patch-colors:
	cp slock-colors.diff ./slock
	cd ./slock && patch -p1 < slock-colors.diff

install: require-root
	$(MAKE) -C ./slock
	$(MAKE) -C ./slock install
