# ecr.tf
provider "aws" {
  region = "us-west-2"
}

resource "aws_ecr_repository" "my_java_app" {
  name = "my-java-app"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}

