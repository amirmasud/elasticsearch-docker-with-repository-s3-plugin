# elasticsearch docker with repository-s3 plugin

you should specify s3 `access key`, `secret key` and `endpoint`
with `ACCESS_KEY`, `SECRET_KEY`, and `ENDPOINT` build args respectively.
In order to use a proxy for plugin installation, provide the `http_proxy` and `https_proxy` build-args. (it will be used by curl)

Also, you can set `PACKAGES` build-arg to specify what extra packages to be installed in the docker image.
The default value of `PACKAGES` is `"net-tools lsof"`.
