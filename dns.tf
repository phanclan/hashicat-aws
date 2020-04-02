# resource "aws_route53_record" "hashicat" {
#   zone_id = var.zone_id
#   name    = "hashicat"
#   type    = "CNAME"
#   records = [aws_instance.hashicat.public_dns]
#   ttl     = "300"
# }

# variable "zone_id" {
#   default = "Z1SE34SEPQ6H86"
# }

# output "hashicat_dns" {
#   value = "http://${aws_route53_record.hashicat.fqdn}"
# }

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
