function Invoke-LiongardAPI {
    <#
    .SYNOPSIS
        Internal function used to make API calls
    .DESCRIPTION
        Internal function used to make API calls
    .PARAMETER Arguments
        Required parameters for the API call
    .OUTPUTS
        The returned results from the API call
    .NOTES
        Version:        0.0.1
        Author:         Gary G
        Creation Date:  2021-12-01
    .EXAMPLE
        Invoke-LiongardAPI -Arguments $Arguments
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        $Arguments,
        [int]$MaxRetry = 5
    )

    Begin {
    }

    Process {
        If (!$Script:LiongardIsConnected) {
            $ErrorMessage = @()
            $ErrorMessage += "Not connected to Liongard"
            $ErrorMessage += $_.ScriptStackTrace
            $ErrorMessage += ''
            $ErrorMessage += "#/> Run 'Connect-LiongardAPI' to initialized the connection."
            Write-Error ($ErrorMessage | Out-String)
            Return
        }

        Try {
            $result = Invoke-RestMethod @Arguments
        }
        Catch {
            $_.ErrorDetails.Message
        }
    }

    End {
        Return $result
    }
}