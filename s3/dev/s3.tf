resource "aws_s3_bucket" "medicine" {
  bucket = "hoit-medicines"

  tags = {
    Name        = "hoit-medicines"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_acl" "medicine" {
  bucket = aws_s3_bucket.medicine.id
  // 이미지를 업로드 하기 위해서는 public-read-write가 필요하다.
  acl = "public-read-write"
}


// AWS 정책 변경으로 AWS 콘솔에서 직접 변경해야함.
// 아래 코드는 버킷 정책 참고용으로 사용

# resource "aws_s3_bucket_cors_configuration" "medicine" {
#   bucket = aws_s3_bucket.medicine.id

#   cors_rule {
#     allowed_headers = ["*"]
#     allowed_methods = ["PUT", "POST"]
#     allowed_origins = ["*"] 
#     expose_headers  = ["ETag"]
#     max_age_seconds = 3000
#   }

#   cors_rule {
#     allowed_methods = ["GET"]
#     allowed_origins = ["*"] // 이미지를 저장할버킷이기에 모든 곳에서 접근 가능하도록 설정 
#   }

# }

# resource "aws_s3_bucket_policy" "medicine" {
#   bucket = aws_s3_bucket.medicine.id
#   policy = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Id": "Policy1618510000000",
#     "Statement": [
#       {
#         "Sid": "Stmt1618510000000",
#         "Effect": "Allow",
#         "Principal": "*",
#         "Action": "s3:*",
#         "Resource": "arn:aws:s3:::hoit-medicines/*"
#       }
#     ]
#   }
#   EOF
# }

# {
# 	"Version": "2012-10-17",
# 	"Statement": [
# 		{
# 			"Sid": "Statement1",
# 			"Effect": "Allow",
# 			"Principal" : "*",
# 			"Resource": "arn:aws:s3:::hoit-medicines/*",
# 			"Action": [
# 				"s3:*"
# 			]
# 		}
# 	]

# }
