provider aws {
    region = "eu-central-1"
    access_key = "AKIAQH34HTLMTD54BMIP"
    secret_key = "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"
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