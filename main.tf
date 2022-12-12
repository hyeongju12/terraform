provider "aws" {
    region = "ap-northeast-2"
    profile = "default"
}


# 1. 상태 파일을 저장하기 위한 버킷 생성
# s3 bucket에서 상태 파일을 관리하기위한 bucket 생성
resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-up-and-running-state-hjyoo"

    # 삭제 방지, terraform destroy 실행시 오류 발생
    lifecycle {
        prevent_destroy = false
    }
    # 상태 파일의 버전 관리
    versioning {
        enabled = false
    }
    # 서버 암호화
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name         = "terraform-up-and-running-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}



# 2. terraform이 s3 버킷에 상태 파일을 저장하도록 하려면
# backend bucket을 먼저 생성을 하고나서 아래 backend 코드를 포함하여 terraform init을 해야함.
# terraform {
#     backend "s3" {
#         bucket = "terraform-up-and-running-state-hjyoo"
#         key = "global/s3/terraform.tfstate"
#         region = "ap-northeast-2"

#         dynamodb_table = "terraform-up-and-running-locks"
#         encrypt = true
#     }
# }