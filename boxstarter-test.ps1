# Boxstarter options
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

try {
  
Update-ExecutionPolicy Unrestricted
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst
Enable-RemoteDesktop		
Set-TaskbarOptions -Size Small

if (Test-PendingReboot) { Invoke-Reboot }

Install-WindowsUpdate -AcceptEula		

if (Test-PendingReboot) { Invoke-Reboot }

cinst 7zip
cinst 7zip.install
cinst adobereader
cinst bitkinex
cinst chocolatey
cinst console2
cinst curl
cinst dotnet4.5
cinst firefox
cinst git
cinst git.install
cinst git-credential-winstore
cinst googlechrome
cinst notepadplusplus.install
cinst notepad2
cinst NuGet.CommandLine
cinst paint.net
cinst PDFCreator
cinst poshgit
cinst putty
cinst skype
cinst sysinternals
cinst vlc
cinst Wget


# create HWP user
$Computername = $env:COMPUTERNAME
[ADSI]$server="WinNT://$Computername"
$NewUser=$server.Create("User","hwp")
$NewUser.SetPassword("hwp")
# flags see http://www.hofferle.com/modify-local-user-account-flags-with-powershell/
$ADS_UF_PASSWD_CANT_CHANGE = 64     # 0x40
$ADS_UF_DONT_EXPIRE_PASSWD = 65536  # 0x10000
$NewUser.userflags.value = $newuser.UserFlags.value -BOR $ADS_UF_PASSWD_CANT_CHANGE
$NewUser.userflags.value = $newuser.UserFlags.value -BOR $ADS_UF_DONT_EXPIRE_PASSWD
$NewUser.SetInfo()

Write-ChocolateySuccess 'Setup finished'

} catch {
  Write-ChocolateyFailure 'Setup failed: ' $($_.Exception.Message)
  throw
}