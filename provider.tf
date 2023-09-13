terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}


provider "aws" {
  alias  = "euwest1"
  region = "eu-west-1"
  default_tags {
   tags = {
   Managed      = "terraform"
   Config       = "alaraby"
   Environment  = "development"
  }
 }
}
provider "null" {}
provider "random" {}
provider "external" {}

