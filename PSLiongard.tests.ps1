Get-Module PSLiongard | Remove-Module -Force
Import-Module "$PSScriptRoot\PSLiongard.psm1" -Force

$Script:creds = $null
if(Test-Path "$PSScriptRoot\\credentials.json") {
    $Script:creds = Get-Content $PSScriptRoot\credentials.json | ConvertFrom-Json
}

Describe PSLiongard {
    It "PSLiongard is valid Powershell code" {
        $psFile = Get-Content -Path "$PSScriptRoot\PSLiongard.psm1" -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
        $errors.Count | Should -Be 0
    }

    It "Connects to the Liongard API" {
        if($Script:creds) {
            $result = Connect-LiongardAPI -Instance $creds.Instance -AccessKeyID $creds.AccessKeyID `
                -AccessKeySecret $creds.AccessKeySecret
        }
        else {
            $result = Connect-LiongardAPI
        }
        
        $result | Should -Be $null
    }

    It "Gets Liongard Environments" {
        $results = Get-LGEnvironments
        $results | Should -Not -Be $null
    }

    It "Gets Liongard Alerts" {
        $results = Get-LGAlerts
        $results | Should -Not -Be $null
    }

    It "Gets Liongard Changes" {
        $results = Get-LGChanges
        $results | Should -Not -Be $null
    }
}