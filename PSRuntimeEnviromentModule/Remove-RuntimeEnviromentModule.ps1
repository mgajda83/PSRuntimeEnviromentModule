Function Remove-RuntimeEnviromentModule
{
<#
	.SYNOPSIS
		Remove PowerShell module from Runtime Environment.

	.EXAMPLE
$Params = @{
	$SubscriptionId = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
	$ResourceGroup = "RG-AutomationTasks"
	$AccountName = "AutomationScripts"
	$RuntimeEnvironmentName = "PowerShell-5_1-Dev"
	$ModuleName = "PSMSAL"
}
Remove-RuntimeEnviromentModule @Params
#>
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory=$true)]
		[String]$SubscriptionId,
		[Parameter(Mandatory=$true)]
		[String]$ResourceGroup,
		[Parameter(Mandatory=$true)]
		[String]$AccountName,
		[Parameter(Mandatory=$true)]
		[String]$RuntimeEnvironmentName,
		[Parameter(Mandatory=$true)]
		[String]$ModuleName
	)

	$Uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroup)/providers/Microsoft.Automation/automationAccounts/$($AccountName)/runtimeEnvironments/$($RuntimeEnvironmentName)/packages/$($ModuleName)?api-version=2023-05-15-preview"
	$Package = Invoke-AzRestMethod -Method DELETE -Uri $Uri -Payload $Body
	Write-Verbose "StatusCode: $($Package.StatusCode)"
}
