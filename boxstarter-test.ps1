Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
Enable-RemoteDesktop		
Install-WindowsUpdate -AcceptEula		

cinst bitkinex
cinst notepadplusplus.install
cinst adobereader
cinst googlechrome
cinst chocolatey

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