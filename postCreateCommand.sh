#!/bin/bash

echo -e "ANGULAR_URL=\"https://$CODESPACE_NAME-4200.$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN\"\nAUTH_URL=\"https://$CODESPACE_NAME-44396.$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN\"\nAPP_URL=\"https://$CODESPACE_NAME-44390.$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN\"\nApp__CorsOrigin=$ANGULAR_URL\nApp__SelfUrl=$AUTH_URL\nApp__ClientUrl=$ANGULAR_URL\nApp__CorsOrigins=$ANGULAR_URL,$AUTH_URL,$APP_URL\nApp__RedirectAllowedUrls=$ANGULAR_URL,$AUTH_URL,$APP_URL" >> ~/.bashrc
source ~/.bashrc


# Install the Volo.Abp.Cli tool
dotnet tool install -g Volo.Abp.Cli

# Start SQL Server container
docker run --name tmp-sqlserver \
    --restart unless-stopped \
    -d \
    --cap-add SYS_PTRACE \
    -e 'ACCEPT_EULA=1' \
    -e 'MSSQL_SA_PASSWORD=myPassw0rd' \
    -p 1433:1433 \
    mcr.microsoft.com/azure-sql-edge

# Start Redis container
docker run --name redis \
    -p 6379:6379 \
    -d \
    redis

# Start RabbitMQ container
docker run --name tmp-rabbitmq \
    -d \
    --restart unless-stopped \
    -p 15672:15672 \
    -p 5672:5672 \
    rabbitmq:3-management
