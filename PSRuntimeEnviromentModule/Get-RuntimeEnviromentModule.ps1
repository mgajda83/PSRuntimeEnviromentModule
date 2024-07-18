Function Get-RuntimeEnviromentModule
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
	$ModuleName = $Module.Name
}
Get-RuntimeEnviromentModule @Params
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
		[Parameter()]
		[String]$ModuleName
	)

	$Uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroup)/providers/Microsoft.Automation/automationAccounts/$($AccountName)/runtimeEnvironments/$($RuntimeEnvironmentName)/packages/$($ModuleName)?api-version=2023-05-15-preview"

	$Package = Invoke-AzRestMethod -Method GET -Uri $Uri
	Write-Verbose "StatusCode: $($Package.StatusCode)"

	$Response = $Package.Content | ConvertFrom-Json

	if($Response.value)
	{
		Return $Response.value
	} else {
		Return $Response
	}
}
