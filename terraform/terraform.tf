terraform {
  backend "remote" {
    organization = "tiredanimal"

    workspaces {
      name = "static-website"
    }
  }
}
