SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS = -uec
.PHONY: default deploy plan destroy build-jsonnet clean

default:
	echo "no default target"

SUB_MAKE = make -C
RM = rm -rf

build-jsonnet:
	${SUB_MAKE} jsonnet
CLEAN_DIRS += jsonnet

publish-image:
	./scripts/publish-docker.sh

run-image:
	./scripts/run-docker.sh

validate:
	npx ajv-cli validate -s subProjects.schema.json -d subProjects.json
deploy: validate build-jsonnet
	# deploy infrastructure
	${SUB_MAKE} infrastructure deploy
plan: validate build-jsonnet
	${SUB_MAKE} infrastructure plan
destroy: validate build-jsonnet
	${SUB_MAKE} infrastructure destroy
CLEAN_DIRS += infrastructure

clean:
	# remove each file or folder mentioned in the gitignore
	${RM} $$(cat ./.gitignore)

	# clean each cleanable subdirectory
	for folder in ${CLEAN_DIRS}; do ${SUB_MAKE} $$folder clean ; done
