; ===============================================================================================================================
; AHK Version ...: AHK_L 1.1.22.00 x64 Unicode
; Win Version ...: Windows 7 Professional x64 SP1
; Description ...: Windows Data Types for AHK
;                  (https://msdn.microsoft.com/en-us/library/aa383751.aspx)
; Version .......: v0.2
; Modified ......: 2015.05.04-1927
; Author ........: jNizM (+ just me for the translation)
; Licence .......: Unlicense (http://unlicense.org/)
; ===============================================================================================================================
;@Ahk2Exe-SetName Windows_Data_Types_for_AHK
;@Ahk2Exe-SetDescription Windows Data Types for AHK
;@Ahk2Exe-SetVersion v0.2
;@Ahk2Exe-SetCopyright Copyright (c) 2015-2015`, jNizM
;@Ahk2Exe-SetOrigFilename Windows_Data_Types_for_AHK.ahk
; ===============================================================================================================================

; GLOBAL SETTINGS ===============================================================================================================

#Warn
#NoEnv
#SingleInstance Force

global csv := DownloadToString("https://raw.githubusercontent.com/jNizM/AutoHotkey_MSDN_Types/master/src/Windows_Data_Types.csv")

; GUI ===========================================================================================================================

Gui +Resize -MaximizeBox
Gui, Font,, Courier New
Gui, Add, ListView, x5 y5 w500 h400 vLVData, % "Data Type|AHK Type|Alternative for DllCall()|MSDN Definition"
LV_ModifyCol(1, 155), LV_ModifyCol(2, 175), LV_ModifyCol(3, 187), LV_ModifyCol(4, 432)
Gui, Add, Edit, x5 y+1 w445 h23 hWndEditSearch gLVSearch vEditSearch
DllCall("user32.dll\SendMessage", "Ptr", EditSearch, "UInt", 0x1501, "Ptr", 1, "Str", "Search Data Type", "Ptr")
Gui, Add, Edit, x+5 yp w54 h23 0x800 vEditEntries
Gui, Show, AutoSize, % "Windows Data Types for AHK"
Gui, +LastFound
WinSet, Redraw

ListView:
    MSDN_TYPES_ARR := []
    loop, parse, csv, `n, `r
    {
        loop, parse, A_LoopField, csv
        {
            MSDN_TYPES_ARR := StrSplit(A_LoopField, ";")
            LV_Add("", MSDN_TYPES_ARR[1], MSDN_TYPES_ARR[2], MSDN_TYPES_ARR[3], MSDN_TYPES_ARR[4], MSDN_TYPES_ARR[5]), LV_ModifyCol(1, "Sort")
        }
    }
    GuiControl,, EditEntries, % LV_GetCount()
    GuiControl, Focus, EditSearch
return

; SCRIPT ========================================================================================================================

GuiSize:
    if (ErrorLevel)
        return
    GuiControl, Move, LVData, % "x5 y5 w" (A_GuiWidth - 10) " h" (A_GuiHeight - 40)
    GuiControl, Move, EditSearch, % "x5 y" (A_GuiHeight - 29) " w" (A_GuiWidth - 69)
    GuiControl, Move, EditEntries, % "x" (A_GuiWidth - 59) " y" (A_GuiHeight - 29)
return

LVSearch:
    Gui, Submit, NoHide
    LV_Delete(), MSDN_TYPES_ARR := []
    loop, parse, csv, `n, `r
    {
        loop, parse, A_LoopField, csv
        {
            MSDN_TYPES_ARR := StrSplit(A_LoopField, ";")
            if (InStr(MSDN_TYPES_ARR[1], EditSearch))
                LV_Add("", MSDN_TYPES_ARR[1], MSDN_TYPES_ARR[2], MSDN_TYPES_ARR[3], MSDN_TYPES_ARR[4], MSDN_TYPES_ARR[5]), LV_ModifyCol(1, "Sort")
        }
    }
    GuiControl,, EditEntries, % LV_GetCount()
return

; FUNCTIONS =====================================================================================================================

DownloadToString(url, encoding := "UTF-8") ; by Bentschi
{
    static a := "AutoHotkey/" A_AhkVersion
    if (!DllCall("kernel32.dll\LoadLibrary", "Str", "wininet") || !(h := DllCall("wininet.dll\InternetOpen", "Str", a, "UInt", 1, "Ptr", 0, "Ptr", 0, "UInt", 0, "Ptr")))
        return 0
    c := s := 0, o := r := ""
    if (f := DllCall("wininet.dll\InternetOpenUrl", "Ptr", h, "Str", url, "Ptr", 0, "UInt", 0, "UInt", 0x80003000, "Ptr", 0, "Ptr"))
    {
        while (DllCall("wininet.dll\InternetQueryDataAvailable", "ptr", f, "UInt*", s, "UInt", 0, "UPtr", 0) && s > 0)
        {
            VarSetCapacity(b, s, 0)
            DllCall("wininet.dll\InternetReadFile", "Ptr", f, "Ptr", &b, "UInt", s, "UInt*", r)
            o .= StrGet(&b, r >> (encoding = "UTF-16" || encoding = "CP1200"), encoding)
        }
        DllCall("wininet.dll\InternetCloseHandle", "Ptr", f)
    }
    DllCall("wininet.dll\InternetCloseHandle", "Ptr", h)
    return o
}

; EXIT ==========================================================================================================================

GuiClose:
GuiEscape:
ExitApp