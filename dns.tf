data "aws_route53_zone" "this" {
  name = var.hosted-zone
}

resource "aws_route53_record" "hashicat" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "hashicat"
  type    = "CNAME"
  records = [aws_eip.hashicat.public_dns]
  # records = [aws_instance.hashicat.public_dns]
  ttl     = "300"
}

output "hashicat_dns" {
  value = "http://${aws_route53_record.hashicat.fqdn}"
}

# #-------------------------------------------------------------------------------
# # DATA SOURCE FOR AMI - hashistack
# #-------------------------------------------------------------------------------

# data "aws_ami" "hashistack" {
#   most_recent = true
#   owners      = ["self"]
#   filter {
#     name   = "name"
#     values = [var.ami]
#   }
# }

# variable "ami" {
#   default     = "pphan*"
#   description = "AMI for hashistack instances"
# }
