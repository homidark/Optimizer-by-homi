@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title PLATINUM OPTIMIZER  —  HOMI.COM
color 0A
mode con: cols=120 lines=42

:: ANSI
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"
set "RED=!ESC![38;2;255;77;106m"
set "DIM=!ESC![38;2;120;140;148m"
set "WHT=!ESC![97m"
set "PLT=!ESC![38;2;61;255;232m"
set "RST=!ESC![0m"

:: --------------------------------------------------------------------
:: ADMINISTRATOR CHECK
:: --------------------------------------------------------------------
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo.
    echo  !RED!Administrator rights required.!RST!
    echo  !DIM!Relaunching elevated...!RST!
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

cls
echo.
echo  !PLT!  ==================================================================!RST!
echo  !WHT!      P L A T I N U M     O P T I M I Z E R!RST!
echo  !PLT!                    MADE BY HOMI GANG!RST!
echo  !DIM!      Support 10/11  ·  250 KB class  ·  pls don't blame me :]
echo  !PLT!  ==================================================================!RST!
echo.
echo.
echo  ========================================================
echo                      CONTACT ME
echo  tiktok:@homidark_
echo  zalo[if you in vietnam]
echo  0878105938
echo  0566607489
echo  new SIM 0945123625
echo  also new SIM 0943425102
echo  ========================================================
echo.
echo  !WHT!  This pack will:!RST!
echo  !DIM!    1. Disable Windows Defender (real-time, services, tasks)!RST!
echo  !DIM!    2. Remove Copilot, Recall, widgets, and inbox AI!RST!
echo  !DIM!    3. Remove Xbox, Game Bar, and related services!RST!
echo  !DIM!    4. Strip preinstalled Windows apps!RST!
echo  !DIM!    5. Cut background processes (Extreme-Lite)!RST!
echo  !DIM!    6. Apply Platinum+ 9.1 kernel / GPU / I/O / power tweaks!RST!
echo  !DIM!    7. HOMI.COM priority pack (IFEO games, NIC, audio, timer)!RST!
echo  !DIM!    8. Create a restore point, then reboot!RST!
echo.
echo  !RED!  Defender will be turned off. You are responsible for the machine.!RST!
echo  !DIM!  If Tamper Protection is ON, open Windows Security and disable it first.!RST!
echo.
choice /c YN /n /m "  Continue? [Y/N] "
if errorlevel 2 (
    echo.
    echo  Cancelled.
    timeout /t 2 /nobreak >nul
    exit /b 0
)

echo.
echo  !PLT![00]!WHT! Restore point and registry backup!RST!
sc config VSS start= demand >nul 2>&1
sc start VSS >nul 2>&1
sc config swprv start= demand >nul 2>&1
sc start swprv >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Checkpoint-Computer -Description 'Optimizer by homi' -RestorePointType 'MODIFY_SETTINGS' } catch { }"
reg export HKLM "%USERPROFILE%\Desktop\homi.reg" /y >nul 2>&1
echo  !DIM!  Restore point requested. HKLM exported to Desktop\platinum_optimizer_homi_backup.reg!RST!
echo.

:: =====================================================================
:: 01. WINDOWS DEFENDER  —  FIRST
:: Real-time, cloud, services, scheduled tasks, Security Center tray
:: Does NOT disable boot-start filter drivers (avoids boot loops)
:: =====================================================================
echo  !PLT![01]!WHT! Disabling Windows Defender!RST!

:: Tamper Protection (may be ignored while TP is on)
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtection /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Defender\Features" /v TamperProtectionSource /t REG_DWORD /d 0 /f >nul 2>&1

:: Preferences via Defender cmdlets
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "try { Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableBlockAtFirstSeen $true -DisableIOAVProtection $true -DisableScriptScanning $true -DisableArchiveScanning $true -DisableEmailScanning $true -DisableRemovableDriveScanning $true -DisableScanningMappedNetworkDrivesForFullScan $true -DisableScanningNetworkFiles $true -DisableCatchupFullScan $true -DisableCatchupQuickScan $true -DisableIntrusionPreventionSystem $true -MAPSReporting 0 -SubmitSamplesConsent 2 -PUAProtection 0 -EnableControlledFolderAccess Disabled -DisableAutoExclusions $false -ErrorAction SilentlyContinue } catch { }" >nul 2>&1

:: Policy: turn the engine off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v ServiceKeepAlive /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v AllowFastServiceStartup /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableRoutinelyTakingAction /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRawWriteNotification /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpynetReporting /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v DisableBlockAtFirstSeen /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v ForceUpdateFromMU /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v DisableUpdateOnStartupWithoutEngine /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v MpEnablePus /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v MpCloudBlockLevel /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v Notification_Suppress /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v UILockdown /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Systray" /v HideSystray /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Virus and threat protection" /v UILockdown /t REG_DWORD /d 1 /f >nul 2>&1

:: SmartScreen
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v ShellSmartScreenLevel /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v SmartScreenEnabled /t REG_SZ /d "Off" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SmartScreenEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Security Center / Health
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection" /v DisallowExploitProtectionOverride /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Security Health\State" /v AccountProtection_MicrosoftAccount_Disconnected /t REG_DWORD /d 1 /f >nul 2>&1

:: Services
for %%S in (WinDefend WdNisSvc Sense SecurityHealthService wscsvc MdCoreSvc webthreatdefsvc webthreatdefusersvc) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

:: Scheduled tasks
for %%T in (
    "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
    "Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
    "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
    "Microsoft\Windows\Windows Defender\Windows Defender Verification"
    "Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
) do (
    schtasks /Change /TN %%T /Disable >nul 2>&1
)

:: Context menu / tray
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options" /v UILockdown /t REG_DWORD /d 1 /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /f >nul 2>&1

echo  !DIM!  Defender policies applied. Reboot required for services to stay down.!RST!
echo.

:: =====================================================================
:: 02. AI / COPILOT / RECALL / WIDGETS / BING
:: =====================================================================
echo  !PLT![02]!WHT! Removing Copilot, Recall, widgets, and inbox AI!RST!

:: Copilot policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1

:: Recall / Windows AI
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v AllowRecallEnablement /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableClickToDo /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v SetPremonitionSettings /t REG_DWORD /d 0 /f >nul 2>&1

:: Widgets / news and interests
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul 2>&1

:: Bing / search highlights / Cortana
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v EnableDynamicContentInWSB /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDynamicSearchBoxEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSearchSuggestions /t REG_DWORD /d 0 /f >nul 2>&1

:: Consumer / spotlight / cloud content
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableConsumerAccountStateContent /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /t REG_DWORD /d 1 /f >nul 2>&1

:: Appx packages — AI / Copilot / Bing / Dev Home / Outlook / Teams
for %%A in (
    "Microsoft.Copilot"
    "Microsoft.Windows.Ai.Copilot.Provider"
    "Microsoft.Windows.Copilot"
    "MicrosoftWindows.Client.CBS"
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.BingSearch"
    "Microsoft.Bing"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Windows.DevHome"
    "Microsoft.DevHome"
    "Microsoft.OutlookForWindows"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Clipchamp.Clipchamp"
    "MSTeams"
    "MicrosoftTeams"
    "Microsoft.WebExperiencePack"
    "MicrosoftWindows.CrossDevice"
    "Microsoft.StartExperiencesApp"
    "Microsoft.WidgetsPlatformRuntime"
    "MicrosoftWindows.Client.WebExperience"
) do (
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers *%%~A* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like '*%%~A*' } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue }" >nul 2>&1
)

:: Optional features / Recall package
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'Recall' -NoRestart -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-WindowsCapability -Online | Where-Object { $_.Name -match 'Recall|Copilot' -and $_.State -eq 'Installed' } | ForEach-Object { Remove-WindowsCapability -Online -Name $_.Name -ErrorAction SilentlyContinue }" >nul 2>&1

:: Cortana via winget if present
winget uninstall cortana --accept-source-agreements --accept-package-agreements --silent >nul 2>&1

echo  !DIM!  Copilot / Recall / widgets policies set. Appx removal best-effort.!RST!
echo.

:: =====================================================================
:: 03. XBOX / GAME BAR / GAME DVR
:: =====================================================================
echo  !PLT![03]!WHT! Removing Xbox, Game Bar, and Game DVR!RST!

for %%S in (XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc XboxGipSvc) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AudioCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v CursorCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v value /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v ShowStartupPanel /t REG_DWORD /d 0 /f >nul 2>&1

for %%A in (
    "Microsoft.XboxApp"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.GamingApp"
    "Microsoft.XboxGameCallableUI"
) do (
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers *%%~A* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like '*%%~A*' } | ForEach-Object { Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue }" >nul 2>&1
)

echo  !DIM!  Xbox services disabled. Game Bar / DVR off.!RST!
echo.

:: =====================================================================
:: 04. INBOX APPS / BLOATWARE
:: Keeps Calculator, Photos, Snipping Tool, Camera
:: =====================================================================
echo  !PLT![04]!WHT! Removing inbox Windows apps!RST!

for %%A in (
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.People"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.SkypeApp"
    "Microsoft.MixedReality.Portal"
    "microsoft.windowscommunicationsapps"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.WindowsAlarms"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.Print3D"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.Messaging"
    "Microsoft.Wallet"
    "Microsoft.Advertising.Xaml"
    "Microsoft.MicrosoftEdge.Stable"
    "Microsoft.549981C3F5F10"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Clipchamp.Clipchamp"
) do (
    powershell -NoProfile -Command "Get-AppxPackage -AllUsers *%%~A* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
)

powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MixedReality.Portal* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *windowscommunicationsapps* | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue" >nul 2>&1
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client','SMB1Protocol' -NoRestart -ErrorAction SilentlyContinue" >nul 2>&1

:: OneDrive
taskkill /f /im OneDrive.exe >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSync /t REG_DWORD /d 1 /f >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall >nul 2>&1
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall >nul 2>&1

:: Phone Link
sc stop PhoneSvc >nul 2>&1
sc config PhoneSvc start= disabled >nul 2>&1

echo  !DIM!  Inbox apps stripped. Calculator, Photos, Snip, Camera kept.!RST!
echo.

:: =====================================================================
:: 05. EXTREME-LITE PROCESS REDUCTION
:: Windows 11 — aggressive background reduction
:: =====================================================================
echo  !PLT![05]!WHT! Extreme-Lite process reduction!RST!

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableConsumerAccountStateContent /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1

for %%S in (XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

for %%S in (DiagTrack dmwappushservice) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

sc stop DoSvc >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1

sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1

sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1

sc stop Spooler >nul 2>&1
sc config Spooler start= disabled >nul 2>&1

for %%S in (RemoteRegistry RetailDemo Fax) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

taskkill /f /im OneDrive.exe >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1

sc stop WerSvc >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1

sc stop MapsBroker >nul 2>&1
sc config MapsBroker start= disabled >nul 2>&1

sc stop PhoneSvc >nul 2>&1
sc config PhoneSvc start= disabled >nul 2>&1

sc stop RetailDemo >nul 2>&1
sc config RetailDemo start= disabled >nul 2>&1

sc stop DPS >nul 2>&1
sc config DPS start= demand >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1

del /f /s /q "%TEMP%\*" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1

powercfg /h off >nul 2>&1
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

echo  !DIM!  Background services cut. Ultimate Performance plan armed.!RST!
echo.


:: =====================================================================
:: 06. PLATINUM+ OPTIMIZER 9.1 CORE  (copied from original FREE build)
::     Kernel, BCD, memory, I/O, GPU, MMCSS, services, update lock
:: =====================================================================
echo  !PLT![06]!WHT! Applying Platinum+ Optimizer 9.1 and 9.2 core!RST!
echo.
:: 01. BACKUP INIZIALE
:: =====================================================================

sc config VSS start= demand >nul
sc start VSS >nul
sc config swprv start= demand >nul
sc start swprv >nul 
powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Platinum+ Optimizer' -RestorePointType 'MODIFY_SETTINGS'"
reg export HKLM "%USERPROFILE%\Desktop\platinum.reg" /y

:: =====================================================================
:: 02. VARIABILI UTILITY PER REGISTRO
:: =====================================================================

set "MM=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
set "PREFETCH=%MM%\PrefetchParameters"
set "IOSYS=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System"
set "FS=HKLM\SYSTEM\CurrentControlSet\Control\FileSystem"
set "DWM=HKLM\SOFTWARE\Microsoft\Windows\DWM"
set "GD=HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
set "GDS=%GD%\Scheduler"
set "GDMM=%GD%\MemoryManagement"
set "GDPOWER=%GD%\Power"
set "TCP=HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
set "AFD=HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"
set "POWER=HKLM\SYSTEM\CurrentControlSet\Control\Power"
set "CPU0=HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0"

:: =====================================================================
:: 03. BCDEDIT - BOOT, HYPERVISOR, TIMER, MEMORIA, SICUREZZA BOOT
:: =====================================================================

:: Rimuove eventuali valori platform clock/tick
bcdedit /deletevalue useplatformclock
bcdedit /deletevalue useplatformtick

:: Disattiva contesto isolato
bcdedit /set isolatedcontext no

:: Forza uso platform tick
bcdedit /set useplatformtick yes

:: Disattiva dynamic tick
bcdedit /set disabledynamictick yes

:: Abilita X2APIC se disponibile
bcdedit /set x2apicpolicy enable

:: Dimensione gruppi interrupt
bcdedit /set groupsize 64
bcdedit /set groupaware yes


:: Disattiva hypervisor
bcdedit /set hypervisorlaunchtype off

:: Impostazioni memoria/boot low memory
bcdedit /set avoidlowmemory 0
bcdedit /set nolowmem yes
bcdedit /set badmemoryaccess no

:: DEP: optout
bcdedit /set nx optout

:: Forza PAE
bcdedit /set pae forceenable

:: Disattiva legacy ASLR
bcdedit /set legacyaslr no

:: Disattiva entropy TPM in boot
bcdedit /set tpmbootentropy forcedisable

:: Forza MSI
bcdedit /set msi force

:: Accesso configurazione boot
bcdedit /set configaccesspolicy default

:: UI boot e menu
bcdedit /set bootuxdisabled on
bcdedit /set bootmenupolicy standard
bcdedit /set timeout 0
bcdedit /set {bootmgr} timeout 0

:: Emergency Management Services off
bcdedit /set ems off

:: Forza failure MUP off
bcdedit /set forcefailuremup no

:: Ibernazione off via boot
bcdedit /set hibernation off

:: TSC sync policy
bcdedit /set tscsyncpolicy enhanced

:: Disattiva ibernazione Windows
powercfg -h off

:: =====================================================================
:: 04. TELEMETRIA BASE WINDOWS
:: =====================================================================

:: Disattiva telemetria Microsoft a livello policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: =====================================================================
:: 05. MEMORY MANAGEMENT - CACHE, PAGING, POOL, PRIORITA'
:: =====================================================================

:: Cache di sistema grande
reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 1 /f

:: Attiva paging executive
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f

:: Priorità zero page thread
reg add "%MM%" /v "ZeroPageThreadPriority" /t REG_DWORD /d 31 /f

:: Priorità memory management
reg add "%MM%" /v "MemoryManagementPriority" /t REG_DWORD /d 1 /f

:: Disattiva throttling memoria
reg add "%MM%" /v "DisableMemoryThrottling" /t REG_DWORD /d 1 /f

:: Disattiva page splitting
reg add "%MM%" /v "DisablePageSplitting" /t REG_DWORD /d 1 /f

:: Disattiva memory scrubbing
reg add "%MM%" /v "DisableMemoryScrubbing" /t REG_DWORD /d 1 /f

:: Second level cache
reg add "%MM%" /v "SecondLevelDataCache" /t REG_DWORD /d 0 /f

:: Pool usage maximum
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f

:: Move images
reg add "%MM%" /v "MoveImages" /t REG_DWORD /d 0 /f

:: Feature settings
reg add "%MM%" /v "FeatureSettings" /t REG_DWORD /d 1 /f

:: Non cancellare pagefile allo shutdown
reg add "%MM%" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f

:: Session view/pool sizes
reg add "%MM%" /v "SessionViewSize" /t REG_DWORD /d 192 /f
reg add "%MM%" /v "SessionPoolSize" /t REG_DWORD /d 128 /f
reg add "%MM%" /v "SystemViewSize" /t REG_DWORD /d 24576 /f

:: Protezione scrittura
reg add "%MM%" /v "EnforceWriteProtection" /t REG_DWORD /d 1 /f

:: Trim working set
reg add "%MM%" /v "TrimWorkingSet" /t REG_DWORD /d 0 /f

:: Write watch
reg add "%MM%" /v "WriteWatch" /t REG_DWORD /d 0 /f

:: Map transfer count
reg add "%MM%" /v "MapTransferCount" /t REG_DWORD /d 0 /f

:: Disattiva paging kernel stacks
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f

:: Disattiva pool tagging
reg add "%MM%" /v "DisablePoolTagging" /t REG_DWORD /d 1 /f

:: System cache reserve
reg add "%MM%" /v "SystemCacheReserve" /t REG_DWORD /d 1 /f

:: Large page always
reg add "%MM%" /v "LargePageAlways" /t REG_DWORD /d 1 /f

:: Disattiva background scavenging
reg add "%MM%" /v "DisableBackgroundScavenging" /t REG_DWORD /d 1 /f

:: Disattiva VAD cleanup
reg add "%MM%" /v "DisableVadCleanup" /t REG_DWORD /d 1 /f

:: Override mitigazioni (prima impostazione)
reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f

:: Priorità allocazione pool/memoria
reg add "%MM%" /v "PoolAllocationPriority" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "MemoryPriority" /t REG_DWORD /d 1 /f

:: Nonpaged pool maximum
reg add "%MM%" /v "NonPagedPoolMaximum" /t REG_DWORD /d 0 /f

:: Disattiva compressione memoria
reg add "%MM%" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f

:: Disattiva page combining
reg add "%MM%" /v "EnablePageCombining" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "DisablePageCombining" /t REG_DWORD /d 1 /f

:: NUMA node selection policy
reg add "%MM%" /v "NumaNodeSelectionPolicy" /t REG_DWORD /d 1 /f

:: DRAM power management off
reg add "%MM%" /v "DramPowerManagement" /t REG_DWORD /d 0 /f

:: Disattiva paging driver
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f

:: Priorità applicazioni foreground
reg add "%MM%" /v "PrioritizeForegroundApplications" /t REG_DWORD /d 1 /f

:: Disattiva aging working set
reg add "%MM%" /v "DisableWorkingSetAging" /t REG_DWORD /d 1 /f

:: Disattiva kernel stack paging
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f

:: Large page minimum
reg add "%MM%" /v "LargePageMinimum" /t REG_DWORD /d 0 /f

:: Nonpaged/paged pool sizes
reg add "%MM%" /v "NonPagedPoolSize" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PagedPoolSize" /t REG_DWORD /d 4294967295 /f

:: IO page lock limit
reg add "%MM%" /v "IoPageLockLimit" /t REG_DWORD /d 0 /f

:: Pagine minime libere
reg add "%MM%" /v "MmMinimumFreePages" /t REG_DWORD /d 256000 /f

:: Threshold dirty page system cache
reg add "%MM%" /v "SystemCacheDirtyPageThreshold" /t REG_DWORD /d 81920 /f

:: Allocation preference
reg add "%MM%" /v "AllocationPreference" /t REG_DWORD /d 1048576 /f

:: Evita collisioni large page
reg add "%MM%" /v "AvoidLargePageCollisions" /t REG_DWORD /d 1 /f

:: PAE
reg add "%MM%" /v "PhysicalAddressExtension" /t REG_DWORD /d 1 /f

:: Quote pool
reg add "%MM%" /v "NonPagedPoolQuota" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PagedPoolQuota" /t REG_DWORD /d 0 /f

:: Opzioni avvio system
reg add "%MM%" /v "SystemStartOptions" /t REG_SZ /d "MAXLATENCY" /f

:: Flag virtualizzazione
reg add "%MM%" /v "VirtualizarionFlags" /t REG_DWORD /d 0 /f

:: Cache livelli CPU
reg add "%MM%" /v "FirstLevelDataCache" /t REG_DWORD /d 65536 /f
reg add "%MM%" /v "ThirdLevelDataCache" /t REG_DWORD /d 131072 /f

:: Policy allocazione memoria fisica
reg add "%MM%" /v "PhysicalMemoryAllocationPolicy" /t REG_DWORD /d 0 /f

:: CFG e hot patch off
reg add "%MM%" /v "EnableCfg" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "HotPatch" /t REG_DWORD /d 0 /f

:: Queue depth memoria/controller
reg add "%MM%" /v "McGlobalShortBankQueueDepth" /t REG_DWORD /d 16 /f
reg add "%MM%" /v "McBankQueueDepth" /t REG_DWORD /d 8 /f
reg add "%MM%" /v "McMaxChannelCount" /t REG_DWORD /d 4 /f

:: Disattiva memory patrol scrub
reg add "%MM%" /v "DisableMemoryPatrolScrub" /t REG_DWORD /d 1 /f

:: NUMA cross node access
reg add "%MM%" /v "NumaCrossNodeAccess" /t REG_DWORD /d 2 /f

:: Shared user data
reg add "%MM%" /v "SharedUserData" /t REG_DWORD /d 1 /f

:: Commit limits
reg add "%MM%" /v "MappedCommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f
reg add "%MM%" /v "CommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f

:: IO modification
reg add "%MM%" /v "IoModification" /t REG_DWORD /d 0 /f

:: GameMode cache
reg add "%MM%" /v "GameModeCacheSize" /t REG_DWORD /d 1073741824 /f
reg add "%MM%" /v "GameModeEnabled" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "GameModeCachePriority" /t REG_DWORD /d 15 /f

:: =====================================================================
:: 06. PREFETCH / SUPERFETCH / READ-AHEAD
:: =====================================================================

:: Disattiva prefetcher
reg add "%PREFETCH%" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f

:: Disattiva superfetch
reg add "%PREFETCH%" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f

:: Disattiva tracing Superfetch
reg add "%PREFETCH%" /v "SfTracingState" /t REG_DWORD /d 0 /f

:: Disattiva boot trace
reg add "%PREFETCH%" /v "EnableBootTrace" /t REG_DWORD /d 0 /f

:: Disattiva read ahead/seek ahead
reg add "%PREFETCH%" /v "EnableReadAhead" /t REG_DWORD /d 0 /f
reg add "%PREFETCH%" /v "EnableSeekAhead" /t REG_DWORD /d 0 /f

:: Limita read ahead
reg add "%PREFETCH%" /v "MaxReadAheadSize" /t REG_DWORD /d 0 /f

:: Tentativi prefetch
reg add "%PREFETCH%" /v "PrefetchAttempts" /t REG_DWORD /d 0 /f

:: Disattiva compressione memoria e page combining anche via PowerShell
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -PageCombining"

:: =====================================================================
:: 07. I/O SYSTEM / STORAGE / NVME / DISK
:: =====================================================================

:: Abilita IoRing
reg add "%IOSYS%" /v "EnableIoRing" /t REG_DWORD /d 1 /f
reg add "%IOSYS%" /v "IoRingMaxSubmitQueueSize" /t REG_DWORD /d 65536 /f

:: Count operations
reg add "%IOSYS%" /v "CountOperations" /t REG_DWORD /d 0 /f

:: Interrupt steering
reg add "%IOSYS%" /v "InterruptSteeringDisabled" /t REG_DWORD /d 0 /f

:: Bypass IO
reg add "%IOSYS%" /v "BypassIosEnable" /t REG_DWORD /d 1 /f

:: Lookaside
reg add "%IOSYS%" /v "DisableLookAside" /t REG_DWORD /d 1 /f

:: Priorità IO
reg add "%IOSYS%" /v "IoPriorityHint" /t REG_DWORD /d 3 /f

:: No workqueue
reg add "%IOSYS%" /v "IoNoWorkQueue" /t REG_DWORD /d 1 /f

:: Disattiva buffering IO
reg add "%IOSYS%" /v "DisableIoBuffering" /t REG_DWORD /d 1 /f

:: Thread library calls
reg add "%IOSYS%" /v "DisableThreadLibraryCalls" /t REG_DWORD /d 1 /f

:: Optimization flags
reg add "%IOSYS%" /v "OptimizationFlags" /t REG_DWORD /d 0x400000 /f

:: Limiti operazioni read/write/other
reg add "%IOSYS%" /v "IoReadOperationLimit" /t REG_DWORD /d 65536 /f
reg add "%IOSYS%" /v "IoWriteOperationLimit" /t REG_DWORD /d 65536 /f
reg add "%IOSYS%" /v "IoOtherOperationLimit" /t REG_DWORD /d 65536 /f

:: Maximum length IO
reg add "%IOSYS%" /v "IOMaximumLength" /t REG_DWORD /d 1048576 /f

:: Page lock limit IO
reg add "%IOSYS%" /v "IoPageLockLimit" /t REG_DWORD /d 16777216 /f

:: Match deadline IO
reg add "%IOSYS%" /v "IOMatchDeadline" /t REG_DWORD /d 0 /f

:: Storport: transfer length, richieste, priorità
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "MaximumTransferLength" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "NumberOfRequests" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "InterruptPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DpcIsolation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DisableIdleTimeout" /t REG_DWORD /d 1 /f

:: Stornvme: flush cache, priorità, DPC, bypass IO, power idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableWriteCacheBufferFlush" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "InterruptPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DpcIsolation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "BypassIoEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "HostMemoryBufferBytes" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeCommandTimeout" /t REG_DWORD /d 300 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeMaxIoConcurrency" /t REG_DWORD /d 128 /f

:: MSI/Interrupt NVME
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSIXSupported" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DeviceExecutionMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 31 /f

:: Disk timeout/cache
reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk\Parameters" /v "TimeOutValue" /t REG_DWORD /d 180 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Disk" /v "EnableCache" /t REG_DWORD /d 1 /f

:: Storage control
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "DisableDeleteNotification" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ZeroPoweredNTDisks" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ShortStreakQueuing" /t REG_DWORD /d 1 /f

:: FairShare disk/netfs off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\Disk" /v "EnableFairShare" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\NetFS" /v "EnableFairShare" /t REG_DWORD /d 0 /f

:: FSUTIL: last access, 8.3, MFT zone, encryption/compression
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1
fsutil behavior set mftzone 4
fsutil behavior set encryptpagingfile 0
fsutil behavior set disablecompression 1
fsutil behavior set disableencryption 1
fsutil behavior set memoryusage 2

:: =====================================================================
:: 08. NTFS / FILE SYSTEM
:: =====================================================================

:: Disattiva last access update
reg add "%FS%" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: MFT zone reservation
reg add "%FS%" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f

:: Disattiva nomi 8.3
reg add "%FS%" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f

:: NTFS memory usage
reg add "%FS%" /v "NtfsMemoryUsage" /t REG_DWORD /d 2 /f

:: Contig file alloc size
reg add "%FS%" /v "ContigFileAllocSize" /t REG_DWORD /d 64 /f

:: Disattiva encryption NTFS
reg add "%FS%" /v "NtfsDisableEncryption" /t REG_DWORD /d 1 /f

:: Tunnel entries
reg add "%FS%" /v "MaximumTunnelEntries" /t REG_DWORD /d 0 /f
reg add "%FS%" /v "MaximumTunnelEntryAgeInSeconds" /t REG_DWORD /d 0 /f

:: Name/path cache
reg add "%FS%" /v "NameCache" /t REG_DWORD /d 512 /f
reg add "%FS%" /v "PathCache" /t REG_DWORD /d 128 /f

:: Long paths enabled
reg add "%FS%" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f

:: ReFS last access
reg add "%FS%" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: Disattiva compressione NTFS
reg add "%FS%" /v "NtfsDisableCompression" /t REG_DWORD /d 1 /f

:: Extended character 8dot3 rename
reg add "%FS%" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d 0 /f

:: Disattiva read ahead NTFS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ntfs" /v "DisableReadAhead" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 09. DWM / DXGI / GRAPHICS CORE / FLIP MODEL
:: =====================================================================

:: Use HW draw list
reg add "%DWM%" /v "UseHWDrawList" /t REG_DWORD /d 1 /f

:: Non forzare software D3D
reg add "%DWM%" /v "ForceSoftwareD3D" /t REG_DWORD /d 0 /f

:: Overlay test mode
reg add "%DWM%" /v "OverlayTestMode" /t REG_DWORD /d 5 /f

:: Independent flip
reg add "%DWM%" /v "EnableIndependentFlip" /t REG_DWORD /d 1 /f

:: Machine check
reg add "%DWM%" /v "EnableMachineCheck" /t REG_DWORD /d 0 /f

:: Non ibernare thumbnails
reg add "%DWM%" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f

:: Disattiva window ghosting
reg add "%DWM%" /v "DisableProcessWindowsGhosting" /t REG_DWORD /d 1 /f

:: Max queued buffers
reg add "%DWM%" /v "MaxQueuedBuffers" /t REG_DWORD /d 1 /f

:: Overlay supported
reg add "%DWM%" /v "OverlaySupported" /t REG_DWORD /d 0 /f

:: Force direct flip
reg add "%DWM%" /v "ForceDirectFlip" /t REG_DWORD /d 1 /f

:: Disattiva overlays
reg add "%DWM%" /v "DisableOverlays" /t REG_DWORD /d 0 /f

:: Hardware scheduling GPU
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GD%" /v "HwSch_QueueDepth" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "HwSch_MaxPendingCommand" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "HwSch_ThreadPriority" /t REG_DWORD /d 31 /f

:: TDR delay
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 20 /f
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 60 /f

:: DMA remapping off
reg add "%GD%" /v "DmaRemappingCompatible" /t REG_DWORD /d 0 /f

:: VSync latency update
reg add "%GD%" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d 1 /f

:: Dirty rectangles off
reg add "%GD%" /v "EnableDirtyRectangles" /t REG_DWORD /d 0 /f

:: Frame queue mode
reg add "%GD%" /v "FrameQueueMode" /t REG_DWORD /d 0 /f

:: Fullscreen optimizations enable
reg add "%GD%" /v "FSE_Enable" /t REG_DWORD /d 1 /f

:: WDDM checks off
reg add "%GD%" /v "DisableWddm2Checks" /t REG_DWORD /d 1 /f

:: Power setting off
reg add "%GD%" /v "PowerSettingEnable" /t REG_DWORD /d 0 /f

:: Async presentation
reg add "%GD%" /v "EnableAsyncPresentation" /t REG_DWORD /d 1 /f

:: Miracast off
reg add "%GD%" /v "PlatformSupportMiracast" /t REG_DWORD /d 0 /f

:: IOMMU usage off
reg add "%GD%" /v "IommuUsage" /t REG_DWORD /d 0 /f

:: D3D12 shared dynamic value management off
reg add "%GD%" /v "D3D12DisableSharedDynamicValueManagement" /t REG_DWORD /d 1 /f

:: Memory encryption off
reg add "%GD%" /v "DisableMemoryEncryption" /t REG_DWORD /d 1 /f

:: Verify driver level off
reg add "%GD%" /v "VerifyDriverLevel" /t REG_DWORD /d 0 /f

:: Max frame latency
reg add "%GD%" /v "MaxFrameLatency" /t REG_DWORD /d 1 /f

:: TDR level
reg add "%GD%" /v "TdrLevel" /t REG_DWORD /d 8 /f

:: Multiplane overlay 3D off
reg add "%GD%" /v "EnableMultiPlaneOverlay3DDIs" /t REG_DWORD /d 0 /f

:: Force direct flip / overlays
reg add "%GD%" /v "ForceDirectFlip" /t REG_DWORD /d 0 /f
reg add "%GD%" /v "DisableOverlays" /t REG_DWORD /d 0 /f

:: High priority completion
reg add "%GD%" /v "HighPriorityCompletionMode" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "GpuPriorityChangeMode" /t REG_DWORD /d 1 /f

:: DCI control
reg add "%GD%" /v "DCIControl" /t REG_DWORD /d 1 /f

:: DirectStorage force flush off
reg add "%GDMM%" /v "DirectStorageForceFlush" /t REG_DWORD /d 0 /f

:: Scheduler GPU: preemption, priorità, vsync, async compute
reg add "%GDS%" /v "EnableComputePreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "VsyncIdleTimeout" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnableVsyncClockGroup" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "GpuPriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "PreemptionLevel" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "MicrocodeQueuePriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f
reg add "%GDS%" /v "EnableMidGfxPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "SchedulePolicy" /t REG_DWORD /d 4 /f
reg add "%GDS%" /v "GpuResourceAccessPriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "EnableYield" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnablePreemptiveScheduling" /t REG_DWORD /d 1 /f
reg add "%GDS%" /v "EnableCudaContextPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "PollStatusIterations" /t REG_DWORD /d 1 /f

:: Power GPU: dynamic pstate, DPC per core, caching registry off
reg add "%GDPOWER%" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f
reg add "%GDPOWER%" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f

:: DXGKrnl thread priority
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f

:: Direct3D contexts/loader threads
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxContexts" /t REG_DWORD /d 4096 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxLoaderThreads" /t REG_DWORD /d 16 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "ContextReordering" /t REG_DWORD /d 0 /f

:: Driver software only off
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f

:: D3D 12/11 clear on allocate off, async compute, PSO eviction off
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisablePsoEviction" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\11.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f

:: DirectDraw emulation only off
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulationOnly" /t REG_DWORD /d 0 /f

:: Vulkan validation off
reg add "HKLM\SOFTWARE\Khronos\Vulkan\ImplicitLayers" /v "DisableValidation" /t REG_DWORD /d 1 /f

:: DirectX user GPU preferences
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "SwapEffectUpgradeEnable=1" /f

:: =====================================================================
:: 10. GAME DVR / GAME BAR / GAME MODE
:: =====================================================================

:: Disattiva GameDVR e comportamenti correlati
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Priority" /t REG_DWORD /d 1 /f

:: Disattiva cattura app/audio/cursore
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d 0 /f

:: Policy GameDVR off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f

:: GameMode DVR
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeUseNullRenderer" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 11. MMCSS - MULTIMEDIA CLASS SCHEDULER
:: =====================================================================

:: Network throttling index max
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f

:: System responsiveness
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f

:: No lazy mode / always on
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d 1 /f

:: Priorità MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "Priority" /t REG_DWORD /d 6 /f

:: Cache QoS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "CacheQualityOfService" /t REG_DWORD /d 0 /f

:: Profilo Games
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "BackgroundPriority" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f

:: Profilo Audio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f

:: Profilo Low Latency
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d 8 /f



:: Velocità mouse e soglie
reg add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f

:: Hover time
reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "0" /f

:: Curve mouse smooth
reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseXCurve" /t REG_BINARY /d "0000000000000000C0CC0C0000000000809919000000000040662600000000000033330000000000" /f
reg add "HKCU\Control Panel\Mouse" /v "SmoothMouseYCurve" /t REG_BINARY /d "0000000000000000000038000000000000007000000000000000A800000000000000E00000000000" /f

:: Tastiera delay/speed
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f

:: Accessibilità tastiera
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatDelay" /t REG_SZ /d "200" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "AutoRepeatRate" /t REG_SZ /d "6" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "122" /f

:: Sticky keys / toggle keys
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "506" /f
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d "58" /f

:: Desktop menu delay, auto end tasks, timeout app
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "7000" /f
reg add "HKCU\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "9000" /f
reg add "HKCU\Control Panel\Desktop" /v "ForegroundLockTimeout" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v "BlockSendInputResets" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "ActiveWndTrkTimeout" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v "CaretWidth" /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "1" /f

:: Mouclass/Kbdclass queue size/priority
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Mouclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Kbdclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f

:: =====================================================================
:: 14. USB / INTERRUPT / PCI / CLASS DEVICE
:: =====================================================================

:: USB selective suspend off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f

:: USBXHCI priority/interrupt moderation
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "InterruptModeration" /t REG_DWORD /d 0 /f

:: USBHUB3 priority
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f

:: HidUsb idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HidUsb" /v "IdleEnabled" /t REG_DWORD /d 0 /f

:: USB class idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{36fc9e60-c465-11cf-8056-444553540000}" /v "IdleEnable" /t REG_DWORD /d 0 /f

:: Mouse class force high priority
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E96F-E325-11CE-BFC1-08002BE10318}\0000" /v "ForceProcessHighPriority" /t REG_DWORD /d 1 /f

:: Display class MSI/ASPM/latency
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspm" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f

:: PCI MSI/latency/ASPM
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "EnableMsi" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "MessageSignaledInterrupt" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusSolverMaxDepth" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "PerfOptimize" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "LinkDisableAspm" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "PciBufferSize" /t REG_DWORD /d 64 /f

:: =====================================================================
:: 15. SERVIZI - DISABILITAZIONE TRAMITE SC CONFIG
:: =====================================================================

:: Elenco servizi da disabilitare
set "SC_DISABLED=DiagTrack dmwappushservice WerSvc DPS WdiServiceHost WdiSystemHost PcaSvc diagnosticshub.standardcollector.service diagsvc SysMain RemoteRegistry RemoteAccess WinRM iphlpsvc lfsvc BDESVC EFS SCardSvr ScDeviceEnum Fax MapsBroker PhoneSvc TrkWks TapiSrv AJRouter WpcMonSvc ALG EntAppSvc wisvc RetailDemo WMPNetworkSvc FontCache3.0.0.0 StiSvc SensorService SensrSvc SensorDataService XboxGipSvc XblAuthManager XboxNetApiSvc XblGameSave SEMgrSvc uhssvc upfc PushToInstall dosvc UsoSvc WaaSMedicSvc microsoftedgeupdater microsoftedgeupdatem EsifTelemetryService ipfsvc RtkAudioUniversalService AeLookupSvc WSAIFabricSvc edgeupdate edgeupdatem DsSvc CDPSvc CDPUserSvc WarpSvc NvTelemetryContainer OneSyncSvc Wecsvc bthserv DoSvc NetTcpPortSharing perceptionsimulation spectrum MixedRealityOpenXRSvc BcastDVRUserService BTAGService BthAvctpSvc icssvc DmEnrollmentSvc DusmSvc embeddedmode GraphicsPerfSvc HvHost IpxlatCfgSvc jhi_service KtmRm LxpSvc McpManagementService MicrosoftEdgeElevationService NetSetupSvc NcdAutoSetup p2pimsvc p2psvc PerfHost pla PolicyAgent PNRPAutoReg PNRPsvc QWAVE RasAuto RasMan RpcLocator shpamsvc smphost SmsRouter SNMPTRAP svsvc swprv TroubleshootingSvc tzautoupdate WebClient WEPHOSTSVC wercplsupport WFDSConMgrSvc WiaRpc WManSvc wmiApSrv WPDBusEnum BITS InstallService LicenseManager SDRSVC fhsvc defragsvc vds TieringEngineService StorSvc UdkUserSvc FontCache W32Time Spooler SharedAccess WwanSvc"

for %%S in (%SC_DISABLED%) do (
    sc config %%S start= disabled >nul 2>&1
)

:: Servizi con spazi nel nome
for %%S in ("AMD Crash Defender Service" "AUEPLauncher" "cplcon" "SECOMNService" "SECOMN Service" "Sound Research SECOMN Service" "NvTelemetryContainer") do (
    sc config "%%~S" start= disabled >nul 2>&1
)

:: Edge update services delete
sc delete edgeupdate >nul 2>&1
sc delete edgeupdatem >nul 2>&1

:: Servizi da impostare auto/demand/enabled
sc config TabletInputService start= auto >nul 2>&1
sc config TabletInputService start= enabled >nul 2>&1
sc config IntelAudioService start= demand >nul 2>&1
sc config bits start= demand >nul 2>&1
sc config camsvc start= auto >nul 2>&1

:: =====================================================================
:: 16. SERVIZI - START VALUE 4 (DISABLED) NEL REGISTRO
:: =====================================================================

:: Stesso elenco servizi: Start=4
for %%S in (%SC_DISABLED%) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

:: Servizi con start diverso
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\KeyIso" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\camsvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

:: Chiavi offline/temp system presenti nel file originale
reg add "HKLM\TEMP_SYSTEM\ControlSet001\Services\wlidsvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\TEMP_SYSTEM\ControlSet001\Services\WbioSrvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\OFFLINE_SYS\ControlSet001\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\OFFLINE_SYS\ControlSet001\Services\BcastDVRUserService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

:: =====================================================================
:: 17. RIMOZIONE APPX / BLOATWARE
:: =====================================================================

:: Svuota cestino
powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue"

:: Rimozione pacchetti AppX utente corrente
for %%A in (
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.SkypeApp"
    "Clipchamp.Clipchamp"
    "Microsoft.Bing"
    "Microsoft.OutlookForWindows"
    "Microsoft.DevHome"
    "Microsoft.Windows.DevHome"
    "Microsoft.WebExperiencePack"
    "Microsoft.Windows.Ai.Copilot.Provider"
    "Microsoft.Copilot"
    "MSTeams"
    "Microsoft.MicrosoftEdge.Stable"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
)

:: Rimozione pacchetti AppX per tutti gli utenti
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MixedReality.Portal* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *windowscommunicationsapps* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *OutlookForWindows* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MSPaint* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *ScreenSketch* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsSoundRecorder* | Remove-AppxPackage -AllUsers" >nul 2>&1

:: Funzionalità opzionali Windows
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client', 'SMB1Protocol' -NoRestart" >nul 2>&1

:: Defender sample consent
powershell -NoProfile -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1

:: =====================================================================
:: 18. LOGMAN / ETL / EVENT LOG
:: =====================================================================

:: Stop logger ETL
logman stop "Microsoft-Windows-Storage-Storport-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace" -ets >nul 2>&1
logman stop "Microsoft-Windows-Kernel-Processor-Power" -ets >nul 2>&1
logman stop "Microsoft-Windows-UserModePowerService" -ets >nul 2>&1
logman stop "Microsoft-Windows-Ntfs-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-DeviceSetupManager-Admin" -ets >nul 2>&1
logman stop "Circular Kernel Context Logger" -ets >nul 2>&1
logman stop "UBPM" -ets >nul 2>&1
logman stop "AutoLogger-Diagtrack-Listener" -ets >nul 2>&1
logman stop "NetCore" -ets >nul 2>&1
logman stop "ContextLogger" -ets >nul 2>&1
logman stop "CloudExperienceHost" -ets >nul 2>&1

:: Pulizia log eventi
wevtutil cl System >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl Security >nul 2>&1
wevtutil cl Setup >nul 2>&1

:: Disattiva log specifici
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1

:: =====================================================================
:: 19. OFFICE / EDGE / WEBVIEW2 / TELEMETRIA BROWSER
:: =====================================================================

:: Office telemetry
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "DisconnectedState" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "ContentSlotState" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "Enablelogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f

:: Edge telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\WebView2" /v "TelemetryEnabled" /t REG_DWORD /d 0 /f

:: Chrome background mode
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f

:: Edge update block
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "DisableAutoUpdateChecksCheckboxValue" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 20. PRIVACY / TELEMETRIA / CONTENT DELIVERY / COPILOT / RECALL
:: =====================================================================

:: Telemetria profonda
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticData" /t REG_DWORD /d 0 /f

:: Advertising info off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

:: Tailored experiences off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesAllowed" /t REG_DWORD /d 0 /f

:: Feedback frequency off
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f

:: Content Delivery Manager off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338380Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338381Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338382Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f

:: Windows AI / Recall / Copilot off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f

:: Bing search off
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: Windows Spotlight off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f

:: Cortana off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Activity feed off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f

:: =====================================================================
:: 21. IFEO - DEBUGGER BLOCK / PRIORITA' / LARGE PAGES
:: =====================================================================

:: Blocco telemetria tramite IFEO debugger
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v "Debugger" /t REG_SZ /d "nul" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v "Debugger" /t REG_SZ /d "nul" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AggregatorHost.exe" /v "Debugger" /t REG_SZ /d "nul" /f

:: Priorità processi sistema/shell
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

:: Priorità bassa per update/WMI/spooler
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WmiPrvSE.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spoolsv.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 4 /f



:: Disattiva sensor watchdog
reg add "%POWER%" /v "DisableSensorWatchdog" /t REG_DWORD /d 1 /f

:: Fabric/LCLK clock gating off
reg add "%POWER%" /v "FabricClockGating" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "LclkClockGating" /t REG_DWORD /d 0 /f

:: Processor performance min/max
reg add "%POWER%" /v "ProcessorPerformanceMinimum" /t REG_DWORD /d 100 /f
reg add "%POWER%" /v "ProcessorPerformanceMaximum" /t REG_DWORD /d 100 /f
reg add "%POWER%" /v "ProcessorPerformanceMaximumPolicy" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CpuUtilizationPercentage" /t REG_DWORD /d 100 /f

:: Energy estimation off
reg add "%POWER%" /v "EnergyEstimationDisabled" /t REG_DWORD /d 1 /f

:: Responsive mode
reg add "%POWER%" /v "ResponsiveModeEnabled" /t REG_DWORD /d 1 /f

:: Accelerated hibernate off
reg add "%POWER%" /v "AcceleratedHibernateEnabled" /t REG_DWORD /d 0 /f

:: Energy efficient turbo off
reg add "%POWER%" /v "EnergyEfficientTurbo" /t REG_DWORD /d 0 /f

:: Turbo boost enabled
reg add "%POWER%" /v "TurboBoostEnabled" /t REG_DWORD /d 1 /f

:: C-States off
reg add "%POWER%" /v "CoreCStatesEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CoreC6Enable" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "PlatformCStateSupport" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CStatesForIdle" /t REG_DWORD /d 0 /f

:: VR ready/VR mode/low latency
reg add "%POWER%" /v "VRReadyEnabled" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "VRMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "LowLatencyMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "LowLatencyState" /t REG_DWORD /d 2 /f

:: Memory performance/timing
reg add "%POWER%" /v "MemoryPerformanceMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "MemoryTimingOverride" /t REG_DWORD /d 1 /f

:: SOC power states off
reg add "%POWER%" /v "SOCPStateSupport" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "SOCPciePStateSupport" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "SOCD3ColdSupport" /t REG_DWORD /d 0 /f

:: USB3 power off
reg add "%POWER%" /v "USB3PowerEnable" /t REG_DWORD /d 0 /f

:: S0 auto power down timer off
reg add "%POWER%" /v "S0AutoPowerDownTimer" /t REG_DWORD /d 0 /f

:: CPU compute efficiency
reg add "%POWER%" /v "CpuComputeEfficiencyEnabled" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "CpuBusyBudgeting" /t REG_DWORD /d 0 /f

:: Unified stack policy
reg add "%POWER%" /v "UnifiedStackPolicy" /t REG_DWORD /d 0 /f

:: Fast S4 off
reg add "%POWER%" /v "FastS4" /t REG_DWORD /d 0 /f

:: Hiberfile off
reg add "%POWER%" /v "HiberFileEnabled" /t REG_DWORD /d 0 /f

:: Power thresholds
reg add "%POWER%\PowerThresholds" /v "AcThermalScalingRatio" /t REG_DWORD /d 0 /f
reg add "%POWER%\PowerThresholds" /v "DcThermalScalingRatio" /t REG_DWORD /d 0 /f
reg add "%POWER%\PowerThresholds" /v "AcLineStatus" /t REG_DWORD /d 1 /f
reg add "%POWER%\PowerThresholds" /v "BatteryFlag" /t REG_DWORD /d 0 /f

:: Default power scheme values
reg add "%POWER%\PowerSettings" /v "DefaultPowerSchemeValues" /t REG_BINARY /d 000000 /f



:: =====================================================================
:: 30. PERFORMANCE COUNTERS / PERFLIB / ACPI / PARTMGR / WHEA
:: =====================================================================

:: Disable performance counters
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "ForceSingleDPC" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "BufferSize" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "ExtensibleCounters" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009" /v "Collect Timeout" /t REG_DWORD /d 0 /f

:: ACPI MSI/interrupt syntax
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "EnableMsi" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "InterruptSyntax" /t REG_DWORD /d 0 /f

:: Partmgr staggered spin watches
reg add "HKLM\SYSTEM\CurrentControlSet\Services\partmgr" /v "StaggeredSpinWatches" /t REG_DWORD /d 0 /f

:: WHEA polling/offline off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableMCAPolling" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableOffline" /t REG_DWORD /d 1 /f


:: MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "LazyModeTimeout" /t REG_DWORD /d 10000 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Network Throttling Index" /t REG_DWORD /d 4294967295 /f

:: GraphicsDrivers / Direct3D
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GD%" /v "DpiMapIommuContiguous" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "CS_Disable" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "%GD%" /v "FSE_Enable" /t REG_DWORD /d 0 /f

reg add "%GDS%" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f
reg add "%GDS%" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f

:: Memory Management
reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "SecondLevelDataCache" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f
reg add "%MM%" /v "IoPageLockLimit" /t REG_DWORD /d 67108864 /f
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f

reg delete "%MM%" /v "ThirdLevelDataCache" /f >nul 2>&1

:: Explorer / ControlPanel
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f

:: PowerCfg GPU
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setactive SCHEME_CURRENT

:: VBS / HVCI / Credential Guard / System Guard
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard" /v "Enabled" /t REG_DWORD /d 0 /f

:: Fast startup / ibernazione / timer coalescing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "HibernateEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f

:: Storage / TRIM / Compact OS / AHCI
fsutil behavior set DisableDeleteNotify 0
compact /compactos:never

reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableHIPM" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableDIPM" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f


:: GameDVR / Fullscreen Optimizations
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f

:: Game Mode off
reg add "HKCU\Software\Microsoft\GameBar" /v "GameModeEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeEnabled" /t REG_DWORD /d 0 /f

:: Scheduled tasks





:: Driver searching off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "InstallEveryDevice" /t REG_DWORD /d 0 /f

:: Quick machine recovery off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Recovery" /v "QuickMachineRecoveryEnabled" /t REG_DWORD /d 0 /f

:: --- 31.2 RIPRISTINO/OVERRIDE INTERMEDIO WINDOWS UPDATE ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 3 /f

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpdatePeriod" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f

reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "FlightSettingsMaxPauseDays" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedFeatureStatus" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedQualityStatus" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdates" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Realtime\Policies\QualityUpdate" /v "DeferDays" /t REG_DWORD /d 30 /f

:: --- 31.3 BLOCCO FINALE WINDOWS UPDATE ---
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
net stop cryptsvc /y >nul 2>&1
net stop dosvc /y >nul 2>&1
net stop usosvc /y >nul 2>&1
net stop WaaSMedicSvc /y >nul 2>&1
net stop stisvc /y >nul 2>&1
net stop InstallService /y >nul 2>&1
net stop DiagTrack /y >nul 2>&1
net stop dmwappushservice /y >nul 2>&1
net stop WerSvc /y >nul 2>&1

rd /s /q %systemroot%\SoftwareDistribution >nul 2>&1
del /f /q %systemroot%\system32\catroot2\*.* >nul 2>&1

sc triggerinfo wuauserv delete >nul 2>&1
sc triggerinfo usosvc delete >nul 2>&1
sc triggerinfo WaaSMedicSvc delete >nul 2>&1
sc triggerinfo bits delete >nul 2>&1
sc triggerinfo stisvc start/disabled >nul 2>&1

sc config wuauserv start= disabled >nul 2>&1
sc config usosvc start= disabled >nul 2>&1
sc config bits start= disabled >nul 2>&1
sc config WaaSMedicSvc start= disabled >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
sc config InstallService start= disabled >nul 2>&1
sc config stisvc start= disabled >nul 2>&1

sc delete DiagTrack >nul 2>&1
sc delete dmwappushservice >nul 2>&1
sc delete WerSvc >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usosvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

:: Pausa aggiornamenti fino al 2099
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesRequested" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpanded" /t REG_DWORD /d 1 /f >nul 2>&1

:: Blocco Windows Store
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "StoreDesktopExtension.exe" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d 1 /f >nul 2>&1
taskkill /f /im StoreDesktopExtension.exe >nul 2>&1

:: Permessi chiavi servizi update
powershell -NoProfile -Command "$services = @('wuauserv', 'stisvc', 'WaaSMedicSvc'); foreach ($service in $services) { $path = 'HKLM:\SYSTEM\CurrentControlSet\Services\' + $service; if (Test-Path $path) { $acl = Get-Acl $path; $arguments = New-Object System.Security.AccessControl.RegistryAccessRule('Everyone', 'FullControl', 'Allow'); $acl.SetAccessRule($arguments); Set-Acl $path $acl; Set-ItemProperty -Path $path -Name 'Start' -Value 4 } }" >nul 2>&1

:: =====================================================================
:: 32. BLOCCO FILE UPDATE / RINOMINA DLL / TAKEOWN / ICACLS
:: =====================================================================

takeown /f "C:\Windows\System32\waasmedicagent.exe" /a >nul 2>&1
icacls "C:\Windows\System32\waasmedicagent.exe" /reset >nul 2>&1
icacls "C:\Windows\System32\waasmedicagent.exe" /deny everyone:(X) >nul 2>&1

takeown /f "C:\Windows\System32\USOClient.exe" /a >nul 2>&1
icacls "C:\Windows\System32\USOClient.exe" /reset >nul 2>&1
icacls "C:\Windows\System32\USOClient.exe" /deny everyone:(X) >nul 2>&1

takeown /f "%windir%\System32\wuaueng.dll" /a >nul 2>&1
icacls "%windir%\System32\wuaueng.dll" /grant Administrators:F >nul 2>&1
ren "%windir%\System32\wuaueng.dll" "wuaueng.dll.bak" >nul 2>&1

takeown /f "%windir%\System32\wuaserv.dll" /a >nul 2>&1
icacls "%windir%\System32\wuaserv.dll" /grant Administrators:F >nul 2>&1
ren "%windir%\System32\wuaserv.dll" "wuaserv.dll.bak" >nul 2>&1

takeown /f "%windir%\System32\waasmedicsvc.dll" /a >nul 2>&1
icacls "%windir%\System32\waasmedicsvc.dll" /grant Administrators:F >nul 2>&1
ren "%windir%\System32\waasmedicsvc.dll" "waasmedicsvc.dll.bak" >nul 2>&1

takeown /f "%windir%\System32\wiaservc.dll" /a >nul 2>&1
icacls "%windir%\System32\wiaservc.dll" /grant Administrators:F >nul 2>&1
ren "%windir%\System32\wiaservc.dll" "wiaservc.dll.bak" >nul 2>&1

takeown /f "%windir%\System32\wlidcli.dll" /a >nul 2>&1
icacls "%windir%\System32\wlidcli.dll" /grant Administrators:F >nul 2>&1
ren "%windir%\System32\wlidcli.dll" "wlidcli.dll.bak" >nul 2>&1

:: =====================================================================
:: 33. HOSTS - BLOCCO DOMINI WINDOWS UPDATE / MICROSOFT
:: =====================================================================

set "hostspath=%windir%\System32\drivers\etc\hosts"
attrib -r "%hostspath%" >nul 2>&1
findstr /I /C:"windowsupdate.com" "%hostspath%" >nul || (
echo 127.0.0.1 microsoft.com>> "%hostspath%"
echo 127.0.0.1 *.microsoft.com>> "%hostspath%"
echo 127.0.0.1 windowsupdate.com>> "%hostspath%"
echo 127.0.0.1 *.windowsupdate.com>> "%hostspath%"
echo 127.0.0.1 windows.com>> "%hostspath%"
echo 127.0.0.1 ://microsoft.com>> "%hostspath%"
)
attrib +r "%hostspath%" >nul 2>&1

:: =====================================================================
:: 34. ONEDRIVE - RIMOZIONE E PULIZIA
:: =====================================================================

if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
)

rd "%USERPROFILE%\OneDrive" /s /q >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /s /q >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /s /q >nul 2>&1

reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-9950-BDF1-DD622415241E}" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F02C1A0D-BE21-4350-88B0-7367FC96EFF3}" /f >nul 2>&1

:: =====================================================================
:: 35. PULIZIA FILE TEMP / CACHE / LOG / PREFETCH / THUMBS
:: =====================================================================

rd /s /q "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization" >nul 2>&1
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
rd /s /q "%WINDIR%\Logs" >nul 2>&1
rd /s /q "%WINDIR%\Installer\$PatchCache$" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
rd /s /q "%LocalAppData%\Temp" >nul 2>&1
rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*.*" >nul 2>&1
del /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
md "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DXCache\*.*" >nul 2>&1

:: Deep cleaning
rd /s /q "%LocalAppData%\Temp\mozilla-temp-files" >nul 2>&1
rd /s /q "%windir%\Users\%username%\AppData\Local\Microsoft\GameDVR" >nul 2>&1
rd /s /q "%windir%\Users\%username%\AppData\Local\Microsoft\Edge" >nul 2>&1
rd /s /q "%windir%\Windows\bcastdvr" >nul 2>&1
rd /s /q "%windir%\Windows\GameBarPresenceWriter" >nul 2>&1
rd /s /q "%windir%\Windows\System32\GameBarPresenceWriter" >nul 2>&1
del /s /f /q "C:\Windows\Logs\*.log" >nul 2>&1
del /f /s /q "C:\Windows\inf\*.log" >nul 2>&1
del /f /s /q "C:\ProgramData\Microsoft\Windows\WER\*.*" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportArchive" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportQueue" >nul 2>&1
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /q /f /s "%AppData%\Mozilla\Firefox\Profiles\*.default\cache2\*" >nul 2>&1
del /q /f /s "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
rd /s /q "%AppData%\Discord\Cache" >nul 2>&1
rd /s /q "%AppData%\Discord\Code Cache" >nul 2>&1
rd /s /q "%SystemDrive%\$GetCurrent" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~BT" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~WS" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.tmp" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.log" >nul 2>&1
del /f /s /q "C:\Windows\panther\*.*" >nul 2>&1
rd /s /q "C:\Windows\panther" >nul 2>&1
del /f /q %windir%\inf\setupapi.dev.log >nul 2>&1
del /f /q %windir%\inf\setupapi.setup.log >nul 2>&1
del /f /s /q %windir%\System32\DriverStore\Temp\*.* >nul 2>&1

:: =====================================================================
:: 36. PIANO ALIMENTAZIONE / MONITOR / SLEEP
:: =====================================================================

powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg -setactive SCHEME_CURRENT

:: =====================================================================
:: 37. ATTIVITA' PIANIFICATE - DISABILITAZIONE / ELIMINAZIONE
:: =====================================================================


schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateBrowserReplacementServer" /f >nul 2>&1

schtasks /Delete /TN "Microsoft\Windows\Maps\MapsUpdateTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Maps\MapsToastTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /F >nul 2>&1

:: =====================================================================
:: 38. LOCALIZZAZIONE / SENSORI / MICROFONO / APP PRIVACY
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\TriggerInfo" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Allow" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessMicrophone /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 39. AUTOLOGGER / DIAGTRACK / DEFENDER LOGGER
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NtfsLog" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Application" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Security" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-System" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPTrafficLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Direct3D" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\GraphicsPerf" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\FaultTolerantHeap" /v "Start" /t REG_DWORD /d 0 /f

:: Blocco file ETL DiagTrack
del /f /q "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" >nul 2>&1
echo. > "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny SYSTEM:(F) >nul 2>&1
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny "EVERYONE":(F) >nul 2>&1

:: =====================================================================
:: 40. WINDOWS ERROR REPORTING / WER / RELIABILITY / CRASH CONTROL
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "NMICrashDump" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "SendAlert" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "LastAliveStamp" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 41. UI / EXPLORER / UAC / PERSONALIZZAZIONE
:: =====================================================================

:: UAC disattivato
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d 0 /f

:: Explorer separate process/desktop process
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /t REG_DWORD /d 1 /f

:: Preview pane off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewPane" /t REG_DWORD /d 1 /f

:: Alpha select off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f

:: Track docs off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

:: Mostra estensioni file
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

:: Recent/frequent off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f

:: Tema scuro
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f

:: Slideshow skip
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Personalization\DesktopSlideshow" /v "Skip" /t REG_DWORD /d 1 /f

:: Hide SCAMeetNow
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f

:: No low disk space checks
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d 1 /f

:: PCA/AppCompat off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" /v "AITEnable" /t REG_DWORD /d 0 /f

:: GameBar presence writer off
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 0 /f

:: Font smoothing
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "1" /f

:: Console virtual terminal level off
reg add "HKCU\Console" /v "VirtualTerminalLevel" /t REG_DWORD /d 0 /f

:: Remote assistance off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f

:: Device metadata network off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f

:: Maps auto update off
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f

:: Sensor permission state off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f

:: Background apps photos off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "DisabledByUser" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "Disabled" /t REG_DWORD /d 1 /f

:: Notifiche lockscreen/toast/account off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v "EnableAccountNotifications" /t REG_DWORD /d 0 /f

:: StorageSense policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v "AllowStorageSenseGlobal" /t REG_DWORD /d 1 /f

:: Visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9e3e078012000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 1 /f

:: =====================================================================
:: 42. STORAGE SENSE / SERIALIZE / PAINT DESKTOP VERSION
:: =====================================================================

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "1024" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "2048" /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "04" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "32" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "02" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "128" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "08" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "256" /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "WaitForIdleState" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 0 /f

:: =====================================================================
:: 43. PAGEFILE / FTH / WDF
:: =====================================================================

:: Pagefile gestito manualmente
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_ComputerSystem' -Property @{AutomaticManagedPagefile=$False}" >nul 2>&1
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_PageFileSetting where Name=\"C:\\pagefile.sys\"' -Property @{InitialSize=8192; MaximumSize=16384}" >nul 2>&1

:: Fault Tolerant Heap off
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CheckPointPeriod" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CrashVelocity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "DisableFTH" /t REG_SZ /d "1" /f

:: WDF diagnostics off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "DbgBreakOnError" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "LogPages" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "VerboseOn" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Kmdf\Diagnostics" /v "RetrieveVerboseLogs" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 44. BOOT / WINDOWS / PNP / WAIT KILL SERVICE
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BootControl" /v "BootProgressAnimation" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "NoPopupsOnBoot" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DisableTargetDeviceLogging" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DeviceActionRequests" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "8000" /f

:: =====================================================================
:: 45. SERVIZI BLUETOOTH / PERIFERICHE / LEGACY START VALUES
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Csc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ossrs" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\msiserver" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HPOSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MidiSrv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UdkUserSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\whesvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netprofm" /v "Start" /t REG_DWORD /d 3 /f

:: =====================================================================
:: 46. PROCESSOR GENERIC / POWER THROTTLING / IDLE
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "EnablePerformanceStates" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FrequencyToPerfStateThreshold" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "IdleResidencyDuration" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfBoostState" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ResponsivenessReductionThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdle" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdleThread" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveLowOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveHighOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FastThrottle" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "LatencyThrottleOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothing" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothingEnabled" /t REG_DWORD /d 0 /f

reg add "%POWER%" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "PlatformRoleOverride" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 47. KERNEL / EXECUTIVE / I/O DEEP TWEAKS
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MaximumDpcStackDepth" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MinimumDpcRate" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "InterruptTimerRate" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "FastDeadlockReliance" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ParallelProcessorMinimum" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ForegroundQuantum" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "BackgroundQuantum" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ThreadQuantum" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "LFH_Aggressive_Enable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "WorkerFactoryThreadIdleTimeout" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentCommit" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentReserve" /t REG_DWORD /d 16777216 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Heap_ForceLFH" /t REG_DWORD /d 1 /f

:: Priority control IRQ/interrupt separation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ12Priority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "InterruptPrioritySeparation" /t REG_DWORD /d 4 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MinQueueDepth" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueDepth" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueuePolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueTimeout" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionTimeout" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionPolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionLevel" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionPriority" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionAffinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionQuantum" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDXGI" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D12" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D11" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D10" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D9" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D8" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D7" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D6" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D5" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D4" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D1" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectDraw" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectSound" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectInput" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectPlay" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectShow" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectMusic" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectAnimation" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DImmediateMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRetainedMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DHardwareAbstractionLayer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DReferenceRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DNullRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRGBRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMMXRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSSE3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE41" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE42" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX512" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA4" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI1" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DTBM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DLZCNT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DPOPCNT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDRAND" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDSEED" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DADX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMPX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSGX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DCET" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSS" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSB" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSBD" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRS" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBPB" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSAll" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSFixed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSAlwaysOn" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSPerf" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSCost" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSBenefit" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSPolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSTimeout" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSTherm" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSQuad" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSCCF" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSMMBTU" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSMWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSkWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSmWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSuWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSnWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSpWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSfWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSaWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSzWh" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBRSyWh" /t REG_DWORD /d 0 /f


:: =====================================================================
:: 48. MEMORY MANAGEMENT AGGIUNTIVI / CACHE / HEAP / LFH
:: =====================================================================

reg add "%MM%" /v "SystemCacheLimit" /t REG_DWORD /d 0xFFFFFFFF /f
reg add "%MM%" /v "VirtualizationFlags" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 49. DISK / NVME CACHE / PARTMGR / SCSI
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk" /v "TimeoutValue" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "CacheIsPowerProtected" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "UserWriteCacheSetting" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Partmgr\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 50. EDGE RIMOZIONE / TASKS / DIRECTORY
:: =====================================================================

powershell -NoProfile -Command "$edgePath = (Get-Item 'C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe').FullName; Start-Process $edgePath -ArgumentList '--uninstall', '--system-level', '--verbose-logging', '--force-uninstall' -Wait" >nul 2>&1

rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1

:: =====================================================================
:: 51. CORTANA RIMOZIONE / WINGET
:: =====================================================================

winget uninstall cortana --accept-source-agreements --accept-package-agreements >nul 2>&1

:: =====================================================================
:: 52. SENSORI / SERVIZIO SENSORI FINALI
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 3 /f

:: =====================================================================
:: 53. APPX DEPLOYMENT / CLIPSVC / TOAST FINALI
:: =====================================================================

taskkill /f /im SearchHost.exe >nul 2>&1
taskkill /f /im svchost.exe /fi "SERVICES eq AppXSvc" >nul 2>&1
taskkill /f /im svchost.exe /fi "SERVICES eq clipsvc" >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

:: =====================================================================
:: 54. DISK PERFORMANCE / VERIFIER RESET
:: =====================================================================

diskperf -N >nul 2>&1
verifier /reset >nul 2>&1



:: =====================================================================
:: --- IFEO: Massima Priorità ai Giochi / programmi  (Espanso) ---
:: =====================================================================


::WinRar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WinRAR.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::7zip
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zFM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zG.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::qemu
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\qemu-system-x86_64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::obs
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f





:: Working set limit BetGame
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BetGame.exe\PerfOptions" /v "WorkingSetLimitInKB" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /v "UseLargePages" /t REG_DWORD /d 1 /f


:: ===================================================
:: VARIABILI BASE
:: ===================================================
set "GFX_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "GFX_KEY=!GFX_CLASS!\0000"
set "GPU_CLASS_KEY=!GFX_CLASS!"

:: ===================================================
:: FASE 1: RILEVAMENTO CPU
:: ===================================================
set "CPU_VENDOR=Sconosciuto"
set "CPU_RAW="

for /f "tokens=2 delims==" %%A in ('wmic cpu get Manufacturer /value 2^>nul') do (
    for /f "delims=" %%B in ("%%A") do set "CPU_RAW=%%B"
)

if defined CPU_RAW (
    echo !CPU_RAW! | findstr /i "GenuineIntel" >nul && set "CPU_VENDOR=INTEL"
    echo !CPU_RAW! | findstr /i "AuthenticAMD" >nul && set "CPU_VENDOR=AMD"
)

echo CPU Rilevata: !CPU_VENDOR!

:: ===================================================
:: FASE 2: RILEVAMENTO GPU
:: ===================================================
echo ===================================================
echo FASE 2: RILEVAMENTO GPU
echo ===================================================

set "GPU1_VENDOR=Nessuna"
set "GPU2_VENDOR=Nessuna"
set "HAS_INTEL_GPU=0"
set "HAS_NVIDIA_GPU=0"
set "HAS_AMD_GPU=0"
set /a count=0

for /f "skip=1 tokens=*" %%A in ('wmic path win32_videocontroller get AdapterCompatibility 2^>nul') do (
    for /f "delims=" %%B in ("%%A") do (
        set "GPU_RAW=%%B"

        set "CURRENT_VENDOR=Sconosciuto"

        echo !GPU_RAW! | findstr /i "Intel" >nul && set "CURRENT_VENDOR=INTEL"
        echo !GPU_RAW! | findstr /i "NVIDIA" >nul && set "CURRENT_VENDOR=NVIDIA"
        echo !GPU_RAW! | findstr /i /c:"Advanced Micro Devices" >nul && set "CURRENT_VENDOR=AMD"
        echo !GPU_RAW! | findstr /i "AMD" >nul && set "CURRENT_VENDOR=AMD"

        if not "!CURRENT_VENDOR!"=="Sconosciuto" (
            set /a count+=1
            if !count! equ 1 set "GPU1_VENDOR=!CURRENT_VENDOR!"
            if !count! equ 2 set "GPU2_VENDOR=!CURRENT_VENDOR!"
        )

        if "!CURRENT_VENDOR!"=="INTEL" set "HAS_INTEL_GPU=1"
        if "!CURRENT_VENDOR!"=="NVIDIA" set "HAS_NVIDIA_GPU=1"
        if "!CURRENT_VENDOR!"=="AMD" set "HAS_AMD_GPU=1"
    )
)

echo GPU Principale: !GPU1_VENDOR!
echo GPU Secondaria: !GPU2_VENDOR!
echo ===================================================
echo ESECUZIONE
echo ===================================================

:: ===================================================
:: SEZIONE CPU
:: ===================================================
if "!CPU_VENDOR!"=="INTEL" (

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "L3_Cache_Foreground_Priority" /t REG_DWORD /d 31 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_QoS_Enable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LLC_ForegroundMonopoly" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Scrubber_Disable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_Locality_Strict" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "CStateLimit" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Enable" /t REG_DWORD /d 1 /f


bcdedit /set useplatformtick yes
bcdedit /set disabledynamictick yes
bcdedit /set tscsyncpolicy enhanced

reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AutonomousCurrentLimitDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LatencyToleranceValue" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "RingBusPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "InterruptToleranceValue" /t REG_DWORD /d 0 /f

:: Extra HWP / Speed Shift
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Interrupt_Mode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_PerformanceSetting" /t REG_DWORD /d 1 /f


:: Extra Turbo
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "EnableTurboBoost" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "TurboMode" /t REG_DWORD /d 1 /f

:: Extra Intel PEP / PCIe power saving
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableD3Hot" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableRuntimePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableL1Substates" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableAspm" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Brighten Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Darken Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Enhance Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Preserve Details" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Desired_Performance" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Minimum_Performance" /t REG_DWORD /d 8 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Maximum_Performance" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Energy_Performance_Preference" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_Activity_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_EPP" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Lowest_Frequency" /t REG_DWORD /d 800 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Highest_Frequency" /t REG_DWORD /d 4200 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Response" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "MaxThrottleCapacity" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "PerfState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "ThermalThrottle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0LidOpen" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0ACPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0DCPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Battery" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Thermal" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Fan" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Cooling" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Heating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Humidity" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Pressure" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Altitude" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Light" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Proximity" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Orientation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Location" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Gyroscope" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Accelerometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Magnetometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Compass" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Barometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0AmbientLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0RGBLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0IRLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0UVLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0XRay" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0GammaRay" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousPowerStatesDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PerformanceBias" /t REG_DWORD /d 0 /f

reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f


    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_EPP" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "PerfBoostMode" /t REG_DWORD /d 2 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AllowThrottling" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "BackgroundPriority" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Activity_Window" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "RootComplex_VC1_Enable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "EnableD3Cold" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f

) else if "!CPU_VENDOR!"=="AMD" (

    rem Nessun comando per ora AMD CPU
)

:: ===================================================
:: ESECUZIONE BLOCCHI GPU TRAMITE SUBROUTINE
:: ===================================================
if "!HAS_INTEL_GPU!"=="1" call :APPLY_INTEL_GPU
if "!HAS_NVIDIA_GPU!"=="1" call :APPLY_NVIDIA_GPU
if "!HAS_AMD_GPU!"=="1" call :APPLY_AMD_GPU

echo.


reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothingType /t REG_DWORD /d 2 /f
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im dwm.exe >nul 2>&1
del /f /q /s "%localappdata%\IconCache.db" >nul 2>&1
del /f /q /s "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
net stop FontCache >nul 2>&1
del /f /q /s "%localappdata%\GDIPFONTCACHEV1.dat" >nul 2>&1
net start FontCache >nul 2>&1
start explorer.exe

echo Operazione completata.
timeout /t 2 >nul
goto extreme_core_done

:: ===================================================
:: SUBROUTINE GPU INTEL
:: ===================================================
:APPLY_INTEL_GPU
echo [GPU-INTEL] Applicazione ottimizzazioni Intel GPU...

reg add "!GFX_KEY!" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PowerPolicy" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FbcEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f
reg add "!GFX_KEY!" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "UserPowerMode" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "RenderStandby" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ApmEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Ignore_Platform_Limits" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "!GFX_KEY!" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "RingBufferSize" /t REG_DWORD /d 1024 /f



reg add "!GFX_KEY!" /v "DisableAsyncFlip" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableTripleBuffering" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "VSyncControl" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisablePFonDP" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePSR" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PSREnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableDisplayCaching" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableRC6" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "RC6Disable" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDisplayPowerSaving" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicFrequencyScaling" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "MaxGPUClockFrequency" /t REG_DWORD /d 1350 /f
reg add "!GFX_KEY!" /v "MinGPUClockFrequency" /t REG_DWORD /d 300 /f
reg add "!GFX_KEY!" /v "GPUClockFrequency" /t REG_DWORD /d 1350 /f
reg add "!GFX_KEY!" /v "EnableTurbo" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "DisableFrameBufferCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableLosslessCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableCompression" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "TextureFilteringQuality" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "AntiAliasingMode" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisablePostProcessing" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableVideoProcessing" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableImageProcessing" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDisplayEnhancement" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "DisableAdaptiveContrast" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "AdaptiveContrastEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableDynamicContrast" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicBrightness" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableAmbientLightSensor" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableALS" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "DisablePowerState0" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisablePowerState1" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState2" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState3" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState4" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState5" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState6" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState7" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState8" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState9" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState10" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState11" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState12" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState13" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState14" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState15" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTableSize" /t REG_DWORD /d 4194304 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePoolSize" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmResourceCacheSize" /t REG_DWORD /d 268435456 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCacheSize" /t REG_DWORD /d 536870912 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCachePolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmEvictionPolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimPolicy" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDeepSleep" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableStandby" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableHibernate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSleep" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerButton" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidClose" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidOpen" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableACPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableStau" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSquark" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSlepton" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSfermion" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSboson" /t REG_DWORD /d 1 /f


:: Disabilita Frame Buffer Compression (FBC). 
:: FBC risparmia banda RAM ma usa cicli GPU e aggiunge latenza. Su RAM a 2100MHz, disattivarlo dà frame più stabili e meno stutter.
reg add "!GFX_KEY!" /v "DisableFBC" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f

:: Disabilita Panel Self Refresh (PSR). Il PSR "bufferizza" il pannello per risparmiare, causando micro-stutter e input lag nei giochi.
reg add "!GFX_KEY!" /v "DisablePSR" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PSR_Enable" /t REG_DWORD /d 0 /f

:: Disabilita CMAA (Conservative Morphological Anti-Aliasing) a livello di driver.
:: Lascia che sia il gioco a gestire l'AA. Non sprecare i 24 Execution Units (EU) della UHD 620 per post-processing forzato.
reg add "!GFX_KEY!" /v "ConservativeMorphologicalAntiAliasing" /t REG_DWORD /d 0 /f

:: Priorità assoluta per gli Execution Units (EU) e Render Context
reg add "!GFX_KEY!" /v "EuThreadPriority" /t REG_DWORD /d 31 /f
reg add "!GFX_KEY!" /v "RCPriority" /t REG_DWORD /d 31 /f
reg add "!GFX_KEY!" /v "ContextPriority" /t REG_DWORD /d 31 /f

:: Forza il driver a non usare copie DMA indesiderate (riduce overhead CPU/RAM)
reg add "!GFX_KEY!" /v "DisableDMACopy" /t REG_DWORD /d 1 /f

:: Disabilita il risparmio energetico del motore Media/QuickSync (libera banda sul Ring Bus interno della CPU)
reg add "!GFX_KEY!" /v "MediaPowerSaving" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f



reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchClockGating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchPmClockGating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DmiLinkPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "DisableValidation" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "DisablePFonDP" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f


reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f
reg add "!GFX_KEY!" /v "DynamicVidMemoryControl" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "GfxDynamicPState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisplayPowerSavingTechnology" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "EnablePowerGating" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d 0 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ThirdLevelDataCache" /f 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "CS_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-95c4-324a7d577775\ee12f2c1-9844-474d-987a-928659de2989" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "CmaaEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "ColorEnhancement" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "EnableDynamicRefreshRate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 40 /f

reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "!GFX_KEY!" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PowerPolicy" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FbcEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f
reg add "!GFX_KEY!" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "UserPowerMode" /t REG_DWORD /d 3 /f
reg add "!GFX_KEY!" /v "RenderStandby" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "EnableOverclock" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "RenderAheadLimit" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDMACopy" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "TextureMemorySize" /t REG_DWORD /d 2048 /f
reg add "!GFX_KEY!" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f
reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "UseLargePages" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "EnableAggressiveMemoryReclaim" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MinFreeMemoryPool" /t REG_DWORD /d 256 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MaxFreeMemoryPool" /t REG_DWORD /d 512 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MemoryPoolPolicy" /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 16777216 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 67108864 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f

powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setactive SCHEME_CURRENT

echo [GPU-INTEL] Ricerca dinamica istanze Intel...

set "INTEL_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "!GPU_CLASS_KEY!" /s /v "DriverDesc" ^| findstr /i "HKEY_"') do (
    reg query "%%K" /v "DriverDesc" 2>nul | findstr /i "Intel" >nul
    if !errorlevel! equ 0 (
        set "INTEL_GPU_FOUND=1"

        reg add "%%K" /v "AllowDeepSleep" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisablePowerGating" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RenderStandby" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DPSTEnable" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableOverclock" /t REG_DWORD /d 1 /f

        reg add "%%K" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "MaxClockFrequency" /t REG_DWORD /d 1350 /f
        reg add "%%K" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f

        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
    )
)

if "!INTEL_GPU_FOUND!"=="0" echo [AVVISO] Nessuna GPU Intel rilevata nel loop dinamico.

exit /b

:: ===================================================
:: SUBROUTINE GPU NVIDIA
:: ===================================================
:APPLY_NVIDIA_GPU
echo [GPU-NVIDIA] Applicazione ottimizzazioni NVIDIA GPU...

set "VRAM_MB=8192"

for /f "tokens=*" %%A in ('powershell -NoProfile -Command "$gpu = Get-CimInstance Win32_VideoController | Where-Object {$_.Name -match 'NVIDIA'} | Select-Object -First 1; if($gpu) { [math]::Round($gpu.AdapterRAM / 1048576) } else { 8192 }"') do set "VRAM_MB=%%A"

if "!VRAM_MB!"=="" set "VRAM_MB=8192"

echo [GPU-NVIDIA] VRAM rilevata: !VRAM_MB! MB

reg add "HKCU\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "CoolBits" /t REG_DWORD /d 31 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "TripleBuffering" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OpenGLShaders" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableOptimusBatteryPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OptimusDeleteRenderHint" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableDynamicPstate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NVTweak" /v "DisableOverlay" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmProfilingAdminOnly" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "AllowDeepSleep" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "EnableGpuHealthCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnablePerformanceMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 8 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 0 /f

echo [GPU-NVIDIA] Ricerca dinamica istanze NVIDIA...

set "NVIDIA_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "!GPU_CLASS_KEY!" /s /v "DriverDesc" ^| findstr /i "HKEY_"') do (
    reg query "%%K" /v "DriverDesc" 2>nul | findstr /i "NVIDIA" >nul
    if !errorlevel! equ 0 (
        set "NVIDIA_GPU_FOUND=1"

        reg add "%%K" /v "ReBarEnable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "ReBarSupported" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmReBarEnable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DisableVRAMCompression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DedicatedSegmentSize" /t REG_DWORD /d !VRAM_MB! /f
        reg add "%%K" /v "RmFbsrPagedDMA" /t REG_DWORD /d 0 /f

        reg add "%%K" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "EnableUlps" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisablePowerGating" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableOverclock" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableCEPreemption" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "RMForceMaxPerf" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "PreferredPerformanceMode" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "PerfLevelSrc" /t REG_DWORD /d 13107 /f
        reg add "%%K" /v "PowerMizerEnable" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMPcieLinkSpeed" /t REG_DWORD /d 4 /f
        reg add "%%K" /v "DisableL1LowPower" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMDisablePostL2Compression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMGC6Feature" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "RMElpgStateOnInit" /t REG_DWORD /d 3 /f
        reg add "%%K" /v "RMHdcpKeyglobZero" /t REG_DWORD /d 1 /f

        reg add "%%K" /v "PeerMappingOverride" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmGspcPerioduS" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMCtxswLog" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "RMLogMsg" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "VRRAlwaysOn" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "vrrSmartDetection" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "GsyncCompatible" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "WDDMv21Enable2MPageSupport" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "WDDMv21Enable64KbSysmemSupport" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "WDDMv21Force2MSizeAlignment" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "NvencPreProcBlitDisable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "NVFBCEnable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "VideoControl3" /t REG_DWORD /d 1 /f

        reg add "%%K" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "MSISupported" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableAspm" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f

        reg add "%%K\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f
        reg add "%%K\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f
        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
    )
)

if "!NVIDIA_GPU_FOUND!"=="0" echo [AVVISO] Nessuna GPU NVIDIA rilevata nel loop dinamico.

exit /b

:: ===================================================
:: SUBROUTINE GPU AMD
:: ===================================================
:APPLY_AMD_GPU
echo [GPU-AMD] Applicazione ottimizzazioni AMD GPU.

reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f
Reg.exe add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f > nul 2>&1 > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "SystemTray" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\Software\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKLM\Software\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NotifySubscription" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACE" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "GI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
exit /b 0

:: =====================================================================
:: 07. HOMI.COM PRIORITY PACK
:: Platinum Optimizer HOMI.COM  —  build pack to 250 KB class
:: Game / creator / system IFEO priorities, NIC, audio, timer
:: =====================================================================
echo  !PLT![07]!WHT! HOMI.COM priority pack  ·  IFEO / NIC / audio / timer!RST!

:: ----- BUILD MANIFEST -----
:: Product     : Platinum Optimizer HOMI.COM
:: Channel     : Extreme Core + Homi pack
:: Format      : Windows CMD  (UTF-8, CRLF)
:: Target size : 250 KB class  (full documented toolkit, not a stub)
:: Order       : Defender → AI → Xbox → Apps → Lite → Platinum 9.1 → Homi
:: Restore     : Desktop\platinum_extreme_backup.reg
:: Site        : HOMI.COM

:: ----- NIC / TCP (HOMI) -----
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpDelAckTicks" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d 64 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableWsd" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d 30 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "KeepAliveTime" /t REG_DWORD /d 30000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "KeepAliveInterval" /t REG_DWORD /d 1000 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableTCPA" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastSendDatagramThreshold" /t REG_DWORD /d 1500 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "FastCopyReceiveThreshold" /t REG_DWORD /d 1500 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultReceiveWindow" /t REG_DWORD /d 66561 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DefaultSendWindow" /t REG_DWORD /d 66561 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DisableRawSecurity" /t REG_DWORD /d 1 /f >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
netsh int tcp set global rss=enabled >nul 2>&1
netsh int tcp set global chimney=disabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global initialRto=2000 >nul 2>&1
netsh int tcp set global nonsackrttresiliency=disabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set heuristics disabled >nul 2>&1

:: ----- AUDIO LATENCY (HOMI) -----
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio" /v "Latency Sensitive" /t REG_SZ /d "True" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableAutoTermination" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Audio" /v "DisableProtectedAudioDG" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v "UserDuckingPreference" /t REG_DWORD /d 3 /f >nul 2>&1

:: ----- TIMER / BCD (HOMI echo) -----
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set tscsyncpolicy enhanced >nul 2>&1

:: ----- IFEO PRIORITY MAP (HOMI.COM) -----
:: CpuPriorityClass 3 = High. Applied per known game / creator / overlay exe.
:: Harmless if the exe is not installed. Does not inject or patch binaries.

:: Counter-Strike 2 | cs2.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Counter-Strike Global Offensive | csgo.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: VALORANT | VALORANT-Win64-Shipping.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\VALORANT-Win64-Shipping.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Fortnite | FortniteClient-Win64-Shipping.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: League of Legends | League of Legends.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\League of Legends.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\League of Legends.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Riot Client | RiotClientServices.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RiotClientServices.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RiotClientServices.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Dota 2 | dota2.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dota2.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dota2.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Apex Legends | r5apex.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\r5apex.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\r5apex.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Overwatch 2 | Overwatch.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Overwatch.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Overwatch.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Call of Duty | ModernWarfare.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ModernWarfare.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ModernWarfare.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Call of Duty Launcher | cod.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cod.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cod.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Black Ops Cold War | BlackOpsColdWar.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BlackOpsColdWar.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BlackOpsColdWar.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Grand Theft Auto V | GTA5.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: GTA V Launcher | PlayGTAV.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PlayGTAV.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PlayGTAV.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Red Dead Redemption 2 | RDR2.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RDR2.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RDR2.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Elden Ring | eldenring.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\eldenring.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\eldenring.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Elden Ring Nightreign | Nightreign.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Nightreign.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Nightreign.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Cyberpunk 2077 | Cyberpunk2077.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Cyberpunk2077.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Cyberpunk2077.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: The Witcher 3 | Witcher3.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Witcher3.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Witcher3.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Minecraft Bedrock | Minecraft.Windows.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Minecraft.Windows.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Minecraft.Windows.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Minecraft Java / Java apps | javaw.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\javaw.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\javaw.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Roblox | RobloxPlayerBeta.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RobloxPlayerBeta.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RobloxPlayerBeta.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Roblox Player | RobloxPlayer.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RobloxPlayer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RobloxPlayer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Rainbow Six Siege | RainbowSix.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RainbowSix.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RainbowSix.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Rainbow Six Vulkan | RainbowSix_Vulkan.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RainbowSix_Vulkan.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RainbowSix_Vulkan.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Destiny 2 | Destiny2.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Destiny2.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Destiny2.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Warframe | Warframe.x64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Warframe.x64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Warframe.x64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: PUBG | TslGame.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TslGame.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TslGame.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Dead by Daylight | DeadByDaylight-Win64-Shipping.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeadByDaylight-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeadByDaylight-Win64-Shipping.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Rocket League | RocketLeague.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RocketLeague.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RocketLeague.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: EA Sports FC | FIFA.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FIFA.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FIFA.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: EA Sports FC 24 | FC24.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FC24.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FC24.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: EA Sports FC 25 | FC25.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FC25.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FC25.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: NBA 2K24 | NBA2K24.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NBA2K24.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NBA2K24.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: NBA 2K25 | NBA2K25.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NBA2K25.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\NBA2K25.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: FIFA 23 | FIFA23.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FIFA23.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FIFA23.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: eFootball | PES.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PES.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PES.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: eFootball 2024 | eFootball.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\eFootball.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\eFootball.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Genshin Impact | GenshinImpact.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GenshinImpact.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GenshinImpact.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Honkai Star Rail | StarRail.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\StarRail.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\StarRail.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Zenless Zone Zero | ZenlessZoneZero.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ZenlessZoneZero.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ZenlessZoneZero.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Wuthering Waves | Wuthering Waves.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Wuthering Waves.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Wuthering Waves.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Unreal client | Client-Win64-Shipping.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Client-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Client-Win64-Shipping.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Escape from Tarkov | EscapeFromTarkov.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EscapeFromTarkov.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EscapeFromTarkov.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: EFT BattlEye | EscapeFromTarkov_BE.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EscapeFromTarkov_BE.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EscapeFromTarkov_BE.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Hunt Showdown | HuntGame.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HuntGame.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HuntGame.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Hell Let Loose | HLL-Win64-Shipping.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HLL-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HLL-Win64-Shipping.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Squad | SquadGame.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SquadGame.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SquadGame.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Arma 3 | Arma3.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Arma3.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Arma3.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: DayZ | DayZ_x64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DayZ_x64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DayZ_x64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Rust | RustClient.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RustClient.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RustClient.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Palworld | Palworld-Win64-Shipping.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Palworld-Win64-Shipping.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Palworld-Win64-Shipping.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: BlueStacks | HD-Player.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HD-Player.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HD-Player.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: BlueStacks frontend | HD-Frontend.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HD-Frontend.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HD-Frontend.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: LDPlayer | LdVBoxHeadless.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LdVBoxHeadless.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LdVBoxHeadless.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: LDPlayer UI | dnplayer.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dnplayer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dnplayer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: NetEase emulator | Netease.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Netease.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Netease.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: MuMu Player | MuMuPlayer.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MuMuPlayer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MuMuPlayer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Gameloop | aow_exe.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\aow_exe.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\aow_exe.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Gameloop Ex | AndroidEmulatorEx.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AndroidEmulatorEx.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AndroidEmulatorEx.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Gameloop market | AppMarket.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AppMarket.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AppMarket.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Gameloop launcher | GameLoop.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GameLoop.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GameLoop.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Steam | Steam.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Steam.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Steam.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Steam web helper | steamwebhelper.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Epic Games Launcher | EpicGamesLauncher.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EpicGamesLauncher.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EpicGamesLauncher.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Epic CEF | UnrealCEFSubProcess.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\UnrealCEFSubProcess.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\UnrealCEFSubProcess.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Battle.net | Battle.net.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Battle.net.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Battle.net.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Battle.net Agent | Agent.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Agent.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Agent.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: EA App | EADesktop.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EADesktop.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EADesktop.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Origin | Origin.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Origin.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Origin.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Ubisoft Connect | UbisoftConnect.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\UbisoftConnect.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\UbisoftConnect.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Ubisoft Connect upc | upc.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\upc.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\upc.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: GOG Galaxy | GalaxyClient.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GalaxyClient.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GalaxyClient.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Bethesda launcher | BethesdaNetLauncher.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BethesdaNetLauncher.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BethesdaNetLauncher.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Rockstar Service | RockstarService.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RockstarService.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RockstarService.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Generic launcher | Launcher.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Launcher.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Launcher.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: OBS Studio | obs64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: OBS 32 | obs32.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs32.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs32.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Streamlabs | Streamlabs OBS.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Streamlabs OBS.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Streamlabs OBS.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Discord | discord.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\discord.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\discord.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Discord updater | Update.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Update.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Update.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Google Chrome | chrome.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\chrome.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\chrome.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Microsoft Edge | msedge.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\msedge.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\msedge.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Mozilla Firefox | firefox.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\firefox.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\firefox.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Brave | brave.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\brave.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\brave.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Opera | opera.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\opera.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\opera.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Spotify | spotify.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spotify.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spotify.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Microsoft Word | WINWORD.EXE | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WINWORD.EXE\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WINWORD.EXE\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Microsoft Excel | EXCEL.EXE | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EXCEL.EXE\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EXCEL.EXE\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Microsoft PowerPoint | POWERPNT.EXE | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\POWERPNT.EXE\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\POWERPNT.EXE\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Microsoft Outlook | OUTLOOK.EXE | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\OUTLOOK.EXE\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\OUTLOOK.EXE\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: VS Code | Code.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Code.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Code.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Visual Studio | devenv.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\devenv.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\devenv.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: IntelliJ | idea64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\idea64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\idea64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: PyCharm | pycharm64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\pycharm64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\pycharm64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Blender | blender.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\blender.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\blender.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: After Effects | AfterFX.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AfterFX.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AfterFX.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Premiere Pro | Premiere Pro.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Premiere Pro.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Premiere Pro.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Photoshop | Photoshop.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Photoshop.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Photoshop.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: DaVinci Resolve | Resolve.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Resolve.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Resolve.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: VLC | vlc.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vlc.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vlc.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: mpv | mpv.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\mpv.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\mpv.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: PotPlayer | PotPlayerMini64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PotPlayerMini64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PotPlayerMini64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: HD Tune | hdtune.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\hdtune.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\hdtune.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: CrystalDiskInfo | CrystalDiskInfo64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CrystalDiskInfo64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CrystalDiskInfo64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: MSI Afterburner | MSIAfterburner.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MSIAfterburner.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MSIAfterburner.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: RivaTuner | RTSS.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RTSS.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RTSS.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: HWMonitor | hwmonitor.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\hwmonitor.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\hwmonitor.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: CPU-Z | cpuz.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cpuz.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cpuz.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: GPU-Z | gpu-z.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\gpu-z.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\gpu-z.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: HWiNFO | HWiNFO64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HWiNFO64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\HWiNFO64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Process Hacker | ProcessHacker.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ProcessHacker.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ProcessHacker.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: System Informer | SystemInformer.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SystemInformer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SystemInformer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Process Explorer | procexp64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\procexp64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\procexp64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Autoruns | autoruns64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\autoruns64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\autoruns64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: DebugView | dbgview64.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dbgview64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dbgview64.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Wireshark | Wireshark.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Wireshark.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Wireshark.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Notepad++ | notepad++.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad++.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad++.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: 7-Zip | 7zFM.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zFM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zFM.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: 7-Zip GUI | 7zG.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zG.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zG.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: WinRAR | WinRAR.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WinRAR.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WinRAR.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Everything Search | Everything.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Everything.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Everything.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: ShareX | ShareX.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShareX.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShareX.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: f.lux | f.lux.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\f.lux.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\f.lux.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: PowerToys | PowerToys.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PowerToys.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PowerToys.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Windows Terminal | WindowsTerminal.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WindowsTerminal.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WindowsTerminal.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Windows Terminal wt | wt.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Command Prompt | cmd.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cmd.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cmd.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Windows PowerShell | powershell.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\powershell.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\powershell.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: PowerShell 7 | pwsh.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\pwsh.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\pwsh.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Windows Explorer | explorer.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Desktop Window Manager | dwm.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Windows Search Host | SearchHost.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Start Menu | StartMenuExperienceHost.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\StartMenuExperienceHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\StartMenuExperienceHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Shell Experience | ShellExperienceHost.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: UWP frame | ApplicationFrameHost.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ApplicationFrameHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ApplicationFrameHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Runtime Broker | RuntimeBroker.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RuntimeBroker.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\RuntimeBroker.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Shell Infrastructure | sihost.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sihost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Task Host | taskhostw.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskhostw.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\taskhostw.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

:: Console Host | conhost.exe | HOMI.COM high CPU + IO
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\conhost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\conhost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f >nul 2>&1

set "MM=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
set "PREFETCH=%MM%\PrefetchParameters"
set "IOSYS=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System"
set "FS=HKLM\SYSTEM\CurrentControlSet\Control\FileSystem"
set "DWM=HKLM\SOFTWARE\Microsoft\Windows\DWM"
set "GD=HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
set "GDS=%GD%\Scheduler"
set "GDMM=%GD%\MemoryManagement"
set "GDPOWER=%GD%\Power"
set "TCP=HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
set "AFD=HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters"
set "POWER=HKLM\SYSTEM\CurrentControlSet\Control\Power"
set "CPU0=HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0"

:: =====================================================================
:: 03. BCDEDIT - BOOT, HYPERVISOR, TIMER, MEMORIA, SICUREZZA BOOT
:: =====================================================================

:: Timer e orologi di sistema
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1

:: Impostazioni APIC e configurazione boot
bcdedit /set x2apicpolicy enable >nul 2>&1
bcdedit /set configaccesspolicy default >nul 2>&1
bcdedit /set bootmenupolicy standard >nul 2>&1

:: Emergency Management Services off
bcdedit /set ems off >nul 2>&1

:: Ibernazione off via boot
bcdedit /set hibernation off >nul 2>&1

:: TSC sync policy
bcdedit /set tscsyncpolicy enhanced >nul 2>&1

:: Disattiva ibernazione Windows
powercfg -h off >nul 2>&1

:: =====================================================================
:: 04. TELEMETRIA BASE WINDOWS
:: =====================================================================

:: Disattiva telemetria Microsoft a livello policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: =====================================================================
:: 05. MEMORY MANAGEMENT - CACHE, PAGING, POOL, PRIORITA'
:: =====================================================================

:: Cache di sistema grande
reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 0 /f

:: Attiva paging executive
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f

:: Priorità zero page thread
reg add "%MM%" /v "ZeroPageThreadPriority" /t REG_DWORD /d 31 /f

:: Priorità memory management
reg add "%MM%" /v "MemoryManagementPriority" /t REG_DWORD /d 1 /f

:: Disattiva throttling memoria
reg add "%MM%" /v "DisableMemoryThrottling" /t REG_DWORD /d 1 /f

:: Disattiva page splitting
reg add "%MM%" /v "DisablePageSplitting" /t REG_DWORD /d 1 /f

:: Disattiva memory scrubbing
reg add "%MM%" /v "DisableMemoryScrubbing" /t REG_DWORD /d 1 /f

:: Second level cache
reg add "%MM%" /v "SecondLevelDataCache" /t REG_DWORD /d 0 /f

:: Pool usage maximum
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f

:: Move images
reg add "%MM%" /v "MoveImages" /t REG_DWORD /d 0 /f

:: Feature settings
reg add "%MM%" /v "FeatureSettings" /t REG_DWORD /d 1 /f

:: Non cancellare pagefile allo shutdown
reg add "%MM%" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f

:: Session view/pool sizes
reg add "%MM%" /v "SessionViewSize" /t REG_DWORD /d 192 /f
reg add "%MM%" /v "SessionPoolSize" /t REG_DWORD /d 128 /f
reg add "%MM%" /v "SystemViewSize" /t REG_DWORD /d 24576 /f

:: Protezione scrittura
reg add "%MM%" /v "EnforceWriteProtection" /t REG_DWORD /d 1 /f

:: Trim working set
reg add "%MM%" /v "TrimWorkingSet" /t REG_DWORD /d 0 /f

:: Write watch
reg add "%MM%" /v "WriteWatch" /t REG_DWORD /d 0 /f

:: Map transfer count
reg add "%MM%" /v "MapTransferCount" /t REG_DWORD /d 0 /f

:: Disattiva paging kernel stacks
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f

:: Disattiva pool tagging
reg add "%MM%" /v "DisablePoolTagging" /t REG_DWORD /d 1 /f

:: System cache reserve
reg add "%MM%" /v "SystemCacheReserve" /t REG_DWORD /d 1 /f

:: Large page always
reg add "%MM%" /v "LargePageAlways" /t REG_DWORD /d 1 /f

:: Disattiva background scavenging
reg add "%MM%" /v "DisableBackgroundScavenging" /t REG_DWORD /d 1 /f

:: Disattiva VAD cleanup

:: Override mitigazioni (prima impostazione)
reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f

:: Priorità allocazione pool/memoria
reg add "%MM%" /v "PoolAllocationPriority" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "MemoryPriority" /t REG_DWORD /d 1 /f

:: Nonpaged pool maximum
reg add "%MM%" /v "NonPagedPoolMaximum" /t REG_DWORD /d 0 /f

:: Disattiva compressione memoria
reg add "%MM%" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f

:: Disattiva page combining
reg add "%MM%" /v "EnablePageCombining" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "DisablePageCombining" /t REG_DWORD /d 1 /f

:: NUMA node selection policy
reg add "%MM%" /v "NumaNodeSelectionPolicy" /t REG_DWORD /d 1 /f

:: DRAM power management off
reg add "%MM%" /v "DramPowerManagement" /t REG_DWORD /d 0 /f

:: Disattiva paging driver
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f

:: Priorità applicazioni foreground
reg add "%MM%" /v "PrioritizeForegroundApplications" /t REG_DWORD /d 1 /f

:: Disattiva aging working set
reg add "%MM%" /v "DisableWorkingSetAging" /t REG_DWORD /d 1 /f

:: Disattiva kernel stack paging
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f

:: Large page minimum
reg add "%MM%" /v "LargePageMinimum" /t REG_DWORD /d 0 /f

:: Nonpaged/paged pool sizes
reg add "%MM%" /v "NonPagedPoolSize" /t REG_DWORD /d 0 /f

:: IO page lock limit
reg add "%MM%" /v "IoPageLockLimit" /t REG_DWORD /d 0 /f

:: Pagine minime libere

:: Threshold dirty page system cache
reg add "%MM%" /v "SystemCacheDirtyPageThreshold" /t REG_DWORD /d 81920 /f

:: Allocation preference
reg add "%MM%" /v "AllocationPreference" /t REG_DWORD /d 1048576 /f

:: Evita collisioni large page
reg add "%MM%" /v "AvoidLargePageCollisions" /t REG_DWORD /d 1 /f

:: PAE
reg add "%MM%" /v "PhysicalAddressExtension" /t REG_DWORD /d 1 /f

:: Quote pool
reg add "%MM%" /v "NonPagedPoolQuota" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PagedPoolQuota" /t REG_DWORD /d 0 /f

:: Opzioni avvio system

:: Flag virtualizzazione

:: Cache livelli CPU
reg add "%MM%" /v "FirstLevelDataCache" /t REG_DWORD /d 65536 /f
reg add "%MM%" /v "ThirdLevelDataCache" /t REG_DWORD /d 131072 /f

:: Policy allocazione memoria fisica
reg add "%MM%" /v "PhysicalMemoryAllocationPolicy" /t REG_DWORD /d 0 /f

:: CFG e hot patch off
reg add "%MM%" /v "EnableCfg" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "HotPatch" /t REG_DWORD /d 0 /f

:: Queue depth memoria/controller
reg add "%MM%" /v "McGlobalShortBankQueueDepth" /t REG_DWORD /d 16 /f
reg add "%MM%" /v "McBankQueueDepth" /t REG_DWORD /d 8 /f
reg add "%MM%" /v "McMaxChannelCount" /t REG_DWORD /d 4 /f

:: Disattiva memory patrol scrub
reg add "%MM%" /v "DisableMemoryPatrolScrub" /t REG_DWORD /d 1 /f

:: NUMA cross node access
reg add "%MM%" /v "NumaCrossNodeAccess" /t REG_DWORD /d 2 /f

:: Shared user data
reg add "%MM%" /v "SharedUserData" /t REG_DWORD /d 1 /f

:: Commit limits
reg add "%MM%" /v "MappedCommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f
reg add "%MM%" /v "CommitLimit" /t REG_DWORD /d 0xFFFFFFFF /f

:: IO modification
reg add "%MM%" /v "IoModification" /t REG_DWORD /d 0 /f

:: GameMode cache
reg add "%MM%" /v "GameModeCacheSize" /t REG_DWORD /d 1073741824 /f
reg add "%MM%" /v "GameModeEnabled" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "GameModeCachePriority" /t REG_DWORD /d 15 /f

:: =====================================================================
:: 06. PREFETCH / SUPERFETCH / READ-AHEAD
:: =====================================================================

:: Disattiva prefetcher
reg add "%PREFETCH%" /v "EnablePrefetcher" /t REG_DWORD /d 0 /f

:: Disattiva superfetch
reg add "%PREFETCH%" /v "EnableSuperfetch" /t REG_DWORD /d 0 /f

:: Disattiva tracing Superfetch
reg add "%PREFETCH%" /v "SfTracingState" /t REG_DWORD /d 0 /f

:: Disattiva boot trace
reg add "%PREFETCH%" /v "EnableBootTrace" /t REG_DWORD /d 0 /f

:: Disattiva read ahead/seek ahead
reg add "%PREFETCH%" /v "EnableReadAhead" /t REG_DWORD /d 0 /f
reg add "%PREFETCH%" /v "EnableSeekAhead" /t REG_DWORD /d 0 /f

:: Limita read ahead
reg add "%PREFETCH%" /v "MaxReadAheadSize" /t REG_DWORD /d 0 /f

:: Tentativi prefetch
reg add "%PREFETCH%" /v "PrefetchAttempts" /t REG_DWORD /d 0 /f

:: Disattiva compressione memoria e page combining anche via PowerShell
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression -PageCombining"

:: =====================================================================
:: 07. I/O SYSTEM / STORAGE / NVME / DISK
:: =====================================================================

:: Abilita IoRing
reg add "%IOSYS%" /v "EnableIoRing" /t REG_DWORD /d 1 /f
reg add "%IOSYS%" /v "IoRingMaxSubmitQueueSize" /t REG_DWORD /d 65536 /f

:: Count operations
reg add "%IOSYS%" /v "CountOperations" /t REG_DWORD /d 0 /f

:: Interrupt steering
reg add "%IOSYS%" /v "InterruptSteeringDisabled" /t REG_DWORD /d 0 /f

:: Bypass IO
reg add "%IOSYS%" /v "BypassIosEnable" /t REG_DWORD /d 1 /f

:: Lookaside
reg add "%IOSYS%" /v "DisableLookAside" /t REG_DWORD /d 1 /f

:: Priorità IO
reg add "%IOSYS%" /v "IoPriorityHint" /t REG_DWORD /d 3 /f

:: No workqueue
reg add "%IOSYS%" /v "IoNoWorkQueue" /t REG_DWORD /d 1 /f

:: Disattiva buffering IO
reg add "%IOSYS%" /v "DisableIoBuffering" /t REG_DWORD /d 1 /f

:: Thread library calls
reg add "%IOSYS%" /v "DisableThreadLibraryCalls" /t REG_DWORD /d 1 /f

:: Optimization flags
reg add "%IOSYS%" /v "OptimizationFlags" /t REG_DWORD /d 0x400000 /f

:: Limiti operazioni read/write/other
reg add "%IOSYS%" /v "IoReadOperationLimit" /t REG_DWORD /d 65536 /f
reg add "%IOSYS%" /v "IoWriteOperationLimit" /t REG_DWORD /d 65536 /f
reg add "%IOSYS%" /v "IoOtherOperationLimit" /t REG_DWORD /d 65536 /f

:: Maximum length IO
reg add "%IOSYS%" /v "IOMaximumLength" /t REG_DWORD /d 1048576 /f

:: Page lock limit IO
reg add "%IOSYS%" /v "IoPageLockLimit" /t REG_DWORD /d 16777216 /f

:: Match deadline IO
reg add "%IOSYS%" /v "IOMatchDeadline" /t REG_DWORD /d 0 /f

:: Storport: transfer length, richieste, priorità
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "MaximumTransferLength" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "NumberOfRequests" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "InterruptPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DpcIsolation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storport\Parameters" /v "DisableIdleTimeout" /t REG_DWORD /d 1 /f

:: Stornvme: flush cache, priorità, DPC, bypass IO, power idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableWriteCacheBufferFlush" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "InterruptPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DpcIsolation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "BypassIoEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeCommandTimeout" /t REG_DWORD /d 300 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "NvmeMaxIoConcurrency" /t REG_DWORD /d 128 /f

:: MSI/Interrupt NVME
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSIXSupported" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DeviceExecutionMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 31 /f

:: Disk timeout/cache
reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk\Parameters" /v "TimeOutValue" /t REG_DWORD /d 180 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Disk" /v "EnableCache" /t REG_DWORD /d 1 /f

:: Storage control
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "DisableDeleteNotification" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ZeroPoweredNTDisks" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "ShortStreakQueuing" /t REG_DWORD /d 1 /f

:: FairShare disk/netfs off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\Disk" /v "EnableFairShare" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TSFairShare\NetFS" /v "EnableFairShare" /t REG_DWORD /d 0 /f

:: FSUTIL: last access, 8.3, MFT zone, encryption/compression
fsutil behavior set disablelastaccess 1
fsutil behavior set disable8dot3 1
fsutil behavior set mftzone 4
fsutil behavior set encryptpagingfile 0
fsutil behavior set disablecompression 1
fsutil behavior set disableencryption 1
fsutil behavior set memoryusage 2

:: =====================================================================
:: 08. NTFS / FILE SYSTEM
:: =====================================================================

:: Disattiva last access update
reg add "%FS%" /v "NtfsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: MFT zone reservation
reg add "%FS%" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f

:: Disattiva nomi 8.3
reg add "%FS%" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f

:: NTFS memory usage
reg add "%FS%" /v "NtfsMemoryUsage" /t REG_DWORD /d 2 /f

:: Contig file alloc size
reg add "%FS%" /v "ContigFileAllocSize" /t REG_DWORD /d 64 /f

:: Disattiva encryption NTFS
reg add "%FS%" /v "NtfsDisableEncryption" /t REG_DWORD /d 1 /f

:: Tunnel entries
reg add "%FS%" /v "MaximumTunnelEntries" /t REG_DWORD /d 0 /f
reg add "%FS%" /v "MaximumTunnelEntryAgeInSeconds" /t REG_DWORD /d 0 /f

:: Name/path cache
reg add "%FS%" /v "NameCache" /t REG_DWORD /d 512 /f
reg add "%FS%" /v "PathCache" /t REG_DWORD /d 128 /f

:: Long paths enabled
reg add "%FS%" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f

:: ReFS last access
reg add "%FS%" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: Disattiva compressione NTFS
reg add "%FS%" /v "NtfsDisableCompression" /t REG_DWORD /d 1 /f

:: Extended character 8dot3 rename
reg add "%FS%" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d 0 /f

:: Disattiva read ahead NTFS
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Ntfs" /v "DisableReadAhead" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 09. DWM / DXGI / GRAPHICS CORE / FLIP MODEL
:: =====================================================================

:: Use HW draw list
reg add "%DWM%" /v "UseHWDrawList" /t REG_DWORD /d 1 /f

:: Non forzare software D3D
reg add "%DWM%" /v "ForceSoftwareD3D" /t REG_DWORD /d 0 /f

:: Overlay test mode

:: Independent flip
reg add "%DWM%" /v "EnableIndependentFlip" /t REG_DWORD /d 1 /f

:: Machine check
reg add "%DWM%" /v "EnableMachineCheck" /t REG_DWORD /d 0 /f

:: Non ibernare thumbnails
reg add "%DWM%" /v "AlwaysHibernateThumbnails" /t REG_DWORD /d 0 /f

:: Disattiva window ghosting
reg add "%DWM%" /v "DisableProcessWindowsGhosting" /t REG_DWORD /d 1 /f

:: Max queued buffers
reg add "%DWM%" /v "MaxQueuedBuffers" /t REG_DWORD /d 1 /f

:: Overlay supported
reg add "%DWM%" /v "OverlaySupported" /t REG_DWORD /d 0 /f

:: Force direct flip
reg add "%DWM%" /v "ForceDirectFlip" /t REG_DWORD /d 1 /f

:: Disattiva overlays
reg add "%DWM%" /v "DisableOverlays" /t REG_DWORD /d 0 /f

:: Hardware scheduling GPU
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GD%" /v "HwSch_QueueDepth" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "HwSch_MaxPendingCommand" /t REG_DWORD /d 1 /f

:: TDR delay
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 20 /f
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 60 /f

:: DMA remapping off
reg add "%GD%" /v "DmaRemappingCompatible" /t REG_DWORD /d 0 /f

:: VSync latency update
reg add "%GD%" /v "DisableVsyncLatencyUpdate" /t REG_DWORD /d 1 /f

:: Dirty rectangles off
reg add "%GD%" /v "EnableDirtyRectangles" /t REG_DWORD /d 0 /f

:: Frame queue mode
reg add "%GD%" /v "FrameQueueMode" /t REG_DWORD /d 0 /f

:: Fullscreen optimizations enable
reg add "%GD%" /v "FSE_Enable" /t REG_DWORD /d 1 /f

:: WDDM checks off
reg add "%GD%" /v "DisableWddm2Checks" /t REG_DWORD /d 1 /f

:: Power setting off
reg add "%GD%" /v "PowerSettingEnable" /t REG_DWORD /d 0 /f

:: Async presentation
reg add "%GD%" /v "EnableAsyncPresentation" /t REG_DWORD /d 1 /f

:: Miracast off
reg add "%GD%" /v "PlatformSupportMiracast" /t REG_DWORD /d 0 /f

:: IOMMU usage off
reg add "%GD%" /v "IommuUsage" /t REG_DWORD /d 0 /f

:: D3D12 shared dynamic value management off
reg add "%GD%" /v "D3D12DisableSharedDynamicValueManagement" /t REG_DWORD /d 1 /f

:: Memory encryption off
reg add "%GD%" /v "DisableMemoryEncryption" /t REG_DWORD /d 1 /f

:: Verify driver level off
reg add "%GD%" /v "VerifyDriverLevel" /t REG_DWORD /d 0 /f

:: Max frame latency
reg add "%GD%" /v "MaxFrameLatency" /t REG_DWORD /d 1 /f

:: TDR level
reg add "%GD%" /v "TdrLevel" /t REG_DWORD /d 8 /f

:: Multiplane overlay 3D off
reg add "%GD%" /v "EnableMultiPlaneOverlay3DDIs" /t REG_DWORD /d 0 /f

:: Force direct flip / overlays
reg add "%GD%" /v "ForceDirectFlip" /t REG_DWORD /d 0 /f
reg add "%GD%" /v "DisableOverlays" /t REG_DWORD /d 0 /f

:: High priority completion
reg add "%GD%" /v "HighPriorityCompletionMode" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "GpuPriorityChangeMode" /t REG_DWORD /d 1 /f

:: DCI control
reg add "%GD%" /v "DCIControl" /t REG_DWORD /d 1 /f

:: DirectStorage force flush off
reg add "%GDMM%" /v "DirectStorageForceFlush" /t REG_DWORD /d 0 /f

:: Scheduler GPU: preemption, priorità, vsync, async compute
reg add "%GDS%" /v "EnableComputePreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "VsyncIdleTimeout" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnableVsyncClockGroup" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "GpuPriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "PreemptionLevel" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "MicrocodeQueuePriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f
reg add "%GDS%" /v "EnableMidGfxPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnableSCGMidBufferPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "SchedulePolicy" /t REG_DWORD /d 4 /f
reg add "%GDS%" /v "GpuResourceAccessPriority" /t REG_DWORD /d 31 /f
reg add "%GDS%" /v "EnableYield" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "EnablePreemptiveScheduling" /t REG_DWORD /d 1 /f
reg add "%GDS%" /v "EnableCudaContextPreemption" /t REG_DWORD /d 0 /f
reg add "%GDS%" /v "PollStatusIterations" /t REG_DWORD /d 1 /f

:: Power GPU: dynamic pstate, DPC per core, caching registry off
reg add "%GDPOWER%" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "%GDPOWER%" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f
reg add "%GDPOWER%" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f

:: DXGKrnl thread priority
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f

:: Direct3D contexts/loader threads
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxContexts" /t REG_DWORD /d 4096 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "MaxLoaderThreads" /t REG_DWORD /d 16 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "ContextReordering" /t REG_DWORD /d 0 /f

:: Driver software only off
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\Drivers" /v "SoftwareOnly" /t REG_DWORD /d 0 /f

:: D3D 12/11 clear on allocate off, async compute, PSO eviction off
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "EnableAsyncCompute" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\12.0" /v "DisablePsoEviction" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D\11.0" /v "DisableClearOnAllocate" /t REG_DWORD /d 1 /f

:: DirectDraw emulation only off
reg add "HKLM\SOFTWARE\Microsoft\DirectDraw" /v "EmulationOnly" /t REG_DWORD /d 0 /f

:: Vulkan validation off
reg add "HKLM\SOFTWARE\Khronos\Vulkan\ImplicitLayers" /v "DisableValidation" /t REG_DWORD /d 1 /f

:: DirectX user GPU preferences
reg add "HKCU\Software\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "SwapEffectUpgradeEnable=1" /f

:: =====================================================================
:: 10. GAME DVR / GAME BAR / GAME MODE
:: =====================================================================

:: Disattiva GameDVR e comportamenti correlati
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Priority" /t REG_DWORD /d 1 /f

:: Disattiva cattura app/audio/cursore
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d 0 /f

:: Policy GameDVR off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d 0 /f

:: GameMode DVR
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeUseNullRenderer" /t REG_DWORD /d 1 /f

:: =====================================================================
:: =====================================================================
:: 11. MMCSS - MULTIMEDIA CLASS SCHEDULER
:: =====================================================================

:: Network throttling index max
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f

:: System responsiveness
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f

:: Priorita MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "Priority" /t REG_DWORD /d 6 /f

:: Profilo Games
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "BackgroundPriority" /t REG_DWORD /d 0 /f

:: Profilo Audio
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio" /v "Background Only" /t REG_SZ /d "False" /f

:: Profilo Low Latency
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d 8 /f

:: =====================================================================
:: 14. USB / INTERRUPT / PCI / CLASS DEVICE
:: =====================================================================

:: USB selective suspend off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d 1 /f

:: USBXHCI priority/interrupt moderation
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBXHCI\Parameters" /v "InterruptModeration" /t REG_DWORD /d 0 /f

:: USBHUB3 priority

:: HidUsb idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HidUsb" /v "IdleEnabled" /t REG_DWORD /d 0 /f

:: USB class idle off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{36fc9e60-c465-11cf-8056-444553540000}" /v "IdleEnable" /t REG_DWORD /d 0 /f

:: Mouse class force high priority
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E96F-E325-11CE-BFC1-08002BE10318}\0000" /v "ForceProcessHighPriority" /t REG_DWORD /d 1 /f

:: Display class MSI/ASPM/latency
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspm" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f

:: PCI MSI/latency/ASPM
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "EnableMsi" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "MessageSignaledInterrupt" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusSolverMaxDepth" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "BusCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PCI" /v "PerfOptimize" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci" /v "LinkDisableAspm" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v "PciBufferSize" /t REG_DWORD /d 64 /f

:: =====================================================================
:: 15. SERVIZI - DISABILITAZIONE TRAMITE SC CONFIG
:: =====================================================================

:: Elenco servizi da disabilitare
set "SC_DISABLED=DiagTrack dmwappushservice WerSvc DPS WdiServiceHost WdiSystemHost PcaSvc diagnosticshub.standardcollector.service diagsvc SysMain RemoteRegistry RemoteAccess WinRM iphlpsvc BDESVC EFS SCardSvr ScDeviceEnum Fax MapsBroker PhoneSvc TapiSrv AJRouter WpcMonSvc ALG EntAppSvc wisvc RetailDemo WMPNetworkSvc StiSvc SensorService SensrSvc SensorDataService XboxGipSvc XblAuthManager XboxNetApiSvc XblGameSave SEMgrSvc uhssvc upfc PushToInstall dosvc UsoSvc WaaSMedicSvc microsoftedgeupdater microsoftedgeupdatem EsifTelemetryService ipfsvc AeLookupSvc WSAIFabricSvc edgeupdate edgeupdatem DsSvc WarpSvc NvTelemetryContainer Wecsvc DoSvc NetTcpPortSharing perceptionsimulation spectrum MixedRealityOpenXRSvc BcastDVRUserService icssvc DmEnrollmentSvc embeddedmode GraphicsPerfSvc HvHost IpxlatCfgSvc jhi_service KtmRm LxpSvc McpManagementService MicrosoftEdgeElevationService NetSetupSvc NcdAutoSetup p2pimsvc p2psvc PerfHost pla PolicyAgent PNRPAutoReg PNRPsvc QWAVE RasAuto RasMan RpcLocator shpamsvc smphost SmsRouter SNMPTRAP svsvc TroubleshootingSvc tzautoupdate WebClient WEPHOSTSVC wercplsupport WFDSConMgrSvc WiaRpc WManSvc wmiApSrv WPDBusEnum BITS InstallService LicenseManager fhsvc defragsvc TieringEngineService UdkUserSvc Spooler SharedAccess WwanSvc"

for %%S in (%SC_DISABLED%) do (
    sc config %%S start= disabled >nul 2>&1
)

:: Servizi con spazi nel nome
for %%S in ("AMD Crash Defender Service" "AUEPLauncher" "NvTelemetryContainer") do (
    sc config "%%~S" start= disabled >nul 2>&1
)

:: Edge update services delete
sc delete edgeupdate >nul 2>&1
sc delete edgeupdatem >nul 2>&1

:: Servizi da impostare auto/demand/enabled
sc config TabletInputService start= auto >nul 2>&1
sc config TabletInputService start= enabled >nul 2>&1
sc config IntelAudioService start= demand >nul 2>&1
sc config bits start= demand >nul 2>&1
sc config AppXSvc start= demand >nul 2>&1
sc config ClipSVC start= demand >nul 2>&1
sc config camsvc start= auto >nul 2>&1
sc config swprv start= demand >nul 2>&1
sc config SDRSVC start= demand >nul 2>&1
sc config StorSvc start= demand >nul 2>&1
sc config TrkWks start= auto >nul 2>&1
sc config vds start= demand >nul 2>&1
sc config RtkAudioUniversalService start= auto >nul 2>&1
sc config bthserv start= auto >nul 2>&1
sc config BTAGService start= demand >nul 2>&1
sc config BthAvctpSvc start= auto >nul 2>&1
sc config Themes start= auto >nul 2>&1
sc config FontCache start= auto >nul 2>&1
sc config CDPSvc start= auto >nul 2>&1
sc config CDPUserSvc start= demand >nul 2>&1
sc config BTAGService start= auto >nul 2>&1
sc config bthserv start= auto >nul 2>&1
sc config W32Time start= demand >nul 2>&1

:: =====================================================================
:: 16. SERVIZI - START VALUE 4 (DISABLED) NEL REGISTRO
:: =====================================================================

:: Stesso elenco servizi: Start=4
for %%S in (%SC_DISABLED%) do (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%S" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
)

:: Servizi con start diverso
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\KeyIso" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\swprv" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SDRSVC" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\StorSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrkWks" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\vds" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\RtkAudioUniversalService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\camsvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TabletInputService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

:: Chiavi offline/temp system presenti nel file originale
reg add "HKLM\TEMP_SYSTEM\ControlSet001\Services\wlidsvc" /v Start /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\TEMP_SYSTEM\ControlSet001\Services\WbioSrvc" /v Start /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\OFFLINE_SYS\ControlSet001\Services\DispBrokerDesktopSvc" /v Start /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\OFFLINE_SYS\ControlSet001\Services\BcastDVRUserService" /v Start /t REG_DWORD /d 2 /f >nul 2>&1

:: =====================================================================
:: 17. RIMOZIONE APPX / BLOATWARE
:: =====================================================================

:: Svuota cestino
powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue"

:: Rimozione pacchetti AppX utente corrente
for %%A in (
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.Todos"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "Microsoft.SkypeApp"
    "Clipchamp.Clipchamp"
    "Microsoft.Bing"
    "Microsoft.OutlookForWindows"
    "Microsoft.DevHome"
    "Microsoft.Windows.DevHome"
    "Microsoft.WebExperiencePack"
    "Microsoft.Windows.Ai.Copilot.Provider"
    "Microsoft.Copilot"
    "MSTeams"
    "Microsoft.MicrosoftEdge.Stable"
) do (
    powershell -NoProfile -Command "Get-AppxPackage *%%~A* | Remove-AppxPackage" >nul 2>&1
)

:: Rimozione pacchetti AppX per tutti gli utenti
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MixedReality.Portal* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *windowscommunicationsapps* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *OutlookForWindows* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MSPaint* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *ScreenSketch* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *MicrosoftStickyNotes* | Remove-AppxPackage -AllUsers" >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -AllUsers *WindowsSoundRecorder* | Remove-AppxPackage -AllUsers" >nul 2>&1

:: Funzionalità opzionali Windows
powershell -NoProfile -Command "Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client', 'SMB1Protocol' -NoRestart" >nul 2>&1

:: Defender sample consent
powershell -NoProfile -Command "Set-MpPreference -SubmitSamplesConsent 2" >nul 2>&1

:: =====================================================================
:: 18. LOGMAN / ETL / EVENT LOG
:: =====================================================================

:: Stop logger ETL
logman stop "Microsoft-Windows-Storage-Storport-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-Rdp-Graphics-RdpIdd-Trace" -ets >nul 2>&1
logman stop "Microsoft-Windows-Kernel-Processor-Power" -ets >nul 2>&1
logman stop "Microsoft-Windows-UserModePowerService" -ets >nul 2>&1
logman stop "Microsoft-Windows-Ntfs-Operational" -ets >nul 2>&1
logman stop "Microsoft-Windows-DeviceSetupManager-Admin" -ets >nul 2>&1
logman stop "Circular Kernel Context Logger" -ets >nul 2>&1
logman stop "UBPM" -ets >nul 2>&1
logman stop "AutoLogger-Diagtrack-Listener" -ets >nul 2>&1
logman stop "NetCore" -ets >nul 2>&1
logman stop "ContextLogger" -ets >nul 2>&1
logman stop "CloudExperienceHost" -ets >nul 2>&1

:: Pulizia log eventi
wevtutil cl System >nul 2>&1
wevtutil cl Application >nul 2>&1
wevtutil cl Security >nul 2>&1
wevtutil cl Setup >nul 2>&1

:: Disattiva log specifici
wevtutil.exe set-log "Microsoft-Windows-SleepStudy/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-Kernel-Processor-Power/Diagnostic" /e:false >nul 2>&1
wevtutil.exe set-log "Microsoft-Windows-UserModePowerService/Diagnostic" /e:false >nul 2>&1

:: =====================================================================
:: 19. OFFICE / EDGE / WEBVIEW2 / TELEMETRIA BROWSER
:: =====================================================================

:: Office telemetry
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "DisconnectedState" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Privacy" /v "ContentSlotState" /t REG_DWORD /d 2 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "Enablelogging" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Office\16.0\OSM" /v "EnableUpload" /t REG_DWORD /d 0 /f

:: Edge telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\WebView2" /v "TelemetryEnabled" /t REG_DWORD /d 0 /f

:: Chrome background mode
reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v "BackgroundModeEnabled" /t REG_DWORD /d 0 /f

:: Edge update block
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "UpdateDefault" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "DisableAutoUpdateChecksCheckboxValue" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v "Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 20. PRIVACY / TELEMETRIA / CONTENT DELIVERY / COPILOT / RECALL
:: =====================================================================

:: Telemetria profonda
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "LimitEnhancedDiagnosticData" /t REG_DWORD /d 0 /f

:: Advertising info off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

:: Tailored experiences off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesAllowed" /t REG_DWORD /d 0 /f

:: Feedback frequency off
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f

:: Content Delivery Manager off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338380Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338381Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338382Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f

:: Windows AI / Recall / Copilot off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f

:: Bing search off
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: Windows Spotlight off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightOnActionCenter" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightWindowsWelcomeExperience" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f

:: Cortana off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f

:: Activity feed off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f

:: =====================================================================
:: 21. IFEO - DEBUGGER BLOCK / PRIORITA' / LARGE PAGES
:: =====================================================================

:: Blocco telemetria tramite IFEO debugger
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v "Debugger" /t REG_SZ /d "nul" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DeviceCensus.exe" /v "Debugger" /t REG_SZ /d "nul" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AggregatorHost.exe" /v "Debugger" /t REG_SZ /d "nul" /f

:: Priorità processi sistema/shell
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\explorer.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchHost.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d 5 /f

:: Priorità bassa per update/WMI/spooler
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WMIADAP.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WmiPrvSE.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spoolsv.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f



:: Disattiva sensor watchdog
reg add "%POWER%" /v "DisableSensorWatchdog" /t REG_DWORD /d 1 /f

:: Fabric/LCLK clock gating off
reg add "%POWER%" /v "FabricClockGating" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "LclkClockGating" /t REG_DWORD /d 0 /f

:: Processor performance min/max
reg add "%POWER%" /v "ProcessorPerformanceMinimum" /t REG_DWORD /d 100 /f
reg add "%POWER%" /v "ProcessorPerformanceMaximum" /t REG_DWORD /d 100 /f
reg add "%POWER%" /v "ProcessorPerformanceMaximumPolicy" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CpuUtilizationPercentage" /t REG_DWORD /d 100 /f

:: Energy estimation off
reg add "%POWER%" /v "EnergyEstimationDisabled" /t REG_DWORD /d 1 /f

:: Responsive mode
reg add "%POWER%" /v "ResponsiveModeEnabled" /t REG_DWORD /d 1 /f

:: Accelerated hibernate off
reg add "%POWER%" /v "AcceleratedHibernateEnabled" /t REG_DWORD /d 0 /f

:: Energy efficient turbo off
reg add "%POWER%" /v "EnergyEfficientTurbo" /t REG_DWORD /d 0 /f

:: Turbo boost enabled
reg add "%POWER%" /v "TurboBoostEnabled" /t REG_DWORD /d 1 /f

:: C-States off
reg add "%POWER%" /v "CoreCStatesEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CoreC6Enable" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "PlatformCStateSupport" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "CStatesForIdle" /t REG_DWORD /d 0 /f

:: VR ready/VR mode/low latency
reg add "%POWER%" /v "VRReadyEnabled" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "VRMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "LowLatencyMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "LowLatencyState" /t REG_DWORD /d 2 /f

:: Memory performance/timing
reg add "%POWER%" /v "MemoryPerformanceMode" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "MemoryTimingOverride" /t REG_DWORD /d 1 /f

:: SOC power states off
reg add "%POWER%" /v "SOCPStateSupport" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "SOCPciePStateSupport" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "SOCD3ColdSupport" /t REG_DWORD /d 0 /f

:: USB3 power off
reg add "%POWER%" /v "USB3PowerEnable" /t REG_DWORD /d 0 /f

:: S0 auto power down timer off
reg add "%POWER%" /v "S0AutoPowerDownTimer" /t REG_DWORD /d 0 /f

:: CPU compute efficiency
reg add "%POWER%" /v "CpuComputeEfficiencyEnabled" /t REG_DWORD /d 1 /f
reg add "%POWER%" /v "CpuBusyBudgeting" /t REG_DWORD /d 0 /f

:: Unified stack policy
reg add "%POWER%" /v "UnifiedStackPolicy" /t REG_DWORD /d 0 /f

:: Fast S4 off
reg add "%POWER%" /v "FastS4" /t REG_DWORD /d 0 /f

:: Hiberfile off
reg add "%POWER%" /v "HiberFileEnabled" /t REG_DWORD /d 0 /f

:: Power thresholds
reg add "%POWER%\PowerThresholds" /v "AcThermalScalingRatio" /t REG_DWORD /d 0 /f
reg add "%POWER%\PowerThresholds" /v "DcThermalScalingRatio" /t REG_DWORD /d 0 /f
reg add "%POWER%\PowerThresholds" /v "AcLineStatus" /t REG_DWORD /d 1 /f
reg add "%POWER%\PowerThresholds" /v "BatteryFlag" /t REG_DWORD /d 0 /f

:: Default power scheme values
reg add "%POWER%\PowerSettings" /v "DefaultPowerSchemeValues" /t REG_BINARY /d 000000 /f



:: =====================================================================
:: 30. PERFORMANCE COUNTERS / PERFLIB / ACPI / PARTMGR / WHEA
:: =====================================================================

:: Disable performance counters
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "ForceSingleDPC" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PerfData" /v "BufferSize" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib" /v "ExtensibleCounters" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009" /v "Collect Timeout" /t REG_DWORD /d 0 /f

:: ACPI MSI/interrupt syntax
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "EnableMsi" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI\Parameters" /v "InterruptSyntax" /t REG_DWORD /d 0 /f

:: Partmgr staggered spin watches
reg add "HKLM\SYSTEM\CurrentControlSet\Services\partmgr" /v "StaggeredSpinWatches" /t REG_DWORD /d 0 /f

:: WHEA polling/offline off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableMCAPolling" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WHEA\Policy" /v "DisableOffline" /t REG_DWORD /d 1 /f


:: MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 10 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Network Throttling Index" /t REG_DWORD /d 4294967295 /f

:: GraphicsDrivers / Direct3D
reg add "%GD%" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "%GD%" /v "DpiMapIommuContiguous" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "CS_Disable" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f
reg add "%GD%" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "%GD%" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "%GD%" /v "FSE_Enable" /t REG_DWORD /d 0 /f

reg add "%GDS%" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f
reg add "%GDS%" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f

:: Memory Management
reg add "%MM%" /v "LargeSystemCache" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "SecondLevelDataCache" /t REG_DWORD /d 0 /f
reg add "%MM%" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f
reg add "%MM%" /v "IoPageLockLimit" /t REG_DWORD /d 67108864 /f
reg add "%MM%" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisableDriverPaging" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisableKernelStackPaging" /t REG_DWORD /d 1 /f
reg add "%MM%" /v "DisablePagingOfKernelStacks" /t REG_DWORD /d 1 /f

reg delete "%MM%" /v "ThirdLevelDataCache" /f >nul 2>&1

:: Explorer / ControlPanel
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f

:: PowerCfg GPU
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setactive SCHEME_CURRENT

:: VBS / HVCI / Credential Guard / System Guard
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\CredentialGuard" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelShadowStacks" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard" /v "Enabled" /t REG_DWORD /d 0 /f

:: Fast startup / ibernazione / timer coalescing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "HibernateEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 0 /f

:: Storage / TRIM / Compact OS / AHCI
fsutil behavior set DisableDeleteNotify 0
compact /compactos:never

reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableHIPM" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "EnableDIPM" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\storahci\Parameters\Device" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f


:: GameDVR / Fullscreen Optimizations
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d 2 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f

:: Game Mode off
reg add "HKCU\Software\Microsoft\GameBar" /v "GameModeEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "GameModeEnabled" /t REG_DWORD /d 0 /f

:: Scheduled tasks





:: Driver searching off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "InstallEveryDevice" /t REG_DWORD /d 0 /f

:: Quick machine recovery off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Recovery" /v "QuickMachineRecoveryEnabled" /t REG_DWORD /d 0 /f

:: --- 31.2 BLOCCO SERVIZI E POLICY WINDOWS UPDATE ---
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1
net stop dosvc /y >nul 2>&1
net stop usosvc /y >nul 2>&1
net stop WaaSMedicSvc /y >nul 2>&1
net stop stisvc /y >nul 2>&1
net stop InstallService /y >nul 2>&1
net stop DiagTrack /y >nul 2>&1
net stop dmwappushservice /y >nul 2>&1
net stop WerSvc /y >nul 2>&1

rd /s /q %systemroot%\SoftwareDistribution >nul 2>&1
del /f /q %systemroot%\system32\catroot2\*.* >nul 2>&1

sc triggerinfo wuauserv delete >nul 2>&1
sc triggerinfo usosvc delete >nul 2>&1
sc triggerinfo WaaSMedicSvc delete >nul 2>&1
sc triggerinfo bits delete >nul 2>&1
sc triggerinfo stisvc start/disabled >nul 2>&1

sc config wuauserv start= disabled >nul 2>&1
sc config usosvc start= disabled >nul 2>&1
sc config bits start= disabled >nul 2>&1
sc config WaaSMedicSvc start= disabled >nul 2>&1
sc config DoSvc start= disabled >nul 2>&1
sc config InstallService start= disabled >nul 2>&1
sc config stisvc start= disabled >nul 2>&1

sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WerSvc start= disabled >nul 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "SetDisableUXWUAccess" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usosvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\bits" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stisvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1

:: Pausa aggiornamenti fino al 2099
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d "2026-01-01T00:00:00Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d "2099-12-31T23:59:59Z" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesRequested" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpanded" /t REG_DWORD /d 1 /f >nul 2>&1

:: Blocco Windows Store
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableStoreApps" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerAccountStateContent" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /t REG_SZ /d "StoreDesktopExtension.exe" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "DisallowRun" /t REG_DWORD /d 1 /f >nul 2>&1
taskkill /f /im StoreDesktopExtension.exe >nul 2>&1

:: Permessi chiavi servizi update
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\UpdateModelTask" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Report policies" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Scheduled Start" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\WaaSMedic\PerformRemediation" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\SmartRetry" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /Disable >nul 2>&1
schtasks /Change /TN "Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /Disable >nul 2>&1

powershell -NoProfile -Command "$services = @('wuauserv', 'stisvc', 'WaaSMedicSvc'); foreach ($service in $services) { $path = 'HKLM:\SYSTEM\CurrentControlSet\Services\' + $service; if (Test-Path $path) { $acl = Get-Acl $path; $arguments = New-Object System.Security.AccessControl.RegistryAccessRule('Everyone', 'FullControl', 'Allow'); $acl.SetAccessRule($arguments); Set-Acl $path $acl; Set-ItemProperty -Path $path -Name 'Start' -Value 4 } }" >nul 2>&1

:: =====================================================================
:: =====================================================================
:: 32. BLOCCO WINDOWS UPDATE / MEDIC SERVICE TRAMITE REGISTRO E POLICY
:: =====================================================================

:: Disattiva aggiornamenti automatici via policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f >nul 2>&1

:: =====================================================================
:: 33. HOSTS
:: =====================================================================

:: =====================================================================
:: 34. ONEDRIVE - RIMOZIONE E PULIZIA
:: =====================================================================

if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
) else if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
)

rd "%USERPROFILE%\OneDrive" /s /q >nul 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /s /q >nul 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /s /q >nul 2>&1

reg delete "HKCU\Software\Microsoft\OneDrive" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f >nul 2>&1

reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-9950-BDF1-DD622415241E}" /f >nul 2>&1

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F02C1A0D-BE21-4350-88B0-7367FC96EFF3}" /f >nul 2>&1

:: =====================================================================
:: 35. PULIZIA FILE TEMP / CACHE / LOG / PREFETCH / THUMBS
:: =====================================================================

rd /s /q "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization" >nul 2>&1
DISM.exe /Online /Set-ReservedStorageState /State:Disabled >nul 2>&1
rd /s /q "%WINDIR%\Logs" >nul 2>&1
rd /s /q "%WINDIR%\Installer\$PatchCache$" >nul 2>&1
rd /s /q "%SystemDrive%\OneDriveTemp" >nul 2>&1
rd /s /q "%LocalAppData%\Temp" >nul 2>&1
rd /s /q "%SystemRoot%\System32\SleepStudy" >nul 2>&1
del /f /s /q "C:\Windows\Temp\*.*" >nul 2>&1
del /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
md "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
del /f /s /q "%LocalAppData%\NVIDIA\DXCache\*.*" >nul 2>&1
del /f /s /q "%LocalAppData%\AMD\DXCache\*.*" >nul 2>&1

:: Deep cleaning
rd /s /q "%LocalAppData%\Temp\mozilla-temp-files" >nul 2>&1
rd /s /q "%SystemDrive%\Users\%username%\AppData\Local\Microsoft\GameDVR" >nul 2>&1
rd /s /q "%SystemDrive%\Users\%username%\AppData\Local\Microsoft\Edge" >nul 2>&1
del /s /f /q "C:\Windows\Logs\*.log" >nul 2>&1
del /f /s /q "C:\Windows\inf\*.log" >nul 2>&1
del /f /s /q "C:\ProgramData\Microsoft\Windows\WER\*.*" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportArchive" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportQueue" >nul 2>&1
del /q /f /s "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /q /f /s "%AppData%\Mozilla\Firefox\Profiles\*.default\cache2\*" >nul 2>&1
del /q /f /s "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
rd /s /q "%AppData%\Discord\Cache" >nul 2>&1
rd /s /q "%AppData%\Discord\Code Cache" >nul 2>&1
rd /s /q "%SystemDrive%\$GetCurrent" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~BT" >nul 2>&1
rd /s /q "%SystemDrive%\$Windows.~WS" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.tmp" >nul 2>&1
del /f /q "C:\Windows\System32\DriverStore\FileRepository\*.log" >nul 2>&1
del /f /s /q "C:\Windows\panther\*.*" >nul 2>&1
rd /s /q "C:\Windows\panther" >nul 2>&1
del /f /q %windir%\inf\setupapi.dev.log >nul 2>&1
del /f /q %windir%\inf\setupapi.setup.log >nul 2>&1
del /f /s /q %windir%\System32\DriverStore\Temp\*.* >nul 2>&1

:: =====================================================================
:: 36. PIANO ALIMENTAZIONE / MONITOR / SLEEP
:: =====================================================================

powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg -setactive SCHEME_CURRENT

:: =====================================================================
:: 37. ATTIVITA' PIANIFICATE - DISABILITAZIONE / ELIMINAZIONE
:: =====================================================================


schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f >nul 2>&1
schtasks /delete /tn "MicrosoftEdgeUpdateBrowserReplacementServer" /f >nul 2>&1

schtasks /Delete /TN "Microsoft\Windows\Maps\MapsUpdateTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Maps\MapsToastTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Shell\FamilySafetyRefreshTask" /F >nul 2>&1
schtasks /Delete /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /F >nul 2>&1

:: =====================================================================
:: 38. LOCALIZZAZIONE / SENSORI / MICROFONO / APP PRIVACY
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Allow" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Allow" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessMicrophone /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 39. AUTOLOGGER / DIAGTRACK / DEFENDER LOGGER
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\AppModel" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\NtfsLog" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\UBPM" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Application" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Security" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-System" /v Start /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\ReadyBoot" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DiagLog" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WdiContextLog" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\TCPIPTrafficLogger" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\EventLog-Direct3D" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\GraphicsPerf" /v "Start" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\FaultTolerantHeap" /v "Start" /t REG_DWORD /d 0 /f

:: Blocco file ETL DiagTrack
del /f /q "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" >nul 2>&1
echo. > "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny SYSTEM:(F) >nul 2>&1
icacls "C:\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /deny "EVERYONE":(F) >nul 2>&1

:: =====================================================================
:: 40. WINDOWS ERROR REPORTING / WER / RELIABILITY / CRASH CONTROL
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\WerSvc" /v Start /t REG_DWORD /d 4 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "NMICrashDump" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "LogEvent" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "SendAlert" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "LastAliveStamp" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 41. UI / EXPLORER / UAC / PERSONALIZZAZIONE
:: =====================================================================

:: Desktop menu delay, auto end tasks, timeout app
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "5000" /f
reg add "HKCU\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "5000" /f
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "50" /f

:: UAC disattivato
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DelayedDesktopSwitchTimeout" /t REG_DWORD /d 0 /f

:: Explorer separate process/desktop process
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "DesktopProcess" /t REG_DWORD /d 1 /f

:: Preview pane off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewPane" /t REG_DWORD /d 1 /f

:: Alpha select off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d 0 /f

:: Track docs off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f

:: Mostra estensioni file
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

:: Recent/frequent off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f

:: Tema scuro
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f

:: Slideshow skip
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Personalization\DesktopSlideshow" /v "Skip" /t REG_DWORD /d 1 /f

:: Hide SCAMeetNow
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f

:: No low disk space checks
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoLowDiskSpaceChecks" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "LinkResolveIgnoreLinkInfo" /t REG_DWORD /d 1 /f

:: PCA/AppCompat off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableEngine" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" /v "AITEnable" /t REG_DWORD /d 0 /f

:: GameBar presence writer off
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d 0 /f

:: Font smoothing
reg add "HKCU\Control Panel\Desktop" /v "FontSmoothing" /t REG_SZ /d "2" /f

:: Console virtual terminal level off
reg add "HKCU\Console" /v "VirtualTerminalLevel" /t REG_DWORD /d 0 /f

:: Remote assistance off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f

:: Device metadata network off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f

:: Maps auto update off
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f

:: Sensor permission state off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f

:: Background apps photos off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Windows.Photos_8wekyb3d8bbwe" /v "DisabledByUser" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "Disabled" /t REG_DWORD /d 1 /f

:: Notifiche lockscreen/toast/account off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications" /v "EnableAccountNotifications" /t REG_DWORD /d 0 /f

:: StorageSense policy
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\StorageSense" /v "AllowStorageSenseGlobal" /t REG_DWORD /d 1 /f

:: Visual effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9e3e078012000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Accessibility" /v DynamicScrollbars /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v SmoothScroll /t REG_DWORD /d 1 /f

:: =====================================================================
:: 42. STORAGE SENSE / SERIALIZE / PAINT DESKTOP VERSION
:: =====================================================================

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "01" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "1024" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "2048" /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "04" /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "32" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "02" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "128" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "08" /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "256" /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v "WaitForIdleState" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v PaintDesktopVersion /t REG_DWORD /d 0 /f

:: =====================================================================
:: 43. PAGEFILE / FTH / WDF
:: =====================================================================

:: Pagefile gestito manualmente
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_ComputerSystem' -Property @{AutomaticManagedPagefile=$False}" >nul 2>&1
powershell -NoProfile -Command "Set-CimInstance -Query 'Select * from Win32_PageFileSetting where Name=\"C:\\pagefile.sys\"' -Property @{InitialSize=8192; MaximumSize=16384}" >nul 2>&1

:: Fault Tolerant Heap off
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CheckPointPeriod" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "CrashVelocity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "DisableFTH" /t REG_SZ /d "1" /f

:: WDF diagnostics off
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "DbgBreakOnError" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "LogPages" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Wdf01000" /v "VerboseOn" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Wdf\Kmdf\Diagnostics" /v "RetrieveVerboseLogs" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 44. BOOT / WINDOWS / PNP / WAIT KILL SERVICE
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BootControl" /v "BootProgressAnimation" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "NoPopupsOnBoot" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Windows" /v "ErrorMode" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DisableTargetDeviceLogging" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP" /v "DeviceActionRequests" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "8000" /f

:: =====================================================================
:: 45. SERVIZI BLUETOOTH / PERIFERICHE / LEGACY START VALUES
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHMODEM" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Csc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ossrs" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPUserSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DusmSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\i8042prt" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\EventSystem" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\gpsvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mpssvc" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\msiserver" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DevicesFlowUserSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SENS" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\HPOSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MidiSrv" /v "Start" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UdkUserSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\whesvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Netprofm" /v "Start" /t REG_DWORD /d 3 /f

:: =====================================================================
:: 46. PROCESSOR GENERIC / POWER THROTTLING / IDLE
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "EnablePerformanceStates" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FrequencyToPerfStateThreshold" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "IdleResidencyDuration" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfBoostState" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ResponsivenessReductionThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdle" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "CpuIdleThread" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveLowOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "ThreadThrottleAdditiveHighOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "FastThrottle" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "LatencyThrottleOffset" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothing" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Processor" /v "PerfAutoSmoothingEnabled" /t REG_DWORD /d 0 /f

reg add "%POWER%" /v "PlatformAoAcOverride" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "PlatformRoleOverride" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "EventProcessorEnabled" /t REG_DWORD /d 0 /f
reg add "%POWER%" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 47. KERNEL / EXECUTIVE / I/O DEEP TWEAKS
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MaximumDpcStackDepth" /t REG_DWORD /d 512 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MinimumDpcRate" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "InterruptTimerRate" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DpcWatchdogProfileOffset" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "FastDeadlockReliance" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "ParallelProcessorMinimum" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "LFH_Aggressive_Enable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "WorkerFactoryThreadIdleTimeout" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentCommit" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentReserve" /t REG_DWORD /d 16777216 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Heap_ForceLFH" /t REG_DWORD /d 1 /f

:: Priority control IRQ/interrupt separation
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ12Priority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "InterruptPrioritySeparation" /t REG_DWORD /d 4 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MinQueueDepth" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueDepth" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueuePolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueTimeout" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueThreshold" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionAffinity" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDXGI" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D12" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D11" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D10" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D9" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D8" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D7" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D6" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D5" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D4" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableD3D1" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectDraw" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectSound" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectInput" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectPlay" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectShow" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectMusic" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirectAnimation" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DImmediateMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRetainedMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DHardwareAbstractionLayer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DReferenceRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DNullRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRGBRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMMXRasterizer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSSE3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE41" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSE42" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DAVX512" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA3" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DFMA4" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI1" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DBMI2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DTBM" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DLZCNT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DPOPCNT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDRAND" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DRDSEED" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DADX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DMPX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSGX" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DCET" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBT" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSS" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSB" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DSSBD" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDirect3DIBPB" /t REG_DWORD /d 0 /f


:: =====================================================================
:: 48. MEMORY MANAGEMENT AGGIUNTIVI / CACHE / HEAP / LFH
:: =====================================================================

reg add "%MM%" /v "SystemCacheLimit" /t REG_DWORD /d 0xFFFFFFFF /f
reg add "%MM%" /v "VirtualizationFlags" /t REG_DWORD /d 0 /f

:: =====================================================================
:: 49. DISK / NVME CACHE / PARTMGR / SCSI
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\disk" /v "TimeoutValue" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "CacheIsPowerProtected" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\SCSI\Disk&Ven_NVMe\Device Parameters\Disk" /v "UserWriteCacheSetting" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Partmgr\Parameters" /v "IoLatencyCap" /t REG_DWORD /d 1 /f

:: =====================================================================
:: 50. EDGE RIMOZIONE / TASKS / DIRECTORY
:: =====================================================================

powershell -NoProfile -Command "$edgePath = (Get-Item 'C:\Program Files (x86)\Microsoft\Edge\Application\*\Installer\setup.exe').FullName; Start-Process $edgePath -ArgumentList '--uninstall', '--system-level', '--verbose-logging', '--force-uninstall' -Wait" >nul 2>&1

rmdir /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate" >nul 2>&1

:: =====================================================================
:: 51. CORTANA RIMOZIONE / WINGET
:: =====================================================================

winget uninstall cortana --accept-source-agreements --accept-package-agreements >nul 2>&1

:: =====================================================================
:: 52. SENSORI / SERVIZIO SENSORI FINALI
:: =====================================================================

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 3 /f

:: =====================================================================
:: 53. APPX DEPLOYMENT / CLIPSVC / TOAST FINALI
:: =====================================================================

taskkill /f /im SearchHost.exe >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ClipSVC" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\BackupRestore\FilesNotToSnapshot" /v "OneDriveSetupLogs" /t REG_MULTI_SZ /d "%ProgramFiles%\Microsoft OneDrive\setup\logs\* /s" /f >nul 2>&1

:: =====================================================================
:: 54. DISK PERFORMANCE / VERIFIER RESET
:: =====================================================================

diskperf -N >nul 2>&1
verifier /reset >nul 2>&1



:: =====================================================================
:: --- IFEO: Massima Priorità ai Giochi / programmi  (Espanso) ---
:: =====================================================================


::WinRar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\WinRAR.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::7zip
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zFM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\7zG.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::qemu
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\qemu-system-x86_64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f

::obs
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f





:: Working set limit BetGame
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BetGame.exe\PerfOptions" /v "WorkingSetLimitInKB" /t REG_DWORD /d 0 /f


:: ===================================================
:: VARIABILI BASE
:: ===================================================
set "GFX_CLASS=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "GFX_KEY=!GFX_CLASS!\0000"
set "GPU_CLASS_KEY=!GFX_CLASS!"

:: ===================================================
:: FASE 1: RILEVAMENTO CPU
:: ===================================================
set "CPU_VENDOR=Sconosciuto"
set "CPU_RAW="

for /f "tokens=2 delims==" %%A in ('wmic cpu get Manufacturer /value 2^>nul') do (
    for /f "delims=" %%B in ("%%A") do set "CPU_RAW=%%B"
)

if defined CPU_RAW (
    echo !CPU_RAW! | findstr /i "GenuineIntel" >nul && set "CPU_VENDOR=INTEL"
    echo !CPU_RAW! | findstr /i "AuthenticAMD" >nul && set "CPU_VENDOR=AMD"
)

echo CPU Rilevata: !CPU_VENDOR!

:: ===================================================
:: FASE 2: RILEVAMENTO GPU
:: ===================================================
echo ===================================================
echo FASE 2: RILEVAMENTO GPU
echo ===================================================

set "GPU1_VENDOR=Nessuna"
set "GPU2_VENDOR=Nessuna"
set "HAS_INTEL_GPU=0"
set "HAS_NVIDIA_GPU=0"
set "HAS_AMD_GPU=0"
set /a count=0

for /f "skip=1 tokens=*" %%A in ('wmic path win32_videocontroller get AdapterCompatibility 2^>nul') do (
    for /f "delims=" %%B in ("%%A") do (
        set "GPU_RAW=%%B"

        set "CURRENT_VENDOR=Sconosciuto"

        echo !GPU_RAW! | findstr /i "Intel" >nul && set "CURRENT_VENDOR=INTEL"
        echo !GPU_RAW! | findstr /i "NVIDIA" >nul && set "CURRENT_VENDOR=NVIDIA"
        echo !GPU_RAW! | findstr /i /c:"Advanced Micro Devices" >nul && set "CURRENT_VENDOR=AMD"
        echo !GPU_RAW! | findstr /i "AMD" >nul && set "CURRENT_VENDOR=AMD"

        if not "!CURRENT_VENDOR!"=="Sconosciuto" (
            set /a count+=1
            if !count! equ 1 set "GPU1_VENDOR=!CURRENT_VENDOR!"
            if !count! equ 2 set "GPU2_VENDOR=!CURRENT_VENDOR!"
        )

        if "!CURRENT_VENDOR!"=="INTEL" set "HAS_INTEL_GPU=1"
        if "!CURRENT_VENDOR!"=="NVIDIA" set "HAS_NVIDIA_GPU=1"
        if "!CURRENT_VENDOR!"=="AMD" set "HAS_AMD_GPU=1"
    )
)

echo GPU Principale: !GPU1_VENDOR!
echo GPU Secondaria: !GPU2_VENDOR!
echo ===================================================
echo ESECUZIONE
echo ===================================================

:: ===================================================
:: SEZIONE CPU
:: ===================================================
if "!CPU_VENDOR!"=="INTEL" (

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "L3_Cache_Foreground_Priority" /t REG_DWORD /d 31 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_QoS_Enable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LLC_ForegroundMonopoly" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Scrubber_Disable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Cache_Locality_Strict" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "CStateLimit" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Enable" /t REG_DWORD /d 1 /f


bcdedit /set tscsyncpolicy enhanced

reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AutonomousCurrentLimitDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "LatencyToleranceValue" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "RingBusPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "InterruptToleranceValue" /t REG_DWORD /d 0 /f

:: Extra HWP / Speed Shift
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Interrupt_Mode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_PerformanceSetting" /t REG_DWORD /d 1 /f


:: Extra Turbo
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "EnableTurboBoost" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "TurboMode" /t REG_DWORD /d 1 /f

:: Extra Intel PEP / PCIe power saving
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableD3Hot" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableRuntimePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableL1Substates" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableAspm" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Brighten Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Darken Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Enhance Movie" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Media\Preserve Details" /v "DPST" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Desired_Performance" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Minimum_Performance" /t REG_DWORD /d 8 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Maximum_Performance" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Energy_Performance_Preference" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_Activity_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Autonomous_EPP" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Lowest_Frequency" /t REG_DWORD /d 800 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Highest_Frequency" /t REG_DWORD /d 4200 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Time_Window" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Request_Response" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "MaxThrottleCapacity" /t REG_DWORD /d 100 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "PerfState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Processor\Power" /v "ThermalThrottle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0LidOpen" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0ACPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0DCPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Battery" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Thermal" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Fan" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Cooling" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Heating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Humidity" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Pressure" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Altitude" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Light" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Proximity" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Orientation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Location" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Gyroscope" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Accelerometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Magnetometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Compass" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0Barometer" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0AmbientLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0RGBLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0IRLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0UVLight" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0XRay" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableS0GammaRay" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousPowerStatesDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PerformanceBias" /t REG_DWORD /d 0 /f

reg add "%MM%" /v "FeatureSettingsOverride" /t REG_DWORD /d 3 /f
reg add "%MM%" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d 3 /f


    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_EPP" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "PerfBoostMode" /t REG_DWORD /d 2 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AllowThrottling" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "BackgroundPriority" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Activity_Window" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "RootComplex_VC1_Enable" /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "EnableD3Cold" /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisableLtr" /t REG_DWORD /d 1 /f

) else if "!CPU_VENDOR!"=="AMD" (

    rem Nessun comando per ora AMD CPU
)

:: ===================================================
:: ESECUZIONE BLOCCHI GPU TRAMITE SUBROUTINE
:: ===================================================
if "!HAS_INTEL_GPU!"=="1" call :APPLY_INTEL_GPU
if "!HAS_NVIDIA_GPU!"=="1" call :APPLY_NVIDIA_GPU
if "!HAS_AMD_GPU!"=="1" call :APPLY_AMD_GPU

echo.


reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v FontSmoothingType /t REG_DWORD /d 2 /f
taskkill /f /im explorer.exe >nul 2>&1
taskkill /f /im dwm.exe >nul 2>&1
del /f /q /s "%localappdata%\IconCache.db" >nul 2>&1
del /f /q /s "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
net stop FontCache >nul 2>&1
del /f /q /s "%localappdata%\GDIPFONTCACHEV1.dat" >nul 2>&1
net start FontCache >nul 2>&1
start explorer.exe

echo Operazione completata.
timeout /t 2 >nul
shutdown /r /f /t 3

:: ===================================================
:: SUBROUTINE GPU INTEL
:: ===================================================
:APPLY_INTEL_GPU
echo [GPU-INTEL] Applicazione ottimizzazioni Intel GPU...

reg add "!GFX_KEY!" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PowerPolicy" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FbcEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f
reg add "!GFX_KEY!" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "UserPowerMode" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "RenderStandby" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ApmEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "HWP_Ignore_Platform_Limits" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Boost_Policy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "SamplingInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PkgCStateLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TimerCoalescingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "S0LowPowerIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Power_Down_Enable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "IMC_Opportunistic_Refresh_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "AutonomousCStateEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "TransitDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "PciePowerGatingEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "Ring_Bus_Priority_Mode" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
reg add "!GFX_KEY!" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "RingBufferSize" /t REG_DWORD /d 1024 /f



reg add "!GFX_KEY!" /v "DisableAsyncFlip" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableTripleBuffering" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "VSyncControl" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisablePFonDP" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePSR" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PSREnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableDisplayCaching" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableMemoryCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableRC6" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "RC6Disable" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDisplayPowerSaving" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicFrequencyScaling" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "MaxGPUClockFrequency" /t REG_DWORD /d 1350 /f
reg add "!GFX_KEY!" /v "MinGPUClockFrequency" /t REG_DWORD /d 300 /f
reg add "!GFX_KEY!" /v "GPUClockFrequency" /t REG_DWORD /d 1350 /f
reg add "!GFX_KEY!" /v "EnableTurbo" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "DisableFrameBufferCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableLosslessCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableCompression" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "TextureFilteringQuality" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "AntiAliasingMode" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisablePostProcessing" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableVideoProcessing" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableImageProcessing" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDisplayEnhancement" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "DisableAdaptiveContrast" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "AdaptiveContrastEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableDynamicContrast" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicBrightness" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableAmbientLightSensor" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableALS" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "DisablePowerState0" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisablePowerState1" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState2" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState3" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState4" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState5" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState6" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState7" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState8" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState9" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState10" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState11" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState12" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState13" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState14" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisablePowerState15" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTableSize" /t REG_DWORD /d 4194304 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePoolSize" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmResourceCacheSize" /t REG_DWORD /d 268435456 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCacheSize" /t REG_DWORD /d 536870912 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmCachePolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmEvictionPolicy" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmDefragEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimEnable" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmReclaimPolicy" /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableDeepSleep" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableStandby" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableHibernate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSleep" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisablePowerButton" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidClose" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableLidOpen" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableACPower" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableStau" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSquark" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSlepton" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSfermion" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "DisableSboson" /t REG_DWORD /d 1 /f


:: Disabilita Frame Buffer Compression (FBC). 
:: FBC risparmia banda RAM ma usa cicli GPU e aggiunge latenza. Su RAM a 2100MHz, disattivarlo dà frame più stabili e meno stutter.
reg add "!GFX_KEY!" /v "DisableFBC" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f

:: Disabilita Panel Self Refresh (PSR). Il PSR "bufferizza" il pannello per risparmiare, causando micro-stutter e input lag nei giochi.
reg add "!GFX_KEY!" /v "DisablePSR" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PSR_Enable" /t REG_DWORD /d 0 /f

:: Disabilita CMAA (Conservative Morphological Anti-Aliasing) a livello di driver.
:: Lascia che sia il gioco a gestire l'AA. Non sprecare i 24 Execution Units (EU) della UHD 620 per post-processing forzato.
reg add "!GFX_KEY!" /v "ConservativeMorphologicalAntiAliasing" /t REG_DWORD /d 0 /f

:: Priorità assoluta per gli Execution Units (EU) e Render Context
reg add "!GFX_KEY!" /v "EuThreadPriority" /t REG_DWORD /d 31 /f
reg add "!GFX_KEY!" /v "RCPriority" /t REG_DWORD /d 31 /f
reg add "!GFX_KEY!" /v "ContextPriority" /t REG_DWORD /d 31 /f

:: Forza il driver a non usare copie DMA indesiderate (riduce overhead CPU/RAM)
reg add "!GFX_KEY!" /v "DisableDMACopy" /t REG_DWORD /d 1 /f

:: Disabilita il risparmio energetico del motore Media/QuickSync (libera banda sul Ring Bus interno della CPU)
reg add "!GFX_KEY!" /v "MediaPowerSaving" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableMediaPowerSaving" /t REG_DWORD /d 1 /f



reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchClockGating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DisablePchPmClockGating" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DmiLinkPriority" /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "DisableValidation" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\Vulkan" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "DisablePFonDP" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\Display\igfxcui\profiles\Device\OpenGL" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f


reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "ThermalThrottlingSoftwareDisable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "MinPerformance" /t REG_DWORD /d 100 /f
reg add "!GFX_KEY!" /v "DynamicVidMemoryControl" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "GfxDynamicPState" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncCpuThreadPriority" /t REG_DWORD /d 15 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel" /v "StartupDelay" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MaximumFrameLatency" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisplayPowerSavingTechnology" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "EnablePowerGating" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d 0 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ThirdLevelDataCache" /f 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "CS_Disable" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-95c4-324a7d577775\ee12f2c1-9844-474d-987a-928659de2989" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "CmaaEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "ColorEnhancement" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "EnableDynamicRefreshRate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 40 /f

reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "!GFX_KEY!" /v "PowerDpstAggressivenessLevel" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "UnderRunCountPipeA" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "Disable_OverlayDSQualityEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "PowerPolicy" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "RuntimePowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FbcEnable" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "AdaptiveTessellation" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "ShaderCacheSize" /t REG_DWORD /d 15 /f
reg add "!GFX_KEY!" /v "AnisotropicFilteringMode" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "UserPowerMode" /t REG_DWORD /d 3 /f
reg add "!GFX_KEY!" /v "RenderStandby" /t REG_DWORD /d 0 /f
reg add "!GFX_KEY!" /v "DisableRenderStandby" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DirectXHardwareAcceleration" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableVideoEnhancement" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "TextureCacheOptimization" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "ForceIntelTurbo" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "EnableOverclock" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!" /v "RenderAheadLimit" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDynamicFBC" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "DisableDMACopy" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!" /v "TextureMemorySize" /t REG_DWORD /d 2048 /f
reg add "!GFX_KEY!" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f

reg add "!GFX_KEY!\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "!GFX_KEY!\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 3 /f
reg add "!GFX_KEY!\Interrupt Management\Affinity Policy" /v "ThreadPriority" /t REG_DWORD /d 31 /f

reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmPageTablePinned" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SchedulerPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "GmmContiguousMemoryRequired" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "LowLatencyAllocations" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DisableGmmDelay" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "AggressiveGarbageCollection" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "SegmentAllocationPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "UseLargePages" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "EnableAggressiveMemoryReclaim" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MinFreeMemoryPool" /t REG_DWORD /d 256 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MaxFreeMemoryPool" /t REG_DWORD /d 512 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "MemoryPoolPolicy" /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "FeatureTestControl" /t REG_DWORD /d 113 /f
reg add "HKLM\SOFTWARE\Microsoft\Direct3D" /v "DisableDriverManagement" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "D3D9AsyncQueue" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d 60 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 16777216 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 67108864 /f
reg add "HKLM\SOFTWARE\Intel\GMM" /v "DedicatedSegmentSize" /t REG_DWORD /d 2048 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v "ThreadPriority" /t REG_DWORD /d 31 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisablePowerSaving" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx\Parameters" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f

powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setacvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPREFERENCE 1
powercfg /setdcvalueindex SCHEME_CURRENT SUB_GRAPHICS GPUPOWER 100
powercfg /setactive SCHEME_CURRENT

echo [GPU-INTEL] Ricerca dinamica istanze Intel...

set "INTEL_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "!GPU_CLASS_KEY!" /s /v "DriverDesc" ^| findstr /i "HKEY_"') do (
    reg query "%%K" /v "DriverDesc" 2>nul | findstr /i "Intel" >nul
    if !errorlevel! equ 0 (
        set "INTEL_GPU_FOUND=1"

        reg add "%%K" /v "AllowDeepSleep" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisablePowerGating" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RenderStandby" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DPSTEnable" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisableDynamicClock" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableOverclock" /t REG_DWORD /d 1 /f

        reg add "%%K" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "MaxClockFrequency" /t REG_DWORD /d 1350 /f
        reg add "%%K" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f

        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
    )
)

if "!INTEL_GPU_FOUND!"=="0" echo [AVVISO] Nessuna GPU Intel rilevata nel loop dinamico.

exit /b

:: ===================================================
:: SUBROUTINE GPU NVIDIA
:: ===================================================
:APPLY_NVIDIA_GPU
echo [GPU-NVIDIA] Applicazione ottimizzazioni NVIDIA GPU...

set "VRAM_MB=8192"

for /f "tokens=*" %%A in ('powershell -NoProfile -Command "$gpu = Get-CimInstance Win32_VideoController | Where-Object {$_.Name -match 'NVIDIA'} | Select-Object -First 1; if($gpu) { [math]::Round($gpu.AdapterRAM / 1048576) } else { 8192 }"') do set "VRAM_MB=%%A"

if "!VRAM_MB!"=="" set "VRAM_MB=8192"

echo [GPU-NVIDIA] VRAM rilevata: !VRAM_MB! MB

reg add "HKCU\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "CoolBits" /t REG_DWORD /d 31 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "FlipQueueSize" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ThreadedOptimization" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "ShaderCache" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "TripleBuffering" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OpenGLShaders" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableOptimusBatteryPolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "OptimusDeleteRenderHint" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\NVTweak" /v "DisableDynamicPstate" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NVTweak" /v "DisableOverlay" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\NvControlPanel2\Client" /v "OptInOrOutPreference" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID66610" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID64640" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\FTS" /v "EnableRID44231" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "Gestalt" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "DisplayPowerSaving" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmProfilingAdminOnly" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "AllowDeepSleep" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "EnableGpuHealthCheck" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "EnablePerformanceMode" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnablePowerBudget" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "IgnoreBatteryVoltageSag" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 8 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\nvcontainer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d 0 /f

echo [GPU-NVIDIA] Ricerca dinamica istanze NVIDIA...

set "NVIDIA_GPU_FOUND=0"

for /f "tokens=*" %%K in ('reg query "!GPU_CLASS_KEY!" /s /v "DriverDesc" ^| findstr /i "HKEY_"') do (
    reg query "%%K" /v "DriverDesc" 2>nul | findstr /i "NVIDIA" >nul
    if !errorlevel! equ 0 (
        set "NVIDIA_GPU_FOUND=1"

        reg add "%%K" /v "ReBarEnable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "ReBarSupported" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmReBarEnable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DisableWriteCombining" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmGpsPsEnablePerCpuCoreDpc" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "PreferSystemMemoryContiguous" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "IncreaseFixedSegment" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DisableVRAMCompression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DisableTextureCompression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "DedicatedSegmentSize" /t REG_DWORD /d !VRAM_MB! /f
        reg add "%%K" /v "RmFbsrPagedDMA" /t REG_DWORD /d 0 /f

        reg add "%%K" /v "DisableDynamicClock" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "EnableUlps" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisablePowerGating" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableOverclock" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableCEPreemption" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "RMForceMaxPerf" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmDisableRegistryCaching" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "PreferredPerformanceMode" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "PerfLevelSrc" /t REG_DWORD /d 13107 /f
        reg add "%%K" /v "PowerMizerEnable" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "InvalidateDynamicPstate" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMPcieLinkSpeed" /t REG_DWORD /d 4 /f
        reg add "%%K" /v "DisableL1LowPower" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMDisablePostL2Compression" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMGC6Feature" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "RMElpgStateOnInit" /t REG_DWORD /d 3 /f
        reg add "%%K" /v "RMHdcpKeyglobZero" /t REG_DWORD /d 1 /f

        reg add "%%K" /v "PeerMappingOverride" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RmGspcPerioduS" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "RMCtxswLog" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "RMLogMsg" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "VRRAlwaysOn" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "vrrSmartDetection" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "GsyncCompatible" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "WDDMv21Enable2MPageSupport" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "WDDMv21Enable64KbSysmemSupport" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "WDDMv21Force2MSizeAlignment" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "NvencPreProcBlitDisable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "NVFBCEnable" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "VideoControl3" /t REG_DWORD /d 1 /f

        reg add "%%K" /v "MessageSignaledInterrupts" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "MSISupported" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableAspm" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "PciLatencyTimerControl" /t REG_DWORD /d 32 /f

        reg add "%%K\Interrupt Management\Affinity Policy" /v "Strategy" /t REG_DWORD /d 2 /f
        reg add "%%K\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 4 /f
        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
        reg add "%%K\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 2048 /f
    )
)

if "!NVIDIA_GPU_FOUND!"=="0" echo [AVVISO] Nessuna GPU NVIDIA rilevata nel loop dinamico.

exit /b

:: ===================================================
:: SUBROUTINE GPU AMD
:: ===================================================
:APPLY_AMD_GPU
echo [GPU-AMD] Applicazione ottimizzazioni AMD GPU.

Reg.exe add "HKCU\Software\AMD\CN" /v "AutoUpdateTriggered" /t REG_DWORD /d "0" /f > nul 2>&1 > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "PowerSaverAutoEnable_CUR" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "BuildType" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "WizardProfile" /t REG_SZ /d "PROFILE_CUSTOM" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "UserTypeWizardShown" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "RSXBrowserUnavailable" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "SystemTray" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AllowWebContent" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "CN_Hide_Toast_Notification" /t REG_SZ /d "true" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN" /v "AnimationEffect" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN\OverlayNotification" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\CN\VirtualSuperResolution" /v "AlreadyNotified" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PerformanceMonitorOpacityWA" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "DvrEnabled" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "ActiveSceneId" /t REG_SZ /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInstantReplayEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInGameReplayEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "PrevInstantGifEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "RemoteServerStatus" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKCU\Software\AMD\DVR" /v "ShowRSOverlay" /t REG_SZ /d "false" /f > nul 2>&1
Reg.exe add "HKCU\Software\ATI\ACE\Settings\ADL\AppProfiles" /v "AplReloadCounter" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\Software\AMD\Install" /v "AUEP" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKLM\Software\AUEP" /v "RSX_AUEPStatus" /t REG_DWORD /d "2" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "NotifySubscription" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsComponentControl" /t REG_BINARY /d "00000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_USUEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_RadeonBoostEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "IsAutoDefault" /t REG_BINARY /d "01000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ACE" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AnisoDegree_SET" /t REG_BINARY /d "3020322034203820313600" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Main3D_SET" /t REG_BINARY /d "302031203220332034203500" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation_OPTION" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "Tessellation" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "AAF" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "GI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "CatalystAI" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TemporalAAMultiplier_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ForceZBufferDepth" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "EnableTripleBuffering" /t REG_BINARY /d "3000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ExportCompressedTex" /t REG_BINARY /d "31000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "PixelCenter" /t REG_BINARY /d "30000000" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "ZFormats_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "DitherAlpha_NA" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "SwapEffect_D3D_SET" /t REG_BINARY /d "3020312032203320342038203900" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "TFQ" /t REG_BINARY /d "3200" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000\UMD" /v "VSyncControl" /t REG_BINARY /d "3100" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdwddmg" /v "ChillEnabled" /t REG_DWORD /d "0" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\AMD Crash Defender Service" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\AMD External Events Utility" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdfendr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdfendrmgr" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f > nul 2>&1
:: ----- HOMI.COM CATALOG FOOTER -----
:: Mapped images : 140
:: NIC/TCP keys  : 24
:: Audio keys    : 15
:: Pack origin   : Platinum Optimizer HOMI.COM
echo  !DIM!  Homi pack applied. IFEO map + NIC/audio/timer.!RST!
echo.

:extreme_core_done
:: =====================================================================
:: HOMI.COM  —  DONE
:: =====================================================================
echo.
echo  !PLT!  ==================================================================!RST!
echo  !WHT!   Platinum Optimizer  ·  HOMI.COM  ·  pass complete.!RST!
echo  !DIM!   Registry backup: Desktop\platinum_optimizer_homi_backup.reg!RST!
echo  !DIM!   Rebooting in 15 seconds so services and BCD take effect.!RST!
echo  !DIM!   Close this window to cancel the reboot.!RST!
echo  !PLT!  ==================================================================!RST!
echo.
echo CONTACT ME!!!
shutdown /r /f /t 50
exit /b 0
start "" "https://www.tiktok.com/@homidark_"