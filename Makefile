webapp = web
sys = .sys

.PHONY: all renew renew-nitrogen

all:
#	git add  --all
#	git status
#	@echo Then remember to commit and push.

renew:
	$(webapp)/bin/nitrogen stop || true
	rm -rf $(webapp)
	pushd .sys/nitrogen &&\
		make rel_cowboy PROJECT=$(webapp) PREFIX=../.. &&\
		popd
#	git checkout $(webapp)/site ## use the line to hold all your work
	$(webapp)/bin/nitrogen start

renew-nitrogen: install-nitrogen renew

## private entry

install-nitrogen:
	rm -rf $(sys) || true
	mkdir $(sys)
	git config --global url.https://github.com/.insteadOf git://github.com/
	git clone git://github.com/nitrogen/nitrogen.git $(sys)/nitrogen || true
