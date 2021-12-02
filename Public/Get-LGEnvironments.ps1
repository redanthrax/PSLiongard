function Get-LGEnvironments {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .OUTPUTS
    .EXAMPLE
    #>
    
    $environments = Get-LGAPIGeneric -Endpoint "environments"
    return $environments
}