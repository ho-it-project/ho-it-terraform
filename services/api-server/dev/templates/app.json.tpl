[
  {
    "essential": true,
    "memory": 256,
    "name": "api-server",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:latest",
    "workingDirectory": "/app",
    "portMappings": [
        {
            "containerPort": 8000
        }
    ]
  }
]