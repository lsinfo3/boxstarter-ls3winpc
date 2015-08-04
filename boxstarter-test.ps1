# Boxstarter options
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

cinst powershell
if (Test-PendingReboot) { Invoke-Reboot }
  
Update-ExecutionPolicy Unrestricted
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst
Enable-RemoteDesktop		
Set-TaskbarOptions -Size Small

if (Test-PendingReboot) { Invoke-Reboot }


$wallpaperUrl = "https://gist.githubusercontent.com/StephenKing/eee9c8344d8e1ec72ca0/raw/i3-wallpaper-4k.png"
$wallpaperFile = "$env:USERPROFILE\i3-wallpaper-4k.png"
Invoke-WebRequest $wallpaperUrl -OutFile $wallpaperFile
Set-ItemProperty -path "HKCU:Control Panel\Desktop" -name wallpaper -value $wallpaperFile

$intelHdGraphicsUrl = "http://downloadmirror.intel.com/25143/eng/win64_153623.exe"
$intelHdGraphicsFile = "$env:USERPROFILE\Downloads\intel-hd-4600_win64_153623.exe"
Invoke-WebRequest $intelHdGraphicsUrl -OutFile $intelHdGraphicsFile
& "$intelHdGraphicsFile" -s -A -s

# Install-WindowsUpdate -AcceptEula		

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
cinst vagrant
cinst virtualbox

# create HWP user
$username = "hwp"
$Computername = $env:COMPUTERNAME
$Server=[ADSI]"WinNT://$Computername"
$NewUser=$Server.Create("User",$username)
$NewUser.SetPassword("hwp")

# flags see http://www.hofferle.com/modify-local-user-account-flags-with-powershell/
$ADS_UF_PASSWD_CANT_CHANGE = 64     # 0x40
$ADS_UF_DONT_EXPIRE_PASSWD = 65536  # 0x10000
$NewUser.userflags.value = $newuser.UserFlags.value -BOR $ADS_UF_PASSWD_CANT_CHANGE
$NewUser.userflags.value = $newuser.UserFlags.value -BOR $ADS_UF_DONT_EXPIRE_PASSWD
$NewUser.SetInfo()
# add user to the "Users" group
$UsersGroup = [ADSI]"WinNT://$Computername/Users,group"
$UsersGroup.Add($NewUser.path)
