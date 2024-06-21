##GLOBAL VARIABLE#

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "region to deploy the subnetes"
}

variable "subnet_ids" {
  type        = list(string)
  description = "asg subnet ids"
}

variable "vpc_id" {
  type        = string
  description = "the vpc id"
}

variable "internal" {
  type        = bool
  description = "True mean internal-facing lb , False means Internet-facing lb"
}


variable "target_groups" {
    type = map(object({
        name = optional(string,"nlb-tg")
        port = optional(number,80)
        target_type = optional(string,"instance")
        protocol = optional(string,"TCP")
        health_protocol = optional(string,"TCP")
    }))
}

variable "cidrs" {
  type = object({
    primary   = string
    secondary = optional(list(string))
  })
  description = "CIDRs of the VPC"
}