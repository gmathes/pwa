resource "aws_s3_bucket" "pwa" {
  bucket = "greminders-pwa"
  acl    = "public-read"

  tags = {
    Name = "Hosting static files"
  }

  website {
    index_document = "index.html"
  }

}

resource "aws_s3_bucket_policy" "pwa" {
  bucket = aws_s3_bucket.pwa.id
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.pwa.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "pwa" {
  bucket = aws_s3_bucket.pwa.id

  block_public_acls   = false 
  block_public_policy = false
}
