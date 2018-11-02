#!/bin/sh
awsRoleName=""
customerID=""
activationId=""
outputFile=""
amzFile=""
bucket=""
resource="s3://${bucket}/${amzFile}"
apt update >> /dev/null
apt -y install jq >> /dev/null
apt -y install awscli >> /dev/null
export AWS_ACCESS_KEY_ID=$(/usr/bin/curl --silent http://169.254.169.254/latest/meta-data/iam/security-credentials/${awsRoleName}/AccessKeyId | jq -r '.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(/usr/bin/curl --silent http://169.254.169.254/latest/meta-data/iam/security-credentials/${awsRoleName}/AccessKeyId | jq -r '.SecretAccessKey')
export AWS_SESSION_TOKEN=$(/usr/bin/curl --silent http://169.254.169.254/latest/meta-data/iam/security-credentials/${awsRoleName}/AccessKeyId | jq -r '.Token')
aws s3 cp ${resource} ${outputFile}
dpkg --install ${outputFile}
/usr/local/qualys/cloud-agent/bin/qualys-cloud-agent.sh ActivationId=${activationId} CustomerId=${customerID}
