kubectl get package -A

## To see more information about the values in the harbor-data-values.yaml file, run the below command against your target cluster:
tanzu package available get prometheus.tanzu.vmware.com/2.27.0+vmware.1-tkg.1 --values-schema

image_url=$(kubectl -n tanzu-package-repo-global get packages prometheus.tanzu.vmware.com.2.27.0+vmware.1-tkg.1 -o jsonpath='{.spec.template.spec.fetch[0].imgpkgBundle.image}')
imgpkg pull -b $image_url -o /var/tmp/extension/prometheus
cp /var/tmp/extension/prometheus/config/values.yaml /var/tmp/extension/prometheus/prometheus-data-values.yaml
vi /var/tmp/extension/prometheus/prometheus-data-values.yaml

yq  eval '... comments=""' /var/tmp/extension/prometheus/prometheus-data-values.yaml > /var/tmp/extension/prometheus/prometheus-data-values.nocomments.yaml

tanzu package install prometheus \
-p prometheus.tanzu.vmware.com \
-v 2.27.0+vmware.1-tkg.1 \
-f /var/tmp/extension/prometheus/prometheus-data-values.nocomments.yaml \
-n tanzu-system-monitoring \
--create-namespace