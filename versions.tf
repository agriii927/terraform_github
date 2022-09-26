terraform {
  required_version = ">= 1.2.8"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}