variable "tags" {
  type        = map(string)
  description = "Default tags"
  default = {
    "Service"     = "EKS"
    "Environment" = "WORKER-NODE"
    "RegionAlias" = "an2"
  }
}