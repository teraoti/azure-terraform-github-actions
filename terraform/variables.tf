variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "UK South"
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
  default     = "rg-github-actions-demo"
}
variable "storage_account_name" {
  description = "Azure Storage Account Name"
  type        = string
  default     = "stiacdemo001"
}

variable "account_tier" {
  description = "Storage performance tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type"
  type        = string
  default     = "LRS"
}
