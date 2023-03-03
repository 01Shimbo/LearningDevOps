# Creates Some new groups with some premissions
New-IAMgroup -GroupName "Developer"
New-IAMgroup -GroupName "Staging"
New-IAMgroup -GroupName "Production"
# start creating policies for groups
$BasicUserPolicy_json = @'
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "iam:GetLoginProfile",
                "iam:CreateLoginProfile",
                "iam:FinalizeSmsMfaRegistration",
                "iam:ListAccessKeys",
                "iam:RequestSmsMfaRegistration",
                "iam:ChangePassword",
                "iam:ListSigningCertificates",
                "iam:DeleteLoginProfile",
                "iam:ListSSHPublicKeys"
            ],
            "Resource": [
                "arn:aws:iam::246689668582:user/${aws:username}"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "iam:ListUsers",
                "iam:ListAccountAliases",
                "iam:GetAccountPasswordPolicy",
                "iam:GetAccountSummary"
            ],
            "Resource": [
                "arn:aws:iam::246689668582:*"
            ],
            "Effect": "Allow"
        }
    ]
}
'@

$DevEC2CreatePolicy_json = @'
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:Describe*",
                "ec2:GetConsole*",
                "ec2:Create*",
                "ec2:*instance*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "ec2:RunInstances",
                "ec2:AttachVolume",
                "ec2:DetachVolume"
            ],
            "Resource": [
                "arn:aws:ec2:::subnet/*",
                "arn:aws:ec2:::network-interface/*",
                "arn:aws:ec2:::instance/*",
                "arn:aws:ec2:::volume/*",
                "arn:aws:ec2:::image/ami-*",
                "arn:aws:ec2:::key-pair/*",
                "arn:aws:ec2:::security-group/*"
            ],
            "Effect": "Allow"
        }
    ]
}
'@
$StagePolicy_json = @'
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:ListBucket"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
'@
$ProductionPolicy_json = @'
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "codepipeline:GetPipeline",
                "codepipeline:GetPipelineState",
                "codepipeline:GetPipelineExecution",
                "codepipeline:ListPipelineExecutions",
                "codepipeline:ListPipelines",
                "codepipeline:PutApprovalResult"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
'@

#  Create policies and assign them to groups
$grouparray = "Developer", "Staging", "Production"
foreach ($group in $grouparray)
{
Write-IAMGroupPolicy -GroupName $group -PolicyName "BasicUserPolicy" -PolicyDocument $BasicUserPolicy_json
}

Write-IAMGroupPolicy -GroupName "Developer" -PolicyName "DevEC2CreatePolicy" -PolicyDocument $DevEC2CreatePolicy_json
Write-IAMGroupPolicy -GroupName "Staging" -PolicyName "StagePolicy" -PolicyDocument $StagePolicy_json
Write-IAMGroupPolicy -GroupName "Production" -PolicyName "ProductionPolicy" -PolicyDocument $ProductionPolicy_json
