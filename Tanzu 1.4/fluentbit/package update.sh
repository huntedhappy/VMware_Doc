tanzu package installed update fluent-bit \
-p fluent-bit.tanzu.vmware.com \
-v 1.7.5+vmware.1-tkg.1 \
-f /var/tmp/extension/fluentbit/fluent-bit-data-values.nocomments.yaml \
-n tanzu-system-logging \
