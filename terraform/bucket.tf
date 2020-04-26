resource "aws_s3_bucket" "pwa" {
  bucket        = "greminders-pwa"
  acl           = "public-read"
  force_destroy = "true"

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

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = [
        "24.240.108.156"
      ]

    }
  }
}

resource "aws_s3_bucket_public_access_block" "pwa" {
  bucket = aws_s3_bucket.pwa.id

  block_public_acls   = false
  block_public_policy = false
}

resource "null_resource" "remove_and_upload_to_s3" {
  provisioner "local-exec" {
    command = "aws s3 sync ../static s3://${aws_s3_bucket.pwa.id}"
  }
}
