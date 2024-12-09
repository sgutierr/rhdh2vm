oc apply -f ansibleautomationplatform.yaml
oc get route my-aap-instance -n my-aap
oc get secret my-aap-instance-admin-password -n my-aap -o go-template --template="{{.data.password|base64decode}}"