SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS = -uec
.PHONY: default deploy plan destroy clean

default:
	echo "no default target"

SUB_MAKE = make -C

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

format:
	# format jsonnet and libsonnet
	find . -type f | egrep '.*\.(j|lib)sonnet$$' | xargs -n1 jsonnetfmt -i
	# format json
	find . -type f | egrep '.*\.json$$' | xargs npx prettier --write

clean:
	git clean -fdX
