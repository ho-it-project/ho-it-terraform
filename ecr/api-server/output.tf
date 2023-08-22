output "ecr_url" {
  description = "ecr url"
  value       = aws_ecr_repository.api-server.repository_url
}
