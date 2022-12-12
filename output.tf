output "s3_bucket_arn" {
    value = aws_s3_bucket.terraform_state.arn
    description = "The arn of s3 bucket"
}

output "aws_dynamodb_table" {
    value = aws_dynamodb_table.terraform_locks.name
    description = "The name of DynamoDB Table"
}