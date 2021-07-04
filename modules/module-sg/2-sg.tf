provider "aws" {
  region = "ap-southeast-1"
  default_tags {
    tags = var.default_tags
  }
}

resource "aws_security_group" "webserver-sg-group" {
  name = "${var.project_name}-${var.resource_type}-SG"
  # name_prefix = var.project_name
  description = var.project_name
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.security_group_map
    # normally would be "ingress" here, but we're overriding the name
    iterator = each
    content {
      # now we use each. instead of ingress.
      description     = each.key # IE: "description 0"
      from_port       = each.value.port
      to_port         = each.value.port
      protocol        = each.value.protocol
      cidr_blocks     = each.value.cidr_blocks
      security_groups = each.value.security_groups
    }
  }
  #    ingress {
  #     from_port   = 8081
  #     to_port     = 8081
  #     protocol    = "tcp"
  #     cidr_blocks = ["116.86.133.133/32"]
  #     # cidr_blocks = var.client_laptops_ip
  #   }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    tags = merge(
    var.default_tags,
    {
      Name = "${var.project_name}-${var.resource_type}"
    }
  )
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

