﻿
<#
    .SYNOPSIS
        Start a specified environment through LCS.
        
    .DESCRIPTION
        Start a specified IAAS environment that is Microsoft managed or customer managed through the LCS API.
        
    .PARAMETER ProjectId
        The project id for the Dynamics 365 for Finance & Operations project inside LCS
        
        Default value can be configured using Set-D365LcsApiConfig
        
    .PARAMETER BearerToken
        The token you want to use when working against the LCS api
        
        Default value can be configured using Set-D365LcsApiConfig
        
    .PARAMETER EnvironmentId
        The unique id of the environment that you want to take action upon
        
        The Id can be located inside the LCS portal

    .PARAMETER LcsApiUri
        URI / URL to the LCS API you want to use
        
        Depending where your LCS project is located, there are several valid URI's / URL's
        
        Valid options:
        "https://lcsapi.lcs.dynamics.com"
        "https://lcsapi.eu.lcs.dynamics.com"
        "https://lcsapi.fr.lcs.dynamics.com"
        "https://lcsapi.sa.lcs.dynamics.com"
        "https://lcsapi.uae.lcs.dynamics.com"
        "https://lcsapi.lcs.dynamics.cn"
        
        Default value can be configured using Set-D365LcsApiConfig

    .PARAMETER EnableException
        This parameters disables user-friendly warnings and enables the throwing of exceptions
        This is less user friendly, but allows catching exceptions in calling scripts
        
    .EXAMPLE
        PS C:\> Invoke-D365LcsEnvironmentStart -ProjectId 123456789 -EnvironmentId "958ae597-f089-4811-abbd-c1190917eaae" -BearerToken "JldjfafLJdfjlfsalfd..." -LcsApiUri "https://lcsapi.lcs.dynamics.com"
        
        This will trigger the environment start operation upon the given environment through the LCS API.
        The LCS project is identified by the ProjectId 123456789, which can be obtained in the LCS portal.
        The environment is identified by the EnvironmentId "958ae597-f089-4811-abbd-c1190917eaae", which can be obtained in the LCS portal.
        The request will authenticate with the BearerToken "JldjfafLJdfjlfsalfd...".
        The http request will be going to the LcsApiUri "https://lcsapi.lcs.dynamics.com"

    .LINK
        Get-D365LcsApiConfig
        
    .LINK
        Get-D365LcsApiToken

    .LINK
        Invoke-D365LcsApiRefreshToken

    .LINK
        Set-D365LcsApiConfig
        
    .LINK
        Invoke-D365LcsEnvironmentStop
        
    .NOTES
        Only IAAS (Customer managed and Microsoft managed) are supported with this API. Self-service environments do not have a start functionality and will not work with this API.
        
        Tags: Environment, Start, StartStop, LCS, Api
        
        Author: Billy Richardson (@richardsondev)
        
#>

function Invoke-D365LcsEnvironmentStart {
    [CmdletBinding()]
    [OutputType()]
    param(
        [Parameter(Mandatory = $false)]
        [int] $ProjectId = $Script:LcsApiProjectId,
        
        [Parameter(Mandatory = $false)]
        [Alias('Token')]
        [string] $BearerToken = $Script:LcsApiBearerToken,

        [Parameter(Mandatory = $true)]
        [string] $EnvironmentId,
        
        [Parameter(Mandatory = $false)]
        [string] $LcsApiUri = $Script:LcsApiLcsApiUri,

        [switch] $EnableException
    )

    Invoke-TimeSignal -Start

    if (-not ($BearerToken.StartsWith("Bearer "))) {
        $BearerToken = "Bearer $BearerToken"
    }

    $operationJob = Start-LcsEnvironmentStartStop -ProjectId $ProjectId -BearerToken $BearerToken -EnvironmentId $EnvironmentId -IsStop $False -LcsApiUri $LcsApiUri

    $operationJob

    Invoke-TimeSignal -End
}