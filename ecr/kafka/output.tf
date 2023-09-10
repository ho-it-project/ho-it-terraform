output "ecr_url" {
  description = "kafka"
  value       = aws_ecr_repository.er-front.repository_url
}
