This is the CICD repository for the CCNA Integration Platform (INT) project.

## Project requirements:
* terraform
* make
Default on MacOS

* go
> brew install go

* Set AWS_PROFILE
> export AWS_PROFILE=CCNA_INTSRVC_NonProd_INT_AppAdmin

## Deploy Terraform:

```
make plan
# verify plan output
make deploy
```

## Updating Docker Image

```
# make necessary updates to docker file
make publish-image
# open settings.json and set docker.version to the appropriate version
# commit/push changes
```