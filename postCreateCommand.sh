#!/bin/bash

# Install dotnet cert
dotnet dev-certs https --trust

# Install the Volo.Abp.Cli tool
dotnet tool install -g Volo.Abp.Cli
abp install-libs

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
