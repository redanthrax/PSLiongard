function Get-LGAlerts {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Endpoint
    .OUTPUTS
    .EXAMPLE
    #>
    
    $alerts = Get-LGAPIGeneric -Endpoint "tasks"
    return $alerts
}