resource "aws_route53_record" "hashicat" {
  zone_id = var.zone_id
  name    = "hashicat"
  type    = "CNAME"
  records = [aws_instance.hashicat.public_dns]
  ttl     = "300"
}

variable "zone_id" {
  default = "Z1SE34SEPQ6H86"
}

output "hashicat_dns" {
  value = aws_route53_record.hashicat.fqdn
}
