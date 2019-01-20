# elasticsearch docker with repository-s3 plugin

you should specify s3 `access key`, `secret key` and `endpoint`
with `ACCESS_KEY`, `SECRET_KEY`, and `ENDPOINT` build args respectively.

Also, you can set `PACKAGES` build-arg to specify what extra packages to be installed in the docker image.
The default value of `PACKAGES` is `"net-tools lsof"`.
