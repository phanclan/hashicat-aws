resource "aws_route53_record" "hashi-bastion" {
  zone_id = var.zone_id
  name    = "hashicat"
  type    = "CNAME"
  records = [aws_instance.hashicat.public_dns]
  ttl     = "300"
}

variable "zone_id" {
  default = "Z1SE34SEPQ6H86"
}

