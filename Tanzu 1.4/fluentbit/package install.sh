kubectl get package -A

## To see more information about the values in the fluent-bit-data-values.yaml file, run the below command against your target cluster:
tanzu package available get fluent-bit.tanzu.vmware.com/1.7.5+vmware.1-tkg.1 --values-schema

image_url=$(kubectl -n tanzu-package-repo-global get packages fluent-bit.tanzu.vmware.com.1.7.5+vmware.1-tkg.1 -o jsonpath='{.spec.template.spec.fetch[0].imgpkgBundle.image}')
imgpkg pull -b $image_url -o /var/tmp/extension/fluent-bit
cp /var/tmp/extension/fluent-bit/config/values.yaml /var/tmp/extension/fluent-bit/fluent-bit-data-values.yaml
vi /var/tmp/extension/fluent-bit/fluent-bit-data-values.yaml

yq  eval '... comments=""' /var/tmp/extension/fluent-bit/fluent-bit-data-values.yaml > /var/tmp/extension/fluent-bit/fluent-bit-data-values.nocomments.yaml

tanzu package install fluent-bit \
-p fluent-bit.tanzu.vmware.com \
-v 1.7.5+vmware.1-tkg.1 \
-f /var/tmp/extension/fluent-bit/fluent-bit-data-values.nocomments.yaml \
-n tanzu-system-logging \
--create-namespace