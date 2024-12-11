# Demo guidelines

## Installation

###  OpenShift Pipeline 


### Openshift Gitops
  


### Keycloak

Namepace: keycloak
Release: v26
Database: username and password can be clear, there is not external route
TLS certs: autosigned
This is the command if you need re-generate the autosigned certificates (no production)
        openssl req -subj '/CN=test.keycloak.org/O=Test Keycloak./C=US' -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
    
#### ToDO

Configuration to perform before to run the scripts:

- **05-keycloak-cr.yaml**: &nbsp;set hostname with the correct URL:  
   &nbsp;hostname: keycloak.apps.cluster-wdw6r.wdw6r.gcp.redhatworkshops.io

- **07-keycloak-realm-import**: &nbsp; Set the backstage URL in redirectUris and webOrigins fields



### Developer hub


Check if this secret with service account token has been created 

    oc apply -f infra/developerhub/service-account-token-secret.yaml

Get the service account token needed for kubernetes plugin and set it in secrets-rhdh:   

    oc -n rhdh-operator get secret rhdh-sa-token -o go-template='{{.data.token | base64decode}}'

**TODO** edit 05-secrets-rhdh.yaml and set values on the required parameters

    oc apply -f infra/developerhub/05-secrets-rhdh.yaml 