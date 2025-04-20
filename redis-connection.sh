#!/bin/bash

##########################
#### SCOPE ###############
##########################

User wanted to monitor Active connections and Rejected connections for their managed redis instance.
As we do not provide a metrics for this, we suggested user to use below script,
and run it as a cron job every minute. 

# Define Redis connection parameters
HOST="user-host-name.db.ondigitalocean.com"
PORT="25061"
PASSWORD="user-password-here"

# Get the active connection count
ACTIVE_CONNECTIONS=$(redis-cli --tls -h "$HOST" -p "$PORT" -a "$PASSWORD" info | grep "connected_clients:" | cut -d':' -f2 | tr -d '[:space:]')

# Get the number of rejected connections
REJECTED_CONNECTIONS=$(redis-cli --tls -h "$HOST" -p "$PORT" -a "$PASSWORD" info stats | grep "rejected_connections:" | cut -d':' -f2 | tr -d '[:space:]')

# Create or append to the log file
LOG_FILE="/var/log/redis_connection.log"

# Log the results with a timestamp
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Active connections: $ACTIVE_CONNECTIONS, Rejected connections: $REJECTED_CONNECTIONS"
} >> "$LOG_FILE"
