kubectl -n tanzu-system-registry create secret generic overlay-fix -o yaml --dry-run=client --from-file=overlay-fix.yaml | kubectl apply -f -

kubectl -n tanzu-system-registry annotate packageinstalls harbor ext.packaging.carvel.dev/ytt-paths-from-secret-name.0=overlay-fix

kubectl delete statefulset --all -n tanzu-system-registry

kubectl delete pod --all -n tanzu-system-registry
