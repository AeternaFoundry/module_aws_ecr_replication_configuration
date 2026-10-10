variable "ecr_replication_configurations" {
  description = <<EOT
Map of ecr_replication_configurations, attributes below
Optional:
    - region
    - replication_configuration (block):
        - rule (required, block):
            - destination (required, block):
                - region (required)
                - registry_id (required)
            - repository_filter (optional, block):
                - filter (required)
                - filter_type (required)
EOT

  type = map(object({
    region = optional(string)
    replication_configuration = optional(object({
      rule = list(object({
        destination = list(object({
          region      = string
          registry_id = string
        }))
        repository_filter = optional(list(object({
          filter      = string
          filter_type = string
        })))
      }))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.ecr_replication_configurations : (
        v.replication_configuration == null || (length(v.replication_configuration.rule) >= 1 && length(v.replication_configuration.rule) <= 10)
      )
    ])
    error_message = "Each rule list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecr_replication_configurations : (
        v.replication_configuration == null || (alltrue([for item in v.replication_configuration.rule : (length(item.destination) >= 1 && length(item.destination) <= 25)]))
      )
    ])
    error_message = "Each destination list must contain between 1 and 25 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecr_replication_configurations : (
        v.replication_configuration == null || (alltrue([for item in v.replication_configuration.rule : (item.repository_filter == null || (length(item.repository_filter) <= 100))]))
      )
    ])
    error_message = "Each repository_filter list must contain at most 100 items"
  }
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

