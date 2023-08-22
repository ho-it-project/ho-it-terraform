output "ecr_url" {
  description = "ecr url"
  value       = aws_ecr_repository.ems-front.repository_url
}
