SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS = -uec
.PHONY: build clean

default: build

GOPATH := $(CURDIR)/go

go:
	mkdir -pv ${GOPATH}

go/src/github.com/fatih/color:
	go get github.com/fatih/color

go/src/github.com/google/go-jsonnet:
	go get github.com/google/go-jsonnet

dest := go/src/github.com/google/go-jsonnet/jsonnet/jsonnet

go/src/github.com/google/go-jsonnet/cmd/jsonnet/jsonnet: go/src/github.com/fatih/color go/src/github.com/google/go-jsonnet
	cd go/src/github.com/google/go-jsonnet/cmd/jsonnet
	go build

jsonnet: go/src/github.com/google/go-jsonnet/cmd/jsonnet/jsonnet
	cp $< $@
build: jsonnet

clean:
	rm -rf $$(cat ./.gitignore)