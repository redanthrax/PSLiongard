function Get-LGChanges {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Endpoint
    .OUTPUTS
    .EXAMPLE
    #>

    $changes = Get-LGAPIGeneric -Endpoint "detections"
    return $changes
}