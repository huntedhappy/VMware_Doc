tanzu package installed update grafana \
-p grafana.tanzu.vmware.com \
-v 7.5.7+vmware.1-tkg.1 \
-f /var/tmp/extension/grafana/grafana-data-values.nocomments.yaml \
-n tanzu-system-dashboards