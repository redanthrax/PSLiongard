function Connect-LiongardAPI {
    <#
    .SYNOPSIS
    Connect to the Liongard API
    .PARAMETER Instance
    The instance for your Liongard server.
    .PARAMETER AccessKeyID
    The Access Key ID supplied by Liongard
    .PARAMETER AccessKeySecret
    The Access key Secret supplied by Liongard
    .OUTPUTS
    The full API URL and Api Key into Script Variables $LiongardServer and $LiongardKey

    .EXAMPLE
    Connect-LiongardAPI -Instance "us3" -APIKey "mylongapikey"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True)]
        [String]$Instance,

        [Parameter(Mandatory = $True)]
        [String]$AccessKeyID,

        [Parameter(Mandatory = $True)]
        [String]$AccessKeySecret
    )

    Begin {
        While (!($Instance -match '.+')) {
            $Instance = Read-Host -Prompt "Please enter your Liongard Instance:" 
        }
        If (!($AccessKeyID -match '.+')) {
            $AccessKeyID = Read-Host -Prompt "Please enter your Liongard API Key:" 
        }
        If (!($AccessKeySecret -match '.+')) {
            $AccessKeySecret = Read-Host -Prompt "Please enter your Liongard API Key:" 
        }

        $Script:LiongardIsConnected = $false
    }

    Process {
        $ApiServerURI = ('https://' + $Instance + '.app.liongard.com/api/v1/')
        Do {
            $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
            $Bytes = [System.Text.Encoding]::UTF8.GetBytes("$($AccessKeyID):$($AccessKeySecret)")
            $EncodedText =[Convert]::ToBase64String($Bytes)
            $headers.Add("X-ROAR-API-KEY", $EncodedText)
            Try {
                $null = Invoke-RestMethod ($ApiServerURI + 'environments/count') -Method 'GET' -Headers $headers
                $Script:LiongardIsConnected = $True
                Return
            }
            Catch {
                $_.Exception.Message
                Return
            }
        }
        Until (![string]::IsNullOrEmpty($jsonResponse))
    }

    End {
        $Script:Server = $ApiServerURI
        $Script:APIKey = $EncodedText
    }
}