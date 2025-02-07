#!/bin/sh

# Fetch parameters from AWS Parameter Store and write to .env file
aws ssm get-parameters-by-path --path "/my-app/" --with-decryption --query "Parameters[*].{Name:Name,Value:Value}" --output text | awk '{print $1 "=" $2}' > /app/.env