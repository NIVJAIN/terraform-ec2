# ------------------------------------------------------------------------------
# PROVIDER
# ------------------------------------------------------------------------------
provider "aws" {
  region  = local.region
  profile = "default"
  ignore_tags {
    keys = ["LastScanned"]
  }
}

# ------------------------------------------------------------------------------
# TERRAFORM VERSION
# ------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12.0"
}

terraform {
  backend "s3" {}
}


locals {
  project_name       = "RRE-PROD-EC2"
  region             = "ap-southeast-1"
  init_tpl_file_name = "init.tpl"
  #   ami_id           = "ami-0d058fe428540cd89" #ububtu
  ami_id                   = "ami-0fab0953c3bb514a9" #amazon linux2
  public_subnet_id         = "subnet-08b1ad0d7506dca3f"
  private_subnet_id        = "subnet-08b1ad0d7506dca3f"
  instance_type            = "t2.small"
  root_volume_size         = "80"
  pem_file_name_wo_dot_pem = "RecommedationEngineeKP"
  vpc_id                   = "vpc-028b7724ac0331752"
  jump_host_security_group = ["sg-021bf7f871be99f3e", "sg-05057e074f565c0fa", "sg-0cc362e87c48e58ce"]
  lambda_rre_sg_id         = ["sg-061b81a6a74a4c682"]
  client_laptops_ip        = ["116.86.133.133/32"]
  jump_hosts_ip            = ["10.196.250.8/32", "116.86.133.133/32"]
  availability_zones       = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  security_group_map = {
    "description 0" = {
      port            = 80,
      cidr_blocks     = null,
      security_groups = local.jump_host_security_group,
      protocol        = "tcp"
    }
    "description 1" = {
      port            = 8080,
      cidr_blocks     = local.jump_hosts_ip,
      security_groups = local.jump_host_security_group,
      protocol        = "tcp"
    }
    "description 2" = {
      port            = 22,
      cidr_blocks     = local.jump_hosts_ip,
      security_groups = local.jump_host_security_group,
      protocol        = "tcp"
    }
    "description 3" = {
      port            = 5004,
      cidr_blocks     = null,
      security_groups = local.lambda_rre_sg_id,
      protocol        = "tcp"
    }
  }
  default_tags = {
    Environment = "Dev"
    Owner       = "Siyang"
    Project     = "RRE-STAGING"
    Requestor   = "Siyang"
    Creator     = "CloudTFEngineer"
    Terraform   = "True"
    Scheduled   = "True"
    Schedule   = "True"
    TerraformState = "s3://terraform-jain-gcc/RRE/SIYANG-RRE-1.tfstate"
  }
}


module "security_groups" {
  source                   = "../modules/module-sg"
  project_name             = local.project_name
  region                   = local.region
  vpc_id                   = local.vpc_id
  default_tags             = local.default_tags
  jump_host_security_group = local.jump_host_security_group
  client_laptops_ip        = local.client_laptops_ip
  jump_hosts_ip            = local.jump_hosts_ip
  security_group_map       = local.security_group_map
}

module "ec2_webserver" {
  depends_on = [module.security_groups]
  source                   = "../modules/module-ec2"
  project_name             = local.project_name
  init_tpl_file_name       = local.init_tpl_file_name
  sec_grp_id  = module.security_groups.sg_id
  region                   = local.region
  vpc_id                   = local.vpc_id
  ami_id                   = local.ami_id
  subnet_id                = local.public_subnet_id
  instance_type            = local.instance_type
  pem_file_name_wo_dot_pem = local.pem_file_name_wo_dot_pem
  # ssh_username             = local.ssh_username
  # key_name                 = local.key_name
  # private_key_path         = local.private_key_path
  root_volume_size         = local.root_volume_size
  # instance_name            = local.instance_name
  default_tags             = local.default_tags
  # public_subnets           = local.public_subnets
  jump_host_security_group = local.jump_host_security_group
  client_laptops_ip        = local.client_laptops_ip
  jump_hosts_ip            = local.jump_hosts_ip
  # domain_name              = local.domain_name
  # domain_host_name         = local.domain_host_name
  availability_zones       = local.availability_zones

}

output "ec2_public_ip" {
  value = module.ec2_webserver.ec2_public_ip
}