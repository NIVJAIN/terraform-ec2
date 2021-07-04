variable "region" {
  default     = "ap-southeast-1"
  description = "AWS Region"
}

variable "project_name" {
  default     = "project_name"
  description = "Project name,this name will be used for naming resources"
}

variable "resource_type" {
}

variable "vpc_id" {
  default     = "vpc-028b7724ac0331752"
  description = "AWS Region"
}

variable "default_tags" {
  default = {
    Environment = "Dev"
    Owner       = "TFProviders"
    Project     = "Test"
    Requestor   = "User"
    Creator     = "CloudTFEngineer"
  }
}

variable "public_subnets" {
  type        = list(string)
  default     = ["subnet-08b1ad0d7506dca3f", "subnet-0e13dde65836782b9"]
  description = "List of availability zones for the selected region"
}

variable "jump_host_security_group" {
  type        = list(string)
  default     = ["sg-021bf7f871be99f3e", "sg-05057e074f565c0fa", "sg-0cc362e87c48e58ce"]
  description = "List of jumphost sg group"
}

variable "jump_hosts_ip" {
  type        = list(string)
  default     = ["116.86.133.133/32"]
  description = "Client laptops ip"
}

variable "client_laptops_ip" {
  type        = list(string)
  default     = ["116.86.133.133/32"]
  description = "Client laptops ip"
}

variable "security_group_map" {
    default = {
    "description 0" = {
      port            = 80,
      cidr_blocks     = null,
      security_groups = null,
      protocol        = "tcp"
    }
  }
}