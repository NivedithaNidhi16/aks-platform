locals {
  name_prefix = "${var.env}-${var.proj}-niv"

  tags = {
    env  = var.env
    proj = var.proj
  }
}