resource "aws_s3_bucket" "bucket" {
  bucket = "mwk0408-cloud-resume"

}

resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}