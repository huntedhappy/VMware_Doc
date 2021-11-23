kubectl get package -A

## To see more information about the values in the external-dns-data-values.yaml file, run the below command against your target cluster:
tanzu package available get external-dns.tanzu.vmware.com/0.8.0+vmware.1-tkg.1 --values-schema

image_url=$(kubectl -n tanzu-package-repo-global get packages external-dns.tanzu.vmware.com.0.8.0+vmware.1-tkg.1 -o jsonpath='{.spec.template.spec.fetch[0].imgpkgBundle.image}')
imgpkg pull -b $image_url -o /var/tmp/extension/external-dns
cp /var/tmp/extension/external-dns/config/values.yaml /var/tmp/extension/external-dns/external-dns-data-values.yaml
vi /var/tmp/extension/external-dns/external-dns-data-values.yaml

yq  eval '... comments=""' /var/tmp/extension/external-dns/external-dns-data-values.yaml > /var/tmp/extension/external-dns/external-dns-data-values.nocomments.yaml

kubectl apply -f external-dns-krb5-cm.yaml

tanzu package install external-dns \
-p external-dns.tanzu.vmware.com \
-v 0.8.0+vmware.1-tkg.1 \
-f /var/tmp/extension/external-dns/external-dns-data-values.nocomments.yaml \
-n tanzu-system-service-discovery \
--create-namespace