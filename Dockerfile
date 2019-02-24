FROM docker.elastic.co/elasticsearch/elasticsearch:6.6.0

ARG ACCESS_KEY
ARG SECRET_KEY
ARG ENDPOINT
ARG ES_VERSION=6.6.0

ARG PACKAGES="net-tools lsof"

RUN  if [ -n "${PACKAGES}" ]; then  yum install -y $PACKAGES && yum clean all && rm -rf /var/cache/yum; fi
RUN \
     curl https://artifacts.elastic.co/downloads/elasticsearch-plugins/repository-s3/repository-s3-$ES_VERSION.zip -o /tmp/repository-s3.zip && \
    /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch file:///tmp/repository-s3.zip && \
    /usr/share/elasticsearch/bin/elasticsearch-keystore create && \
	echo "$ACCESS_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key  && \
	echo "$SECRET_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key && \
	echo "$ENDPOINT"    | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.endpoint

