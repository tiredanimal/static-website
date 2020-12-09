module "azure" {
  source = "./modules/azure"

  env = var.env
}

module "aws" {
  source = "./modules/aws"

  env = var.env
}
