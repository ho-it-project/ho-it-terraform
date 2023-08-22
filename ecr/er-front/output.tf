output "ecr_url" {
  description = "ecr url"
  value       = aws_ecr_repository.er-front.repository_url
}
