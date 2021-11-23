ytt --ignore-unknown-comments \
-f /var/tmp/extension/fluent-bit/config/_ytt_lib/bundle/config \
-f /var/tmp/extension/fluent-bit/fluent-bit-data-values.yaml \
-f /var/tmp/extension/fluent-bit/overlay-fix.yaml