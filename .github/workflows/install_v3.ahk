#Requires AutoHotkey v2.0
#SingleInstance Force

if !A_IsAdmin {
    Run('*RunAs "' A_ScriptFullPath '"')
    ExitApp
}

tempDir := A_Temp "\library_setup"

if !DirExist(tempDir)
    DirCreate(tempDir)

nppFile := tempDir "\npp_installer.exe"
chromeFile := tempDir "\ChromeStandaloneSetup64.exe"
honeyZip := tempDir "\honeyview5.zip"

TrayTip("다운로드", "설치 파일 다운로드 중...", 1)

Download(
    "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.9.4/npp.8.9.4.Installer.x64.exe",
    nppFile
)

Download(
    "https://dl.google.com/chrome/install/standalonesetup64.exe",
    chromeFile
)

Download(
    "https://docs.google.com/uc?export=download&confirm=t&id=17eyI5c60mDmot_jpgaonjrQ0SahOX-6h",
    honeyZip
)

if FileExist(nppFile) {
    RunWait('"' nppFile '" /S', , "Hide")
}

if FileExist(chromeFile) {
    RunWait('"' chromeFile '" /silent /install', , "Hide")
}

honeyTarget := A_MyDocuments "\꿀뷰5"

if !DirExist(honeyTarget)
    DirCreate(honeyTarget)

if FileExist(honeyZip) {

    shell := ComObject("Shell.Application")

    zipObj := shell.NameSpace(honeyZip)
    targetObj := shell.NameSpace(honeyTarget)

    if zipObj && targetObj {
        targetObj.CopyHere(zipObj.Items(), 16)
    }
}

RegWrite(
    1,
    "REG_DWORD",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
    "Hidden"
)

RegWrite(
    1,
    "REG_DWORD",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
    "ShowSuperHidden"
)

RegWrite(
    0,
    "REG_DWORD",
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
    "HideFileExt"
)

RunWait('taskkill /f /im explorer.exe', , "Hide")

Sleep(1500)

Run('explorer.exe')

Run("ms-settings:typing")

Sleep(4000)

Send("{Tab 6}")
Sleep(300)

Send("{Enter}")

Sleep(1500)

Send("{Tab 5}")
Sleep(300)

Send("{Enter}")

Sleep(700)

SendText("세벌식 최종")

Sleep(500)

Send("{Enter}")

MsgBox(
    "모든 작업 완료`n`n"
    "- 노트패드++ 설치`n"
    "- 크롬 설치`n"
    "- 꿀뷰5 압축해제`n"
    "- 탐색기 옵션 적용`n"
    "- 세벌식 최종 선택 시도"
)
