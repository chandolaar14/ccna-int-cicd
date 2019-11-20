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
# It's critical to pull the latest changes from the CICD pipeline so you don't overwrite changes that aren't local
git pull
make plan
# verify plan output
make deploy
```

## Updating Docker Image

```
# make necessary updates to docker file
# update the version in settings.json
make publish-image
# update dmake.sh to use correct version
# follow deploy plan above
```