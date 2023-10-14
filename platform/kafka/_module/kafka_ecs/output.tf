output "KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS" {
  value = join(",", [for idx in range(3) : format("%s:29092", element(local.kafka_hosts, idx))])
}

