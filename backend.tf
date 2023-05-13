resource "aws_s3_bucket" "jenkins" {
  bucket = "my-unique-jenkins-bucket"

  tags = {
    Name        = "jenkinsbucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.jenkins.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.jenkins.id
  acl    = "private"
}
