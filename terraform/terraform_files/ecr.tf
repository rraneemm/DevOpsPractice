resource "aws_ecr_repository" "raneem_ecr" {
    name = "raneem_ecr"

    image_tag_mutability = "MUTABLE"

    tags = {
        Name = "raneem-ecr"
    }
}