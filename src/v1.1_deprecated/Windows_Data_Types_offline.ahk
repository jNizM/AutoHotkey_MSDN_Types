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

; MSDN_TYPES ====================================================================================================================

MSDN_TYPES=
(
ATOM,UShort,,typedef WORD ATOM
BOOL,Int,,typedef int BOOL
BOOLEAN,UChar,,typedef BYTE BOOLEAN
BYTE,UChar,,typedef unsigned char BYTE
CCHAR,Char,,typedef char CCHAR
CHAR,Char,,typedef char CHAR
COLORREF,UInt,,typedef DWORD COLORREF
DWORD,UInt,,typedef unsigned long DWORD
DWORDLONG,Int64,,typedef unsigned __int64 DWORDLONG
DWORD_PTR,UPtr,,typedef ULONG_PTR DWORD_PTR
DWORD32,UInt,,typedef unsigned int DWORD32
DWORD64,Int64,,typedef unsigned __int64 DWORD64
FLOAT,Float,,typedef float FLOAT
HACCEL,Ptr,,typedef HANDLE HACCEL
HALF_PTR,Short (32) | Int (64),,typedef short HALF_PTR | typedef int HALF_PTR
HANDLE,Ptr,,typedef PVOID HANDLE
HBITMAP,Ptr,,typedef HANDLE HBITMAP
HBRUSH,Ptr,,typedef HANDLE HBRUSH
HCOLORSPACE,Ptr,,typedef HANDLE HCOLORSPACE
HCONV,Ptr,,typedef HANDLE HCONV
HCONVLIST,Ptr,,typedef HANDLE HCONVLIST
HCURSOR,Ptr,,typedef HICON HCURSOR
HDC,Ptr,,typedef HANDLE HDC
HDDEDATA,Ptr,,typedef HANDLE HDDEDATA
HDESK,Ptr,,typedef HANDLE HDESK
HDROP,Ptr,,typedef HANDLE HDROP
HDWP,Ptr,,typedef HANDLE HDWP
HENHMETAFILE,Ptr,,typedef HANDLE HENHMETAFILE
HFILE,Int,,typedef int HFILE
HFONT,Ptr,,typedef HANDLE HFONT
HGDIOBJ,Ptr,,typedef HANDLE HGDIOBJ
HGLOBAL,Ptr,,typedef HANDLE HGLOBAL
HHOOK,Ptr,,typedef HANDLE HHOOK
HICON,Ptr,,typedef HANDLE HICON
HINSTANCE,Ptr,,typedef HANDLE HINSTANCE
HKEY,Ptr,,typedef HANDLE HKEY
HKL,Ptr,,typedef HANDLE HKL
HLOCAL,Ptr,,typedef HANDLE HLOCAL
HMENU,Ptr,,typedef HANDLE HMENU
HMETAFILE,Ptr,,typedef HANDLE HMETAFILE
HMODULE,Ptr,,typedef HINSTANCE HMODULE
HMONITOR,Ptr,,typedef HANDLE HMONITOR
HPALETTE,Ptr,,typedef HANDLE HPALETTE
HPEN,Ptr,,typedef HANDLE HPEN
HRESULT,Int,,typedef LONG HRESULT
HRGN,Ptr,,typedef HANDLE HRGN
HRSRC,Ptr,,typedef HANDLE HRSRC
HSZ,Ptr,,typedef HANDLE HSZ
HWINSTA,Ptr,,typedef HANDLE WINSTA
HWND,Ptr,,typedef HANDLE HWND
INT,Int,,typedef int INT
INT_PTR,Ptr,,typedef int INT_PTR / __int64 INT_PTR
INT8,Char,,typedef signed char INT8
INT16,Short,,typedef signed short INT16
INT32,Int,,typedef signed int INT32
INT64,Int64,,typedef signed __int64 INT64
LANGID,UShort,,typedef WORD LANGID
LCID,UInt,,typedef DWORD LCID
LCTYPE,UInt,,typedef DWORD LCTYPE
LGRPID,UInt,,typedef DWORD LGRPID
LONG,Int,,typedef long LONG
LONGLONG,Int64,,typedef __int64 LONGLONG
LONG_PTR,Ptr,,typedef long LONG_PTR / __int64 LONG_PTR
LONG32,Int,,typedef signed int LONG32
LONG64,Int64,,typedef __int64 LONG64
LPARAM,Ptr,,typedef LONG_PTR LPARAM
LPBOOL,Ptr,IntP,typedef BOOL far *LPBOOL
LPBYTE,Ptr,UCharP,typedef BYTE far *LPBYTE
LPCOLORREF,Ptr,UIntP,typedef DWORD *LPCOLORREF
LPCSTR,Ptr,Str / AStr,typedef __nullterminated CONST CHAR *LPCST
LPCTSTR,Ptr,Str,typedef LPCSTR LPCTSTR / LPCWSTR LPCTSTR
LPCVOID,Ptr,PtrP,typedef CONST void *LPCVOID
LPCWSTR,Ptr,Str / WStr,typedef CONST WCHAR *LPCWSTR
LPDWORD,Ptr,UIntP,typedef DWORD *LPDWORD
LPHANDLE,Ptr,PtrP,typedef HANDLE *LPHANDLE
LPINT,Ptr,IntP,typedef int *LPINT
LPLONG,Ptr,IntP,typedef long *LPLONG
LPSTR,Ptr,Str / AStr,typedef CHAR *LPSTR
LPTSTR,Ptr,Str,typedef LPSTR LPTSTR / LPWSTR LPTSTR
LPVOID,Ptr,PtrP,typedef void *LPVOID
LPWORD,Ptr,UShortP,typedef WORD *LPWORD
LPWSTR,Ptr,Str / WStr,typedef WCHAR *LPWSTR
LRESULT,Ptr,,typedef LONG_PTR LRESULT
PBOOL,Ptr,IntP,typedef BOOL *PBOOL
PBOOLEAN,Ptr,CharP,typedef BOOLEAN *PBOOLEAN
PBYTE,Ptr,UCharP,typedef BYTE *PBYTE
PCHAR,Ptr,CharP,typedef CHAR *PCHAR
PCSTR,Ptr,Str / AStr,typedef CONST CHAR *PCSTR
PCTSTR,Ptr,Str,typedef LPCSTR PCTSTR / LPCWSTR PCTSTR
PCWSTR,Ptr,Str / WStr,typedef CONST WCHAR *PCWSTR
PDWORD,Ptr,UIntP,typedef DWORD *PDWORD
PDWORDLONG,Ptr,Int64P,typedef DWORDLONG *PDWORDLONG
PDWORD_PTR,Ptr,UPtrP,typedef DWORD_PTR *PDWORD_PTR
PDWORD32,Ptr,UIntP,typedef DWORD32 *PDWORD3
PDWORD64,Ptr,Int64P,typedef DWORD64 *PDWORD64
PFLOAT,Ptr,FloatP,typedef FLOAT *PFLOAT
PHALF_PTR,Short (32) | Int (64),ShortP | IntP,typedef HALF_PTR *PHALF_PTR | typedef HALF_PTR *PHALF_PTR
PHANDLE,Ptr,PtrP,typedef HANDLE *PHANDLE
PHKEY,Ptr,PtrP,typedef HKEY *PHKEY
PINT,Ptr,IntP,typedef int *PINT
PINT_PTR,Ptr,PtrP,typedef INT_PTR *PINT_PTR
PINT8,Ptr,CharP,typedef INT8 *PINT8
PINT16,Ptr,ShortP,typedef INT16 *PINT16
PINT32,Ptr,IntP,typedef INT32 *PINT32
PINT64,Ptr,Int64P,typedef INT64 *PINT64
PLCID,Ptr,UIntP,typedef PDWORD PLCID
PLONG,Ptr,IntP,typedef LONG *PLONG
PLONGLONG,Ptr,Int64P,typedef LONGLONG *PLONGLONG
PLONG_PTR,Ptr,PtrP,typedef LONG_PTR *PLONG_PTR
PLONG32,Ptr,IntP,typedef LONG32 *PLONG32
PLONG64,Ptr,Int64P,typedef LONG64 *PLONG64
POINTER_32,Int,,#define POINTER_32 __ptr32
POINTER_64,Int64,,#define POINTER_64 __ptr64
POINTER_SIGNED,Ptr,,#define POINTER_SIGNED __sptr
POINTER_UNSIGNED,UPtr,,#define POINTER_UNSIGNED __uptr
PSHORT,Ptr,ShortP,typedef SHORT *PSHORT
PSIZE_T,Ptr,UPtrP,typedef SIZE_T *PSIZE_T
PSSIZE_T,Ptr,PtrP,typedef SSIZE_T *PSSIZE_T
PSTR,Ptr,Str / AStr,typedef CHAR *PSTR
PTBYTE,Ptr,UCharP (A) | UShortP (U),typedef TBYTE *PTBYTE | typedef TBYTE *PTBYTE
PTCHAR,Ptr,CharP (A) | ShortP (U),typedef TCHAR *PTCHAR | typedef TCHAR *PTCHAR
PTSTR,Ptr,Str / AStr / WStr,typedef LPSTR PTSTR / LPWSTR PTSTR
PUCHAR,Ptr,UCharP,typedef UCHAR *PUCHAR
PUHALF_PTR,UShort (32) | UInt (64),UShortP | UIntP,typedef UHALF_PTR *PUHALF_PTR | typedef UHALF_PTR *PUHALF_PTR
PUINT,Ptr,UIntP,typedef UINT *PUINT
PUINT_PTR,UPtr,UPtrP,typedef UINT_PTR *PUINT_PTR
PUINT8,Ptr,UCharP,typedef UINT8 *PUINT8
PUINT16,Ptr,UShortP,typedef UINT16 *PUINT16
PUINT32,Ptr,UIntP,typedef UINT32 *PUINT32
PUINT64,Ptr,Int64P,typedef UINT64 *PUINT64
PULONG,Ptr,UIntP,typedef ULONG *PULONG
PULONGLONG,Ptr,Int64P,typedef ULONGLONG *PULONGLONG
PULONG_PTR,UPtr,UPtrP,typedef ULONG_PTR *PULONG_PTR
PULONG32,Ptr,UIntP,typedef ULONG32 *PULONG32
PULONG64,Ptr,Int64P,typedef ULONG64 *PULONG64
PUSHORT,Ptr,UShortP,typedef USHORT *PUSHORT
PVOID,Ptr,PtrP,typedef void *PVOID
PWCHAR,Ptr,UShortP,typedef WCHAR *PWCHAR
PWORD,Ptr,UShortP,typedef WORD *PWORD
PWSTR,Ptr,Str / WStr,typedef WCHAR *PWSTR
QWORD,Int64,,typedef unsigned __int64 QWORD;
SC_HANDLE,Ptr,,typedef HANDLE SC_HANDLE
SC_LOCK,Ptr,PtrP,typedef LPVOID SC_LOCK
SERVICE_STATUS_HANDLE,Ptr,,typedef HANDLE SERVICE_STATUS_HANDLE
SHORT,Short,,typedef short SHORT
SIZE_T,UPtr,,typedef ULONG_PTR SIZE_T
SSIZE_T,Ptr,,typedef LONG_PTR SSIZE_T
TBYTE,UChar (A) | UShort (U),,typedef unsigned char TBYTE | typedef WCHAR TBYTE
TCHAR,Char (A) | UShort (U),,typedef char TCHAR | typedef WCHAR TCHAR
UCHAR,UChar,,typedef unsigned char UCHAR
UHALF_PTR,UShort (32) | UInt (64),,typedef unsigned short UHALF_PTR | typedef unsigned int UHALF_PTR
UINT,UInt,,typedef unsigned int UINT
UINT_PTR,UPtr,,typedef unsigned int UINT_PTR / unsigned __int64 UINT_PTR
UINT8,UChar,,typedef unsigned char UINT8
UINT16,UShort,,typedef unsigned short UINT16
UINT32,UInt,,typedef unsigned int UINT32
UINT64,Int64,,typedef usigned __int 64 UINT64
ULONG,UInt,,typedef unsigned long ULONG
ULONGLONG,Int64,,typedef unsigned __int64 ULONGLONG
ULONG_PTR,UPtr,,typedef unsigned long ULONG_PTR / unsigned __int64 ULONG_PTR
ULONG32,UInt,,typedef unsigned int ULONG32
ULONG64,Int64,,typedef unsigned __int64 ULONG64
USHORT,UShort,,typedef unsigned short USHORT
USN,Int64,,typedef LONGLONG USN
VOID,Ptr,,#define VOID void
WCHAR,UShort,,typedef wchar_t WCHAR
WORD,UShort,,typedef unsigned short WORD
WPARAM,UPtr,,typedef UINT_PTR WPARAM
)

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
    loop, parse, MSDN_TYPES, `n, `r
    {
        MSDN_TYPES_ARR := StrSplit(A_LoopField, ",")
        LV_Add("", MSDN_TYPES_ARR[1], MSDN_TYPES_ARR[2], MSDN_TYPES_ARR[3], MSDN_TYPES_ARR[4]), LV_ModifyCol(1, "Sort")
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
    loop, parse, MSDN_TYPES, `n, `r
    {
        MSDN_TYPES_ARR := StrSplit(A_LoopField, ",")
        if (InStr(MSDN_TYPES_ARR[1], EditSearch))
            LV_Add("", MSDN_TYPES_ARR[1], MSDN_TYPES_ARR[2], MSDN_TYPES_ARR[3], MSDN_TYPES_ARR[4]), LV_ModifyCol(1, "Sort")
    }
    GuiControl,, EditEntries, % LV_GetCount()
return

; EXIT ==========================================================================================================================

GuiClose:
GuiEscape:
ExitApp