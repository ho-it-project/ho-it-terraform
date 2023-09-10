[
  {
    "name": "kafka${KAFKA_NUM}",
    "image": "${REPOSITORY_URL}:latest",
    "memoryReservation": 512,
    "essential": true,
    "hostname": "${KAFKA_HOST_NAME}",
    "portMappings": [
      {
        "containerPort": 9092,
        "hostPort": 9092
      },
      {
        "containerPort": 29093,
        "hostPort": 29093
      },
      {
        "containerPort": 29092,
        "hostPort": 29092
      }
    ],
    "environment":[
      { "name": "KAFKA_NODE_ID", "value": "${KAFKA_NUM}" },
      { "name": "KAFKA_CONTROLLER_LISTENER_NAMES", "value": "CONTROLLER" },
      { "name": "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP", "value": "CONTROLLER:PLAINTEXT,INTERNAL:PLAINTEXT,EXTERNAL:PLAINTEXT" },
      { "name": "KAFKA_LISTENERS", "value": "INTERNAL://${KAFKA_HOST_NAME}:29092,CONTROLLER://${KAFKA_HOST_NAME}:29093,EXTERNAL://0.0.0.0:9092" },
      { "name": "KAFKA_ADVERTISED_LISTENERS", "value": "INTERNAL://${KAFKA_HOST_NAME}:29092,EXTERNAL://${KAFKA_HOST_NAME}:9092" },
      { "name": "KAFKA_INTER_BROKER_LISTENER_NAME", "value": "INTERNAL" },
      { "name": "KAFKA_CONTROLLER_QUORUM_VOTERS", "value": "${KAFKA_CONTROLLER_QUORUM_VOTERS}" },
      { "name": "KAFKA_PROCESS_ROLES", "value": "broker,controller" },
      { "name": "KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS", "value": "0" },
      { "name": "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR", "value": "${KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR}" },
      { "name": "KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR", "value": "${KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR}" },
      { "name": "CLUSTER_ID", "value": "ciWo7IWazngRchmPES6q5A==" },
      { "name": "KAFKA_LOG_DIRS", "value": "/tmp/kraft-combined-logs" },
      { "name": "KAFKA_AUTO_CREATE_TOPICS_ENABLE", "value": "false" },
      { "name": "KAFKA_HEAP_OPTS", "value" :"-Xmx256M -Xms128M"}
    ]
  }
]