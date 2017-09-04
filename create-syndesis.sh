#!/bin/bash

#minishift start --memory 4192 --cpus 2

template=${template:-syndesis-restricted}
ROUTE_HOSTNAME=${hostname:-syndesis.$(minishift ip).xip.io}
KEYCLOAK_ROUTE_HOSTNAME=${keycloak_hostname:-syndesis-keycloak.$(minishift ip).xip.io}

echo "Openshift started."
echo "Please configure your GitHub registered application with following URL: https://syndesis.$(minishift ip).xip.io"

if [ -z $GITHUB_CLIENT_ID ]; then
    printf "Enter GITHUB_CLIENT_ID:"
    read -s GITHUB_CLIENT_ID
    printf "\n"
    export GITHUB_CLIENT_ID
fi

if [ -z $GITHUB_CLIENT_SECRET ]; then
    printf "Enter GITHUB_CLIENT_SECRET:"
    read -s GITHUB_CLIENT_SECRET
    printf "\n"
    export GITHUB_CLIENT_SECRET
fi

echo "Using template: $template"

# create syndesis template
oc create -f https://raw.githubusercontent.com/syndesisio/syndesis-openshift-templates/master/${template}.yml

oc create -f https://raw.githubusercontent.com/syndesisio/syndesis-openshift-templates/master/support/serviceaccount-as-oauthclient-restricted.yml

# create syndesis application
oc new-app ${template} \
    -p KEYCLOAK_ROUTE_HOSTNAME=$KEYCLOAK_ROUTE_HOSTNAME \
    -p ROUTE_HOSTNAME=$ROUTE_HOSTNAME \
    -p ACCESS_TOKEN_LIFESPAN=60000 \
    -p SESSION_LIFESPAN=60000 \
    -p OPENSHIFT_MASTER=$(oc whoami --show-server) \
    -p OPENSHIFT_PROJECT=$(oc project -q) \
    -p OPENSHIFT_OAUTH_CLIENT_SECRET=$(oc sa get-token syndesis-oauth-client) \
    -p GITHUB_OAUTH_CLIENT_ID=${GITHUB_CLIENT_ID} \
    -p GITHUB_OAUTH_CLIENT_SECRET=${GITHUB_CLIENT_SECRET}


echo "Syndesis application has been created."


