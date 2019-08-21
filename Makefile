MAKEFILE := $(lastword $(MAKEFILE_LIST))

GOCMD=go
JSONNETCMD=jsonnet
JSONNETBUNDLERCMD=jb
JSONNET_LIBS=vendor
MANIFESTS_FOLDER=manifests
FILENAME=main.jsonnet

all: clean build

.PHONY: clean
clean:
		rm -rf $(MANIFESTS_FOLDER)
		mkdir $(MANIFESTS_FOLDER)
		
.PHONY: build
build: 
		$(JSONNETCMD) -J $(JSONNET_LIBS) -m $(MANIFESTS_FOLDER) $(FILENAME) \
			| xargs -I{} sh -c 'cat {} \
			| gojsontoyaml > {}.yaml; rm -f {}' -- {}

.PHONY: update
update:
		$(JSONNETBUNDLERCMD) update


install-gojsontoyaml:
		$(GOCMD) get -u github.com/brancz/gojsontoyaml
install-jsonnet:
		$(GOCMD) get -u github.com/google/go-jsonnet/cmd/jsonnet
install-jsonnetbundler:
		$(GOCMD) get -u github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
