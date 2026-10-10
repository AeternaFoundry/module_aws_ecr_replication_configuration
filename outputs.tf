output "ecr_replication_configurations_id" {
  description = "Map of id values across all ecr_replication_configurations, keyed the same as var.ecr_replication_configurations"
  value       = { for k, v in aws_ecr_replication_configuration.ecr_replication_configurations : k => v.id if v.id != null && length(v.id) > 0 }
}
output "ecr_replication_configurations_region" {
  description = "Map of region values across all ecr_replication_configurations, keyed the same as var.ecr_replication_configurations"
  value       = { for k, v in aws_ecr_replication_configuration.ecr_replication_configurations : k => v.region if v.region != null && length(v.region) > 0 }
}
output "ecr_replication_configurations_registry_id" {
  description = "Map of registry_id values across all ecr_replication_configurations, keyed the same as var.ecr_replication_configurations"
  value       = { for k, v in aws_ecr_replication_configuration.ecr_replication_configurations : k => v.registry_id if v.registry_id != null && length(v.registry_id) > 0 }
}
output "ecr_replication_configurations_replication_configuration" {
  description = "Map of replication_configuration values across all ecr_replication_configurations, keyed the same as var.ecr_replication_configurations"
  value       = { for k, v in aws_ecr_replication_configuration.ecr_replication_configurations : k => one(v.replication_configuration) if v.replication_configuration != null && length(v.replication_configuration) > 0 }
}

