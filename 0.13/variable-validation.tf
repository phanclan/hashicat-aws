variable "ami" {
  type = list(string)
  default = ["prod", "qa", "dev"]
  # validation {
  #   condition     = can(regex("^ami-", var.deploy_env))
  #   error_message = "The image_id value must be start with \"ami-\"."
  # }
}