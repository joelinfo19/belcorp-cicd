# ecs-cluster.tf
provider "aws" {
  region = "us-west-2"
}

# Crear el cluster de ECS
resource "aws_ecs_cluster" "devcluster" {
  name = "devcluster"
}

# Crear una definición de tarea (Task Definition)
resource "aws_ecs_task_definition" "devtask" {
  family                   = "devtask"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "my-java-app"
    image     = "${aws_ecr_repository.my_java_app.repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
}

# Crear una definición del servicio (Service Definition)
resource "aws_ecs_service" "devservice" {
  name            = "devservice"
  cluster         = aws_ecs_cluster.devcluster.id
  task_definition = aws_ecs_task_definition.devtask.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.main.id]
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.devtask]
}

