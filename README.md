# Demo guidelines

## Installation

###  OpenShift Pipeline 

Installing the operator
```
oc apply -f infra/tekton/00-pipelines-subscription.yaml 
```
### Openshift Gitops

   
    oc apply -f infra/gitops/00-namespace.yaml
    oc apply -f infra/gitops/01-gitops-operatorgroup.yaml
    oc apply -f infra/gitops/02-gitops-operator.yaml
    ## Wait until openshift-gitops namespace has created
    oc apply -f infra/gitops/03-janus-project

To retrieve the ArgoCD URL in an OpenShift installation, you can use the oc command to list the route created for the ArgoCD server. The route is typically created in the openshift-gitops namespace. Here's the command:

     oc get route openshift-gitops-server -n openshift-gitops -o jsonpath='{.spec.host}'
    
To retrieve the ArgoCD admin password in an OpenShift installation using the openshift-gitops namespace, follow these steps:
1. Access the openshift-gitops Namespace

Ensure you have access to the openshift-gitops namespace where ArgoCD is installed.

    oc project openshift-gitops

2. Locate the Secret

The admin password is stored in a Kubernetes secret named openshift-gitops-cluster. You can list the secrets in the namespace to confirm its presence:

    oc get secrets -n openshift-gitops

You should see a secret named openshift-gitops-cluster.

3. Retrieve and Decode the Password

Use the following command to extract the admin password from the secret and decode it:

    oc get secret openshift-gitops-cluster -n openshift-gitops -o jsonpath='{.data.admin\.password}' | base64 -d

This will output the ArgoCD admin password in plain text.

### Keycloak

#### Pre task

Configuration to perform before running the scripts:

- **05-keycloak-cr.yaml**: &nbsp;set hostname with the correct URL:  
   &nbsp;hostname: keycloak.apps.cluster-wdw6r.wdw6r.gcp.redhatworkshops.io

- **07-keycloak-realm-import**: &nbsp; Set the backstage URL in redirectUris and webOrigins fields

**Run script**

    oc apply -f infra/keycloak

To retrieve the Keycloak temp-admin password:

    oc get secret example-keycloak-initial-admin -n keycloak -o jsonpath='{.data.password}' | base64 -d



### Developer hub

Operator installation and service account token creation:  


Get the service account token needed for kubernetes plugin and set it in secrets-rhdh:   

    oc apply -f infra/developerhub/service-account-token-secret.yaml
    oc -n rhdh-operator get secret rhdh-sa-token -o go-template='{{.data.token | base64decode}}'

**TODO** edit 05-secrets-rhdh.yaml and set values on the required parameters

    oc apply -f infra/developerhub/05-secrets-rhdh.yaml 

Appconfig and dynamic-plugin cm

    oc apply -f infra/developerhub/03-my-backstage-dynamic-plugins-developer-hub.yaml 
    oc apply -f infra/developerhub/04-my-backstage-appconfig-developer-hub.yaml 

Developer Hub custom resource 

    oc apply -f infra/developerhub/06-developerhub-cr.yaml 





