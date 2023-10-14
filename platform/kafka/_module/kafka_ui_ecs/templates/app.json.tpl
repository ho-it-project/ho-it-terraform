[
  {
    "essential": true,
    "name": "kafka-ui",
    "image": "${REPOSITORY_URL}:latest",
    "memoryReservation": 512,
    "portMappings": [
      {
        "containerPort": 8080
      }
    ],
    "environment":[
      { "name": " KAFKA_CLUSTERS_0", "value": "prod" },
      { "name": "KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS", "value": "${KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS}" },
      { "name": "kraft", "value": "true"},
      { "name": "KAFKA_LOG_DIRS", "value": "/tmp/kraft-combined-logs"}
    ]
  }
]