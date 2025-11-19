variable "namespace" {
  type        = string
  description = "The namespace to create the service account in."
}

variable "name_prefix" {
  type        = string
  description = "The name prefix to use for generate_name."
  default     = "sa-"
}

variable "name" {
  type        = string
  description = "The explicit name of the service account to create."
  default     = null
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
