resource "aws_dynamodb_table" "visit_count" {
    name = "visit_count"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "id"
    attribute {
        name = "id"
        type = "N"
    }
}
