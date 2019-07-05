SHELL=/bin/bash
.EXPORT_ALL_VARIABLES:
.ONESHELL:
.SHELLFLAGS = -uec
.PHONY: default plan clean destroy

TF = terraform
JSONNET = jsonnet
RM = rm -rf

default:
	echo "no default target"

plan:
	${JSONNET} index.tf.jsonnet > index.tf.json
	rm -rf .terraform
	${TF} init
	${TF} plan -out plan
	${TF} plan plan

deploy:
	${JSONNET} index.tf.jsonnet > index.tf.json
	rm -rf .terraform
	${TF} init
	${TF} apply --auto-approve --input=false
	${TF} output -json > output.json

destroy:
	${JSONNET} index.tf.jsonnet > index.tf.json
	rm -rf .terraform
	${TF} init
	${TF} destroy --auto-approve --input=false

clean:
	${RM} $$(cat ./.gitignore)
