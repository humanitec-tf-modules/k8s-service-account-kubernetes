variable "namespace" {
  type        = string
  description = "The namespace to create the service account in."
}

variable "name" {
  type        = string
  description = "The name of the service account to create. Should not be set if name_prefix is set."
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "The name prefix to use for generate_name. Cannot be set if name is set."
  default     = null

  validation {
    condition     = (var.name != null && var.name_prefix == null) || (var.name == null && var.name_prefix != null)
    error_message = "Exactly one of 'name' or 'name_prefix' must be set, not both."
  }
}

variable "additional_annotations" {
  type        = map(string)
  description = "Additional annotations to add to the service account."
  default     = {}
}

variable "additional_labels" {
  type        = map(string)
  description = "Additional labels to add to the service account."
  default     = {}
}

variable "automount_service_account_token" {
  type        = bool
  description = "Enable automatic mounting of the service account token"
  default     = true
}

variable "roles" {
  type        = list(string)
  description = "Roles to bind to the service account"
  default     = []
}

variable "cluster_roles" {
  type        = list(string)
  description = "Cluster roles to bind to the service account"
  default     = []
}
