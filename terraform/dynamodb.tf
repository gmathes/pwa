resource "aws_dynamodb_table" "pwa-dynamodb-table" {
  name         = "Rides"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "RideId"

  attribute {
    name = "RideId"
    type = "S"
  }

  tags = {
    Name        = "Rides"
    Environment = "dev"
  }
}
