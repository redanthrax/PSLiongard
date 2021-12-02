function Get-LGAPIGeneric {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Endpoint
    .OUTPUTS
    .EXAMPLE
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [string] $Endpoint
    )

    Begin {
        $uri = ($Script:Server + $Endpoint)
        $results = @()
    }

    Process {
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("X-ROAR-API-KEY", $Script:APIKey)
        $Arguments = @{
            Method = "GET"
            Headers = $headers
            URI = $uri
        }
        
        Try {
            $results = Invoke-LiongardAPI -Arguments $Arguments
        }
        Catch {
            $results = $null
        }
    }

    End {
        return $results
    }
}