resource "aws_cognito_user_pool" "pool" {
  name = "gmpool"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = aws_cognito_user_pool.pool.id
}
