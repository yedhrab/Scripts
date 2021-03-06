; v1.1.31.01'de tüm desktoplarda çalışır

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
    
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent
Menu, Tray, NoStandard
Menu, Tray, Add, YEmreAk, IconClicked
Menu, Tray, Add, Temizle, ClearAll
Menu, Tray, Add, Kapat, CloseApp

; Gizlenmiş pencereler
HidedCount := 0
KnownIds := []
HidedWinId := []
HidedWinTitle := []
HidedWinIconPath := []

UpdateTrayMenu()
return

ClearAll:
    global HidedWinId, HidedCount
    Loop, %HidedCount%
    {
        ahkID := HidedWinId[HidedCount]
        ShowFromTrayWıthId(ahkID)
        WinClose, ahk_id %ahkID%
    }
return

CloseApp:
    ReleaseAllWindows()
    ExitApp
return

MenuHandler:
    global HidedWinId, HidedWinTitle
    For index, value in HidedWinTitle
    {
        If (value == A_ThisMenuItem)
        {
            ahkId := HidedWinId[index]
            ShowFromTrayWıthId(ahkId)
        }
    }
return

IconClicked:
    Run, https://www.yemreak.com
Return

ReleaseAllWindows()
{
    global KnownIds, HidedWinId, HidedCount
    
    Loop, %HidedCount%
        ShowFromTrayWıthId(HidedWinId[HidedCount])
}

CaptureKnowedWindows()
{
    global KnownIds, HidedWinId, HidedWinTitle, HidedWinIconPath
    DetectHiddenWindows, Off
    
    For index, value in KnownIds
    {
        IfWinExist, ahk_id %value%
        {
            WinRestore, ahk_id %value%
            WinActivate, ahk_id %value%
            WinWaitActive, ahk_id %value% ; Ekrana odaklanmadan gelirse hata verir
            KeepActivatedWindowInTray()
        }
    }
}

UpdateTrayMenu(index = 0)
{
    iconPath = C:\Users\Yedhrab\Google Drive\Pictures\Icons\Ico\ylogo-dark.ico
    title = YEmreAk
    
    global HidedCount
    if (HidedCount != 0)
    {
        if (index == 0)
            index = HidedCount
        
        global HidedWinTitle, HidedWinIconPath
        iconPath := HidedWinIconPath[index]
        title := HidedWinTitle[index]
    }
    
    IfExist %iconPath%
        Menu, Tray, Icon, %iconPath%, 1
    Menu, Tray, Default, %title%
    Menu, Tray, Delete, Kapat
    Menu, Tray, Delete, Temizle
    Menu, Tray, Add, Temizle, ClearAll
    Menu, Tray, Add, Kapat, CloseApp
return
}

RunIfExist(url)
{
    Run, %url%, , , ahkPID
    ; WinActivate, ahk_pid ahkPID
    ; WinWaitActive, ahk_pid ahkPID
    ; WinGet, ahkID, ID, A
    ; AppendToKnownIds(ahkID)
}

AppendToKnownIds(ahkId)
{
    global KnownIds
    
    save := True
    For index, value in KnownIds
    {
        if (value == ahkId)
        {
            save := False
            break
        }
    }
    if (save)
        KnownIds.Push(ahkId)
}

AppendToArray(ahkId, title, iconPath)
{
    global HidedWinId, HidedWinTitle, HidedWinIconPath, HidedCount
    HidedWinId.Push(ahkId)
    HidedWinTitle.Push(title)
    HidedWinIconPath.Push(iconPath)
    HidedCount++
    
return HidedCount ; Diziler 1'den başlar
}

AppendToMenu(index)
{
    global HidedWinTitle
    title := HidedWinTitle[index]
    
    Menu, Tray, Add, %title%, MenuHandler
}

KeepInMem(ahkId, title, iconPath)
{
    index := AppendToArray(ahkId, title, iconPath)
    AppendToMenu(index)
    UpdateTrayMenu(index)
}

RemoveFromArray(index)
{
    global HidedWinId, HidedWinTitle, HidedWinIconPath, HidedCount
    HidedWinId.RemoveAt(index)
    HidedWinTitle.RemoveAt(index)
    HidedWinIconPath.RemoveAt(index)
    HidedCount--
    
return HidedCount ; Diziler 1'den başlar
}

RemoveFromMenu(index)
{
    global HidedWinTitle
    title := HidedWinTitle[index]
    Menu, Tray, Delete, %title%
}

RemoveFromMem(ahkId)
{
    global HidedWinId
    For index, value in HidedWinId
    {
        if(value == ahkId)
        {
            RemoveFromMenu(index)
            RemoveFromArray(index)
            UpdateTrayMenu(index - 1)
            break
        }
    }
return
}

ShowFromTrayWıthId(ahkId)
{
    WinRestore, ahk_id %ahkId%
    WinShow, ahk_id %ahkId%
    
    WinActivate, ahk_id %ahkId%
    WinWaitActive, ahk_id %ahkId%
    
    RemoveFromMem(ahkId)
    AppendToKnownIds(ahkId)
}

KeepActivatedWindowInTray()
{
    WinGetActiveTitle, title
    WinGet, ahkId, ID, A
    WinGet, iconPath, ProcessPath, A
    
    WinHide, A
    KeepInMem(ahkId, title, iconPath)
}

RestoreFocus()
{
    SendEvent, !{Esc} ; Bir önceki pencereye odaklanma
}

ToogleTrayWithId(ahkId, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, Off
    IfWinNotExist, ahk_id %ahkId%
        ShowFromTrayWıthId(ahkId)
    else
    {
        IfWinActive, ahk_id %ahkId%
        {
            KeepActivatedWindowInTray()
            RestoreFocus()
        }
        else
            WinActivate ahk_id %ahkId%
    }
}

ToggleWindow(windowName)
{
    WinGet, WinState, MinMax, %windowName%
    if (WinState == -1)
    {
        WinRestore, %windowName%
        WinActivate, %windowName%
    }
    else
    {
        IfWinActive, %windowName%
        {
            WinMinimize, %windowName%
            ; Tureng için 2 tane pencere açılıyor
            if(windowName = "Tureng Dictionary")
            {
                WinMinimize, %windowName%
            }
        }
        else
        {
            WinActivate, %windowName%
        }
        
    }
    
return
}

CreateWinByTrayWithClass(className, url, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    
    found := False
    WinGet, id, list, ahk_class %className%
    Loop, %id%
    {
        this_ID := id%A_Index%
        IfWinExist ahk_id %this_ID%
        {
            WinGetTitle, title
            If (title = "")
                continue
            
            ToogleTrayWithId(this_ID, mode)
            found := True
        }
        
    }
    If (!found)
        RunIfExist(url)
        return
}

CreateWinByTrayWithExe(exeName, url, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    
    found := False
    WinGet, id, list, ahk_exe %exeName%
    Loop, %id%
    {
        this_ID := id%A_Index%
        IfWinExist ahk_id %this_ID%
        {
            WinGetTitle, title
            If (title = "")
                continue
            
            ToogleTrayWithId(this_ID, mode)
            found := True
        }
    }
    If (!found)
        RunIfExist(url)
        
return
}

CreateWinByTray(windowName, url, mode=3)
{
    SetTitleMatchMode, %mode%
    DetectHiddenWindows, On
    IfWinExist, %windowName%
    {
        WinGet, windowID, ID
        ToogleTrayWithId(windowID, mode)
    }
    else
    {
        RunIfExist(url)
        }
    
return
}

CreateWin(windowName, url, mode=3)
{
    
    SetTitleMatchMode, %mode%
    IfWinExist, %windowName%
        ToggleWindow(windowName)
    else
        RunIfExist(url)
        
return
}

;windowName=%A_ScriptName%ß
return

; Uygulama kısayolları Win ile başlar
#w::
    CreateWinByTray("WhatsApp", "shell:appsFolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!WhatsAppDesktop")
return

#g::
    CreateWinByTray("GitHub Desktop", "C:\Users\Yedhrab\AppData\Local\GitHubDesktop\GitHubDesktop.exe")
return

#q::
    CreateWin("- OneNote", "shell:appsFolder\Microsoft.Office.OneNote_8wekyb3d8bbwe!microsoft.onenoteim", 2)
return

#t::
    CreateWin("Tureng Dictionary", "shell:appsFolder\24232AlperOzcetin.Tureng_9n2ce2f97t3e6!App")
return

#e::
    CreateWinByTrayWithClass("CabinetWClass", "explorer.exe", 2)
return

#c::
    CreateWinByTray("Google Calendar", "C:\Users\Yedhrab\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Chrome Apps\Google Calendar.lnk", 2)
return

; #F1::
;     CreateWinByTrayWithExe("WindowsTerminal.exe", "wt")
; return

PgUp & e::
    ReleaseAllWindows()
return

PgUp & d::
    CaptureKnowedWindows()
return

; Dizin kısayolları PgDn ile başlar
PgDn & g::
    CreateWinByTray("GitHub", "C:\Users\Yedhrab\Documents\GitHub")
return
PgDn & s::
    CreateWinByTray("ShareX", "shell:appsFolder\19568ShareX.ShareX_egrzcvs15399j!ShareX", 2)
return
PgDn & Shift::
    CreateWinByTray("Startup", "shell:startup")
return
PgDn & i::
    CreateWinByTray("Icons", "C:\Users\Yedhrab\Google Drive\Pictures\Icons")
return
PgDn & d::
    CreateWinByTray("Downloads", "shell:downloads")
return
PgDn & u::
    CreateWinByTray("Yedhrab", "C:\Users\Yedhrab")
return

; Sık kullanılan karakterler de artık PgUp butonu ile çalışacaktır

Control & PgDn::
    Send , !{PgDn}
return
Control & PgUp::
    Send , !{PgUp}
return
