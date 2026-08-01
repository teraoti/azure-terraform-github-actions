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
