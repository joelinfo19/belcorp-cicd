# outputs.tf
output "ecr_repository_url" {
  value = aws_ecr_repository.my_java_app.repository_url
}

output "ecs_service_name" {
  value = aws_ecs_service.devservice.name
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.devtask.arn
}

