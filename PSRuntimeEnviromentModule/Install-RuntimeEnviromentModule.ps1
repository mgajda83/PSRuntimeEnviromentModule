Function Install-RuntimeEnviromentModule
{
<#
	.SYNOPSIS
		Install PowerShell module from Runtime Environment.

	.EXAMPLE
$Module = Find-Module -Name PSMSAL -Repository PSGallery
$Params = @{
	$SubscriptionId = "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee"
	$ResourceGroup = "RG-AutomationTasks"
	$AccountName = "AutomationScripts"
	$RuntimeEnvironmentName = "PowerShell-5_1-Dev"
	$ModuleName = $Module.Name
	$ModuleVersion = $Module.Version
}
Install-RuntimeEnviromentModule @Params
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
		[String]$ModuleName,
		[Parameter(Mandatory=$true)]
		[String]$ModuleVersion
	)

	$Uri = "https://management.azure.com/subscriptions/$($SubscriptionId)/resourceGroups/$($ResourceGroup)/providers/Microsoft.Automation/automationAccounts/$($AccountName)/runtimeEnvironments/$($RuntimeEnvironmentName)/packages/$($ModuleName)?api-version=2023-05-15-preview"
	$Body = @{
		properties = @{
			contentLink = @{
				uri = "https://devopsgallerystorage.blob.core.windows.net/packages/$($ModuleName).$($ModuleVersion).nupkg".ToLower()
			}
			version = "$($Module.Version)"
		}
	} | ConvertTo-Json -Depth 3

	$Package = Invoke-AzRestMethod -Method PUT -Uri $Uri -Payload $Body
	Write-Verbose "StatusCode: $($Package.StatusCode)"

	Return $Package.Content | ConvertFrom-Json
}
