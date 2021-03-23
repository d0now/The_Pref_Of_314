param (
    [Parameter(Position=0, mandatory=$true)]
    [string] $Alias
);

function ScriptMain {

    param (
        [Parameter(Position=0, mandatory=$true)]
        [string] $Alias
    );

    [string] $Result = "";

    try {
        $Result = Get-Command $Alias -errorAction SilentlyContinue | Select-Object -ExpandProperty Definition
    } finally {
        Write-Host -NoNewline $Result;
    }
}

ScriptMain -Alias $Alias;
exit 0;