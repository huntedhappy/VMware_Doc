tanzu package installed update harbor \
-p harbor.tanzu.vmware.com \
-v 2.2.3+vmware.1-tkg.1 \
-f /var/tmp/extension/harbor/harbor-data-values.nocomments.yaml \
-n tanzu-system-registry 
