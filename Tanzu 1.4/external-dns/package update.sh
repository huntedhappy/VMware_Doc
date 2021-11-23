tanzu package installed update external-dns \
-p external-dns.tanzu.vmware.com \
-v 0.8.0+vmware.1-tkg.1 \
-f /var/tmp/extension/external-dns/external-dns-data-values.nocomments.yaml \
-n tanzu-system-service-discovery