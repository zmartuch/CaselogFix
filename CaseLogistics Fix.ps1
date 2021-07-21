$PCName = Read-host 'What PC asset number' 

## Test

	
function Show-Menu
{
    param (    )
    Clear-Host
    write-host "============================== Case Systems auto-updating for $PCName========================"
    
    Write-host "1: Press '1' for Case Logistics"
    Write-Host "2: Press '2' for Caseline Pricing"
    Write-Host "Q: Press 'Q' to quit."
}

Show-Menu
$Program = Read-Host 'Which program needs updating?'
switch ($Program)
 {
     '1' {
                    $TargetFile = "\\$PCName\C$\Program Files\Case Systems\ShipRight\Case logistics.exe"
                    $ShortcutFile = "\\$PCName\C$\Users\Public\Desktop\Case Logistics.lnk"
                    $WScriptShell = New-Object -ComObject WScript.Shell
                    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
                    $Shortcut.TargetPath = $TargetFile
                    $Shortcut.Save()
                    copy "\\fs2\Apps\Shipright\Case Logistics.exe" "\\$PCName\C$\Program Files\Case Systems\ShipRight\Case logistics.exe"
                    $Acl = Get-Acl "\\$PCName\C$\Program Files\Case Systems\ShipRight\"
                    $Ar = New-Object  system.security.accesscontrol.filesystemaccessrule('Everyone','Modify','ContainerInherit,ObjectInherit', 'None', 'Allow')
                    $Acl.SetAccessRule($Ar)
                    Set-Acl "\\$PCName\C$\Program Files\Case Systems\ShipRight\" $Acl
     } '2' {
        copy "\\fs2\Apps\CLPricing16\CLPricing16.exe" "\\$PCName\c$\Program Files (x86)\Case Systems\CLPricing16\CLPricing16.exe"
        write-host "CLPricing has been updated on $PCName."

     } 'q' {
         return
     }
 }
