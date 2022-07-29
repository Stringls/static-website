// Define variable
def BUCKET_NAME

pipeline {
    agent { 
        docker { 
            image 'zenika/terraform-aws-cli'
            args '''
                -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
                -e "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
                -e "AWS_DEFAULT_REGION=$AWS_REGION"
            '''
        }
    }

    environment {
        TF_DIR                = 'terraform'
        S3_BUCKET             = 'tfstate-holder'
        S3_BUCKET_KEY         = 'tfstate'
        AWS_REGION            = credentials('jenkins-aws-region')
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages {
        stage('Create an S3 bucket to store the terraform state') {            
            steps {
                try {
                    dir('${TF_DIR}/scripts') {
                        sh './create_s3_for_backend.sh "${S3_BUCKET}" "$AWS_REGION"'
                    }
                } catch (err) {
                    echo "Caught: ${err}"
                    currentBuild.result = 'FAILED'
                }
            }
        }

        stage('Terraform') {
            steps {
                dir('${TF_DIR}') {
                    sh '''
                        terraform fmt -recursive

                        terraform init \
                            -backend-config="bucket=${S3_BUCKET}" \
                            -backend-config="key=${S3_BUCKET_KEY}" \
                            -backend-config="region=$AWS_REGION"
                        
                        terraform validate -no-color
                        terraform plan -no-color

                        terraform apply -input=false -auto-approve \
                            -var="AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
                            -var="AWS_REGION=$AWS_REGION" \
                            -var="AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
                    '''
                    // BUCKET_NAME = sh(returnStdout: true, script: '''
                    //     terraform output bucket_name | tr -d '"'
                    // ''')
                }
            }
        }

        stage('Upload the static files to S3 bucket') {
            steps {
                dir('${TF_DIR}/scripts') {
                    sh './upload_files.sh "${terraform.bucket_name}"'
                }
                echo 'Files have been succesfully uploaded to S3 bucket'
            }
        }
    }
}