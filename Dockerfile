FROM docker.elastic.co/elasticsearch/elasticsearch:6.6.0

ARG ACCESS_KEY
ARG SECRET_KEY
ARG ENDPOINT

ARG PLUGIN_INSTALL_PROXY=""

ARG PACKAGES="net-tools lsof"

RUN  if [ -n "${PACKAGES}" ]; then  yum install -y $PACKAGES && yum clean all && rm -rf /var/cache/yum; fi
RUN proto="$(echo $PLUGIN_INSTALL_PROXY | grep :// | sed -e's,^\(.*://\).*,\1,g')" && \
    url="$(echo ${PLUGIN_INSTALL_PROXY/$proto/})" && \
    userpass="$(echo $url | grep @ | cut -d@ -f1)" && \
    pass="$(echo $userpass | grep : | cut -d: -f2)" && \
    if [ -n "$pass" ]; then  \
    user="$(echo $userpass | grep : | cut -d: -f1)"; \
    else user=$userpass; fi && \
    host="$(echo ${url/$user:$pass@/} | cut -d/ -f1)" && \
    port="$(echo $host | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')" && \
    host=${host/:$port} && \
    ES_JAVA_OPTS="-Djdk.http.auth.tunneling.disabledSchemes='' -Dhttp.proxyHost=$host -Dhttp.proxyPort=$port -Dhttp.proxyUser=$user -Dhttp.proxyPassword=$pass -Dhttps.proxyHost=$host -Dhttps.proxyPort=$port -Dhttps.proxyUser=$user -Dhttps.proxyPassword=$pass" \
    /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3 && \
     /usr/share/elasticsearch/bin/elasticsearch-keystore create && \
	echo "$ACCESS_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key  && \
	echo "$SECRET_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key && \
	echo "$ENDPOINT"    | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.endpoint

