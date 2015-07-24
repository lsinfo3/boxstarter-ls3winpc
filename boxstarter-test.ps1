try {
  
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst
Enable-RemoteDesktop		
Install-WindowsUpdate -AcceptEula		
Update-ExecutionPolicy Unrestricted

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
$NewUser.SetInfo()
# flags see http://www.hofferle.com/modify-local-user-account-flags-with-powershell/
$ADS_UF_PASSWD_CANT_CHANGE = 64     # 0x40
$ADS_UF_DONT_EXPIRE_PASSWD = 65536  # 0x10000
$NewUser.userflags.value = $newuser.UserFlags.value -BOR $ADS_UF_PASSWD_CANT_CHANGE
$NewUser.userflags.value = $newuser.UserFlags.value -BOR $ADS_UF_DONT_EXPIRE_PASSWD

Write-ChocolateySuccess 'Setup finished'

} catch {
  Write-ChocolateyFailure 'Setup failed: ' $($_.Exception.Message)
  throw
}