#! /bin/bash
S3_BUCKET_NAME="$1"
AWS_REGION="$2"
# RANDOM_STRING=$(echo $RANDOM | head -c 4; echo)

# RESULT=$S3_BUCKET_NAME$RANDOM_STRING

aws s3api create-bucket \
    --bucket $S3_BUCKET_NAME \
    --region $AWS_REGION \
    --create-bucket-configuration LocationConstraint=$AWS_REGION