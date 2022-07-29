#! /bin/bash

aws s3 cp . s3://$1/ --recursive \
    --exclude ".git/*" --exclude "README.MD" \
    --exclude "LICENSE.MD" --exclude "terraform/*" \
    --exclude ".gitignore" --exclude ".github/*" \
    --exclude "Jenkinsfile"

echo "The S3 bucket has been created"