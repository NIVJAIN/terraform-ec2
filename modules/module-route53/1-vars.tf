variable "domain_name" {
  default     = "aipo-imda.net"
  description = "domain name for route53"
}

variable "zone_id" {

}

variable "aws_alb_dnsname" {

}

variable "aws_alb_zoneid" {
    
}

variable "hosts2" {
  # type = "map"
  default = {
    "nginx" = {
      "tgport"  = "8080"
      "tgproto" = "HTTP"
    }
    # ,
    # "rabbit" = {
    #   "tgport"  = "15672"
    #   "tgproto" = "HTTP"
    # }
  }
}