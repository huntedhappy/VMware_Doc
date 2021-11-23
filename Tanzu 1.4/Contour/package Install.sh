kubectl get package -A

## To see more information about the values in the contour-data-values.yaml file, run the below command against your target cluster:
tanzu package available get contour.tanzu.vmware.com/1.17.1+vmware.1-tkg.1 --values-schema

image_url=$(kubectl -n tanzu-package-repo-global get packages contour.tanzu.vmware.com.1.17.1+vmware.1-tkg.1 -o jsonpath='{.spec.template.spec.fetch[0].imgpkgBundle.image}')
imgpkg pull -b $image_url -o /var/tmp/extension/contour
cp /var/tmp/extension/contour/config/values.yaml /var/tmp/extension/contour/contour-data-values.yaml
vi /var/tmp/extension/contour/contour-data-values.yaml

yq  eval '... comments=""' /var/tmp/extension/contour/contour-data-values.yaml > /var/tmp/extension/contour/contour-data-values.nocomments.yaml

tanzu package install contour \
-p contour.tanzu.vmware.com \
-v 1.17.1+vmware.1-tkg.1 \
-n tanzu-system-ingress \
-f /var/tmp/extension/contour/contour-data-values.nocomments.yaml \
--create-namespace