output "ecr_url" {
  description = "ecr url"
  value       = aws_ecr_repository.notification-server.repository_url
}
