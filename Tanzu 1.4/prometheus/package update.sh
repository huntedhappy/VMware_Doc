tanzu package installed update prometheus \
-p prometheus.tanzu.vmware.com \
-v 2.27.0+vmware.1-tkg.1 \
-f /var/tmp/extension/prometheus/prometheus-data-values.nocomments.yaml \
-n tanzu-system-monitoring
