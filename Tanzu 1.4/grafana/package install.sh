kubectl get package -A

## To see more information about the values in the grafana-data-values.yaml file, run the below command against your target cluster:
tanzu package available get grafana.tanzu.vmware.com/7.5.7+vmware.1-tkg.1 --values-schema

image_url=$(kubectl -n tanzu-package-repo-global get packages grafana.tanzu.vmware.com.7.5.7+vmware.1-tkg.1 -o jsonpath='{.spec.template.spec.fetch[0].imgpkgBundle.image}')
imgpkg pull -b $image_url -o /var/tmp/extension/grafana
cp /var/tmp/extension/grafana/config/values.yaml /var/tmp/extension/grafana/grafana-data-values.yaml
vi /var/tmp/extension/grafana/grafana-data-values.yaml

yq  eval '... comments=""'  /var/tmp/extension/grafana/grafana-data-values.yaml >  /var/tmp/extension/grafana/grafana-data-values.nocomments.yaml

sed -i 's/namespace: tanzu-system-monitoring/namespace: tanzu-system-dashboards/g' /var/tmp/extension/grafana/grafana-data-values.nocomments.yaml

tanzu package install grafana \
-p grafana.tanzu.vmware.com \
-v 7.5.7+vmware.1-tkg.1 \
-f /var/tmp/extension/grafana/grafana-data-values.nocomments.yaml \
-n tanzu-system-dashboards \
--create-namespace