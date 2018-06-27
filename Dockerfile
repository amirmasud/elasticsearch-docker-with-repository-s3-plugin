FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.3.0

ARG ACCESS_KEY
ARG SECRET_KEY
ARG ENDPOINT

RUN  /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch repository-s3 && \
     /usr/share/elasticsearch/bin/elasticsearch-keystore create && \
	echo "$ACCESS_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.access_key  && \
	echo "$SECRET_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.secret_key && \
	echo "$ENDPOINT"    | /usr/share/elasticsearch/bin/elasticsearch-keystore add --stdin s3.client.default.endpoint

