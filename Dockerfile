FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.3.0

ARG ACCESS_KEY
ARG SECRET_KEY
ARG ENDPOINT

RUN /usr/share/elasticsearch/bin/plugin install repository-s3 && \
	echo "$ACCESS_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore --stdin s3.client.default.access_key && \
	echo "$SECRET_KEY"  | /usr/share/elasticsearch/bin/elasticsearch-keystore --stdin s3.client.default.secret_key && \
	echo "$ENDPOINT"    | /usr/share/elasticsearch/bin/elasticsearch-keystore --stdin s3.client.default.endpoint

