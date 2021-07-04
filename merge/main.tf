locals {
  hosts2 = {
    "nginx" = { 
      "tgport"  = "8080"
      "tgproto" = "HTTP"
    },
    "rabbit" = {
      "tgport"  = "15672"
      "tgproto" = "HTTP"
    },
    "nodeapp" = {
      "tgport"  = "3000"
      "tgproto" = "HTTP"
    }
  }
  hosts3 = {
    "service" = {
      "tgport"  = "5000"
      "tgproto" = "HTTP"
    }
  }
  hosts4 = {
    "service" = {
      "tgport"  = "8888"
      "tgproto" = "HTTP"
    }
  }
}



output "merged2" {
  value = merge(local.hosts2,local.hosts3)
}

#  security_group_map = {
#     "description 0" = {
#       port            = 80,
#       cidr_blocks     = null,
#       security_groups = local.jump_host_security_group,
#       protocol        = "tcp"
#     }
#     "description 1" = {
#       port            = 8080,
#       cidr_blocks     = local.jump_hosts_ip,
#       security_groups = local.jump_host_security_group,
#       protocol        = "tcp"
#     }
#     "description 2" = {
#       port            = 22,
#       cidr_blocks     = local.jump_hosts_ip,
#       security_groups = local.jump_host_security_group,
#       protocol        = "tcp"
#     }
#     "description 3" = {
#       port            = 5004,
#       cidr_blocks     = null,
#       security_groups = local.lambda_rre_sg_id,
#       protocol        = "tcp"
#     }
#   }






# variable "ebs_block_device" {
#   description = "Additional EBS block devices to attach to the instance"
#   type        = list(map(string))
#   default     = [
#     {
#       device_name = "/dev/sdg"
#       volume_size = 5
#       volume_type = "gp2"
#       delete_on_termination = false
#     },
#     {
#       device_name = "/dev/sdh"
#       volume_size = 5
#       volume_type = "gp2"
#       delete_on_termination = false
#     }
#   ]
# }

# variable "mount_point" {
#   description = "Mount point to use"
#   type = list(string)
#   default = ["/data", "/home"]
# }

# output "merged" {
#   value = [
#     for index, x in var.ebs_block_device:
#     merge(x, {"mount_point" = var.mount_point[index]})
#   ]
# }


