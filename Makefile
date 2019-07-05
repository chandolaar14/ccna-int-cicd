SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS = -uec
.PHONY: default deploy plan destroy clean

default:
	echo "no default target"

SUB_MAKE = make -C
RM = rm -rf

publish-image:
	./scripts/publish-docker.sh

run-image:
	./scripts/run-docker.sh

validate:
	npx ajv-cli validate -s subProjects.schema.json -d subProjects.json
deploy: validate
	# deploy infrastructure
	${SUB_MAKE} infrastructure deploy
plan: validate
	${SUB_MAKE} infrastructure plan
destroy: validate
	${SUB_MAKE} infrastructure destroy
CLEAN_DIRS += infrastructure

format:
	find . -type f | egrep '.*\.(j|lib)sonnet' | xargs -n1 jsonnetfmt -i

clean:
	# remove each file or folder mentioned in the gitignore
	${RM} $$(cat ./.gitignore)

	# clean each cleanable subdirectory
	for folder in ${CLEAN_DIRS}; do ${SUB_MAKE} $$folder clean ; done
