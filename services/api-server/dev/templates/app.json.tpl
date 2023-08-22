[
  {
    "essential": true,
    "memory": 256,
    "name": "api-server",
    "cpu": 256,
    "image": "${REPOSITORY_URL}",
    "workingDirectory": "/app",
    "portMappings": [
        {
            "containerPort": 8000,
            "hostPort": 8000
        }
    ]
  }
]