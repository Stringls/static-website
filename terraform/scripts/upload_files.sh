#! /bin/bash

aws s3 sync . s3://$1/ \
    --exclude ".git/*" --exclude "README.MD" \
    --exclude "LICENSE.MD" --exclude "terraform/*" \
    --exclude ".gitignore" --exclude ".github/*" \
    --exclude "Jenkinsfile"

echo "All files in the bucket are updated"