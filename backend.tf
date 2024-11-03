terraform {
  backend "s3" {
    bucket = "github-actions-mithun8064"
    key    = "github-action-demo-tfstate"
    region = "us-east-1"
  }
}
