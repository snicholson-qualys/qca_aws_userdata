<powershell>
$awsRoleName=""
$customerID=""
$activationId=""
$outputFile="c:\tmp\qualyscloudagent.exe"
$amzFile="QualysCloudAgent.exe"
$bucket=""

$Creds = Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/iam/security-credentials/$awsRoleName/AccessKeyId/
Copy-S3Object -BucketName $bucket -Key $amzFile -LocalFile $outputfile -AccessKey $creds.AccessKeyId -SecretKey $creds.SecretAccessKey -SessionToken $creds.Token
c:\tmp\QualysCloudAgent.exe CustomerId=$customerID ActivationId=$activationId
</powershell>
