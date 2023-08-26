[
  {
    "essential": true,
    "memory": 256,
    "name": "er-front",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:latest",
    "workingDirectory": "/app",
    "portMappings": [
        {
            "containerPort": 4000
        }
    ]
  }
]