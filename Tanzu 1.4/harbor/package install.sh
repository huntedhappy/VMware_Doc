kubectl get package -A

## To see more information about the values in the harbor-data-values.yaml file, run the below command against your target cluster:
tanzu package available get harbor.tanzu.vmware.com/2.2.3+vmware.1-tkg.1 --values-schema

image_url=$(kubectl -n tanzu-package-repo-global get packages harbor.tanzu.vmware.com.2.2.3+vmware.1-tkg.1 -o jsonpath='{.spec.template.spec.fetch[0].imgpkgBundle.image}')
imgpkg pull -b $image_url -o /var/tmp/extension/harbor
cp /var/tmp/extension/harbor/config/values.yaml /var/tmp/extension/harbor/harbor-data-values.yaml
vi /var/tmp/extension/harbor/harbor-data-values.yaml

## 패스워드 자동 채움
bash /var/tmp/extension/harbor/config/scripts/generate-passwords.sh /var/tmp/extension/harbor/harbor-data-values.yaml

yq  eval '... comments=""' /var/tmp/extension/harbor/harbor-data-values.yaml > /var/tmp/extension/harbor/harbor-data-values.nocomments.yaml

tanzu package install harbor \
-p harbor.tanzu.vmware.com \
-v 2.2.3+vmware.1-tkg.1 \
-f /var/tmp/extension/harbor/harbor-data-values.nocomments.yaml \
-n tanzu-system-registry \
--create-namespace