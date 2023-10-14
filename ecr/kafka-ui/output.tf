output "ecr_url" {
  description = "kafka-ui"
  value       = aws_ecr_repository.er-front.repository_url
}
