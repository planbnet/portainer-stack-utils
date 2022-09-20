FROM alpine:3.10

ENV PSU_AUTH_TOKEN=""
ENV PSU_CONFIG_ACCESS_ADMINS=""
ENV PSU_CONFIG_ACCESS_ENDPOINT=""
ENV PSU_CONFIG_ACCESS_PRIVATE=""
ENV PSU_CONFIG_ACCESS_PUBLIC=""
ENV PSU_CONTAINER_ACCESS_ADMINS=""
ENV PSU_CONTAINER_ACCESS_ENDPOINT=""
ENV PSU_CONTAINER_ACCESS_PRIVATE=""
ENV PSU_CONTAINER_ACCESS_PUBLIC=""
ENV PSU_ENDPOINT_GROUP_INSPECT_FORMAT=""
ENV PSU_ENDPOINT_GROUP_LIST_FORMAT=""
ENV PSU_ENDPOINT_INSPECT_FORMAT=""
ENV PSU_ENDPOINT_LIST_FORMAT=""
ENV PSU_INSECURE=""
ENV PSU_LOG_FORMAT=""
ENV PSU_LOG_LEVEL=""
ENV PSU_LOGIN_PRINT=""
ENV PSU_NETWORK_ACCESS_ADMINS=""
ENV PSU_NETWORK_ACCESS_ENDPOINT=""
ENV PSU_NETWORK_ACCESS_PRIVATE=""
ENV PSU_NETWORK_ACCESS_PUBLIC=""
ENV PSU_PASSWORD=""
ENV PSU_PROXY_ADDRESS=""
ENV PSU_PROXY_ENDPOINT=""
ENV PSU_SECRET_ACCESS_ADMINS=""
ENV PSU_SECRET_ACCESS_ENDPOINT=""
ENV PSU_SECRET_ACCESS_PRIVATE=""
ENV PSU_SECRET_ACCESS_PUBLIC=""
ENV PSU_SERVICE_ACCESS_ADMINS=""
ENV PSU_SERVICE_ACCESS_ENDPOINT=""
ENV PSU_SERVICE_ACCESS_PRIVATE=""
ENV PSU_SERVICE_ACCESS_PUBLIC=""
ENV PSU_SETTING_LIST_FORMAT=""
ENV PSU_SETTINGS_FILE=""
ENV PSU_STACK_ACCESS_ADMINS=""
ENV PSU_STACK_ACCESS_ENDPOINT=""
ENV PSU_STACK_ACCESS_PRIVATE=""
ENV PSU_STACK_ACCESS_PUBLIC=""
ENV PSU_STACK_DEPLOY_ENDPOINT=""
ENV PSU_STACK_DEPLOY_ENV_FILE=""
ENV PSU_STACK_DEPLOY_PRUNE=""
ENV PSU_STACK_DEPLOY_PULL_IMAGE=""
ENV PSU_STACK_DEPLOY_REPLACE_ENV=""
ENV PSU_STACK_DEPLOY_STACK_FILE=""
ENV PSU_STACK_INSPECT_ENDPOINT=""
ENV PSU_STACK_INSPECT_FORMAT=""
ENV PSU_STACK_LIST_ENDPOINT=""
ENV PSU_STACK_LIST_FORMAT=""
ENV PSU_STACK_REMOVE_ENDPOINT=""
ENV PSU_STACK_REMOVE_STRICT=""
ENV PSU_STATUS_FORMAT=""
ENV PSU_TIMEOUT=""
ENV PSU_URL=""
ENV PSU_USER=""
ENV PSU_VOLUME_ACCESS_ADMINS=""
ENV PSU_VOLUME_ACCESS_ENDPOINT=""
ENV PSU_VOLUME_ACCESS_PRIVATE=""
ENV PSU_VOLUME_ACCESS_PUBLIC=""

COPY psu /usr/local/bin/psu

ENTRYPOINT ["/usr/local/bin/psu"]
