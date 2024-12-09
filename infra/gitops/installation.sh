oc apply -f 00-namespace.yaml
oc apply -f 01-gitops-operatorgroup.yaml
oc apply -f 02-gitops-operator.yaml
oc apply -f 03-janus-project

# el fichero 04-rolebinding será aplicado en el scaffolding ya que requier asignar permisos de admin al serviceaccount de argocd para que lea los manifiestos del namespace



# New argocd instance for demo
# oc apply -f 03-argocd.yaml

# Create service account token secret for K8s plugin
#oc apply -f service-account-token-secret.yaml


# Get admin password:
#oc get secret/openshift-gitops-cluster -n openshift-gitops -o jsonpath='{.data.admin\.password}' | base64 -d

# oc -n rhdh-operator get secret rhdh-sa-token -o go-template='{{.data.token | base64decode}}'
