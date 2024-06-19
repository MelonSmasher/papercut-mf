#! /usr/bin/env bash

if [ -z "$1" ]; then
    echo "Please pass in a papercut version as the first argument in the format of major.minor.patch.build"
    echo "Example: ./init.sh 20.0.4.55447"
    echo "You can find Papercut versions here: https://www.papercut.com/products/mf/release-history/"
    exit 1
fi

# Check for a .env file and create it if it doesn't exist
if [ ! -f .env ]; then
    cp ./src/.env.example .env
    # Generate a database password and update the .env file
    DB_PASSWORD=$(openssl rand -base64 32)
    sed -i "s,<DB_PASSWORD_HERE>,${DB_PASSWORD}," .env
    # generate the admin password and update the .env file
    ADMIN_PASSWORD=$(openssl rand -base64 32)
    sed -i "s,<ADMIN_PASSWORD_HERE>,${ADMIN_PASSWORD}," .env
    # Generate a UUID to append to the statuc hostname prefix
    UUID=$(date +%s)
    sed -i "s,<PC-HOSTNAME-UUID>,${UUID}," .env
    # Update the Papercut version in the .env file
    sed -i "s,<PC_VERSION>,${1}," .env
fi

# check for a docker-compose.yml file and create it if it doesn't exist
if [ ! -f docker-compose.yml ]; then
    cp ./src/docker-compose-example.yml docker-compose.yml
fi
