SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.SHELLFLAGS = -uec
.PHONY: build clean

default: build

GOPATH := $(CURDIR)/go

go:
	mkdir -pv ${GOPATH}

go/src/github.com/fatih/color:
	go get github.com/fatih/color

go/src/github.com/google/go-jsonnet:
	mkdir -p go/src/github.com/google/go-jsonnet
	git clone https://github.com/google/go-jsonnet.git go/src/github.com/google/go-jsonnet
	cd go/src/github.com/google/go-jsonnet && git checkout tags/v0.12.1 && rm -rf .git

go/src/github.com/google/go-jsonnet/jsonnet/jsonnet: go/src/github.com/fatih/color go/src/github.com/google/go-jsonnet
	cd go/src/github.com/google/go-jsonnet/jsonnet && go build

jsonnet: go/src/github.com/google/go-jsonnet/jsonnet/jsonnet
	cp $< $@
build: jsonnet

clean:
	rm -rf $$(cat ./.gitignore)