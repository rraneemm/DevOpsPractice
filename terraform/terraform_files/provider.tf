provider aws {
    region = "eu-central-1"
}

terraform {
    backend "s3" {
        bucket = "raneem-state-bucket"
        key = "terraform/raneem-infra.tfstate"
        region = "eu-central-1"
        encrypt = true
        dynamodb_table = "raneem-table-lock"
    }
}
