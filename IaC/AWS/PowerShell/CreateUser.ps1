# Creates a IAM role with a specified name and assigns them to a pre existing group.
Param ($IAM_username, $IAM_group)
# example: .\CreateUser.ps1 Thomas Developer
$Passwordgen = -Join("ABCDabcd&@#$%1234".tochararray() | Get-Random -Count 10 | % {[char]$_})
$userDict = @{
    UserName              = $IAM_username
    Password              = $Passwordgen
    PasswordResetRequired = $true
}

New-IAMUser -UserName $userDict.UserName
New-IAMLoginProfile @userDict
Add-IAMUserToGroup -UserName "$IAM_username" -GroupName "$IAM_group"
write-host "New IAM User Created dont forget to share the password with them"
write-host "Username:"$userDict.UserName
write-host "Group:"$IAM_group
write-host "Password:"$userDict.password

# to remove all groups from user
# $groups = Get-IAMGroupForUser -UserName Theresa 
# foreach ($group in $groups) { Remove-IAMUserFromGroup -GroupName $group.GroupName -UserName Theresa -Force }