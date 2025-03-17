# resource "aws_iam_policy" "s3_bucket_policy" {
#   name        = "S3BucketPolicy"
#   description = "Policy for creating and managing the S3 bucket"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       # Allow bucket creation and listing
#       {
#         Effect = "Allow"
#         Action = [
#           "s3:CreateBucket",
#           "s3:ListAllMyBuckets"
#         ]
#         Resource = "*"  
#       },
#       {
#         Effect = "Allow"
#         Action = [
#           "s3:PutObject",
#           "s3:GetObject",
#           "s3:DeleteObject",
#           "s3:ListBucket",
#           "s3:PutBucketPolicy",
#           "s3:PutBucketEncryption",
#           "s3:PutLifecycleConfiguration"
#         ]
#         Resource = [
#           "${aws_s3_bucket.s3_bucket.arn}",
#           "${aws_s3_bucket.s3_bucket.arn}/*"
#         ]
#       }
#     ]
#   })
# }