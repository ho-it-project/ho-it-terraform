output "ecr_url" {
  description = "ecr url"
  value       = aws_ecr_repository.hoit_ecr.repository_url
}
