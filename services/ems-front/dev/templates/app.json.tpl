[
  {
    "essential": true,
    "memory": 256,
    "name": "ems-front",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:latest",
    "workingDirectory": "/app",
    "portMappings": [
        {
            "containerPort": 3000
        }
    ]
  }
]