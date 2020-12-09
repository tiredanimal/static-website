locals {
  org_name      = "tiredanimal"
  custom_domain = "${local.org_name}.com"
}

module "azure" {
  source = "./modules/azure"

  env           = var.env
  org_name      = local.org_name
  custom_domain = local.custom_domain

}

module "aws" {
  source = "./modules/aws"

  env           = var.env
  custom_domain = local.custom_domain
}
