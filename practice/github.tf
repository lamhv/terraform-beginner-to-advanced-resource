terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "4.26.1"
    }
  }
}

provider "github" {
  # Configuration options
  token = "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"
}

resource "github_repository" "example" {
  name        = "terraform-repo"
  description = "My awesome codebase"

  visibility = "private"

}