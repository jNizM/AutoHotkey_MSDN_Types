; ===========================================================================================================================================================================

/*
	WinAPI_DataTypes (written in AutoHotkey)
	Author ....: jNizM
	Released ..: 2015-05-05
	Modified ..: 2021-03-21
	License ...: MIT
	GitHub ....: https://github.com/jNizM/AutoHotkey_MSDN_Types
	Forum .....: https://www.autohotkey.com/boards/viewtopic.php?t=99817
*/


; COMPILER DIRECTIVES =======================================================================================================================================================

;@Ahk2Exe-SetDescription    WinAPI_DataTypes (x64)
;@Ahk2Exe-SetFileVersion    0.4.1
;@Ahk2Exe-SetProductName    WinAPI_DataTypes
;@Ahk2Exe-SetProductVersion 2.0-beta.3
;@Ahk2Exe-SetCopyright      (c) 2015-2022 jNizM
;@Ahk2Exe-SetLanguage       0x0407


; SCRIPT DIRECTIVES =========================================================================================================================================================

#Requires AutoHotkey v2.0-



; RUN =======================================================================================================================================================================

WinAPI_DataTypes()
;WinAPI_DataTypes("Dark") ;<- Dark Theme



; WinAPI_DataTypes ==========================================================================================================================================================

WinAPI_DataTypes(GuiTheme := "Light")
{
	static DATA_TYPES := CONST_DATA_TYPES()

	App := Map("name", "WinAPI_DataTypes", "version", "0.4.1", "release", "2022-02-04", "author", "jNizM", "licence", "MIT")


	; TRAY ==============================================================================================================================================================

	if (VerCompare(A_OSVersion, "10.0.22000") >= 0)
		TraySetIcon("shell32.dll", 56)


	; GUI ===============================================================================================================================================================

	Main := Gui("+Resize +MinSize854x480", App["name"])
	Main.BackColor := (GuiTheme = "Dark") ? "3E3E3E" : ""
	Main.MarginX := 0
	Main.MarginY := 0

	Main.SetFont("s9", "Segoe UI")
	LV_Header := ["Data Type", "AHK Type", "Alternative for DllCall()", "x86 Size", "x64 Size", "MSDN Definition"]
	LV := Main.AddListView("xm+10 ym+10 w830 r10" ((GuiTheme = "Dark") ? " cD9D9D9 Background5B5B5B" : ""), LV_Header)
	for k, v in DATA_TYPES
		LV.Add("", DATA_TYPES[k]*)
	loop LV.GetCount("Col")
		LV.ModifyCol(A_Index, "AutoHdr")

	Main.SetFont("s10", "Segoe UI")
	ED := Main.AddEdit("xm+9 y+5 w200" ((GuiTheme = "Dark") ? " cD9D9D9 Background5B5B5B" : ""))
	ED.OnEvent("Change", LV_Search)
	EM_SETCUEBANNER(ED, "Search...", 1)

	Main.OnEvent("Size", GuiSize)
	Main.OnEvent("Close", (*) => ExitApp)
	Main.Show("AutoSize")
	HideFocusBorder(Main.Hwnd)


	if (VerCompare(A_OSVersion, "10.0.17763") >= 0) && (GuiTheme = "Dark")
	{
		DWMWA_USE_IMMERSIVE_DARK_MODE := 19
		if (VerCompare(A_OSVersion, "10.0.18985") >= 0)
		{
			DWMWA_USE_IMMERSIVE_DARK_MODE := 20
		}
		DllCall("dwmapi\DwmSetWindowAttribute", "Ptr", Main.hWnd, "Int", DWMWA_USE_IMMERSIVE_DARK_MODE, "int*", true, "Int", 4)
		SetExplorerTheme(LV.hWnd, "DarkMode_Explorer")
	}
	else
		SetExplorerTheme(LV.hWnd)


	; WINDOW EVENTS =====================================================================================================================================================

	GuiSize(thisGui, MinMax, Width, Height)
	{
		if (MinMax = -1)
			return
		LV.Move(,, Width - 21, Height - 50)
		LV.Redraw()
		ED.Move(, Height - 35, Width - 19)
	}


	LV_Search(CtrlObj, *)
	{
		LV.Opt("-Redraw")
		LV.Delete()
		for k, v in DATA_TYPES
		{
			IsFound := false
			for i, v in DATA_TYPES[k]
			{
				;if !(CtrlObj.Value) || (InStr(v, CtrlObj.Value))
				try
					if (RegExMatch(v, "i)" CtrlObj.Value))
						IsFound := true
			}
			if !(IsFound)
				continue
			LV.Add("", DATA_TYPES[k]*)
		}
		LV.Opt("+Redraw")
	}


	; Messages ==========================================================================================================================================================

	EM_SETCUEBANNER(handle, string, option := false)
	{
		static ECM_FIRST       := 0x1500
		static EM_SETCUEBANNER := ECM_FIRST + 1

		SendMessage(EM_SETCUEBANNER, option, StrPtr(string), handle)
	}


	; Functions =========================================================================================================================================================

	HideFocusBorder(wParam, lParam := "", Msg := "", hWnd := "")
	{
		static Affected         := Map()
		static WM_UPDATEUISTATE := 0x0128
		static UIS_SET          := 1
		static UISF_HIDEFOCUS   := 0x1
		static SET_HIDEFOCUS    := UIS_SET << 16 | UISF_HIDEFOCUS
		static init             := OnMessage(WM_UPDATEUISTATE, HideFocusBorder)

		if (Msg = WM_UPDATEUISTATE)
		{
			if (wParam = SET_HIDEFOCUS)
				Affected[hWnd] := true
			else if (Affected.Has(hWnd))
				PostMessage(WM_UPDATEUISTATE, SET_HIDEFOCUS, 0,, "ahk_id " hWnd)
		}
		else if (DllCall("user32\IsWindow", "Ptr", wParam, "UInt"))
			PostMessage(WM_UPDATEUISTATE, SET_HIDEFOCUS, 0,, "ahk_id " wParam)
	}


	SetExplorerTheme(handle, WindowTheme := "Explorer")
	{
		if (DllCall("GetVersion", "UChar") > 5)
		{
			VarSetStrCapacity(&ClassName, 1024)
			if (DllCall("user32\GetClassName", "Ptr", handle, "Str", ClassName, "Int", 512, "Int"))
			{
				if (ClassName = "SysListView32") || (ClassName = "SysTreeView32")
					return !DllCall("uxtheme\SetWindowTheme", "Ptr", handle, "Str", WindowTheme, "Ptr", 0)
			}
		}
		return false
	}


	; Constants =========================================================================================================================================================

	CONST_DATA_TYPES()
	{
		DATA_TYPES := Map()
		DATA_TYPES["ATOM"] := ["ATOM", "UShort", "", 2, 2, "typedef WORD ATOM"]
		DATA_TYPES["BOOL"] := ["BOOL","Int","",4,4,"typedef int BOOL"]
		DATA_TYPES["BOOLEAN"] := ["BOOLEAN","UChar","",1,1,"typedef BYTE BOOLEAN"]
		DATA_TYPES["BYTE"] := ["BYTE","UChar","",1,1,"typedef unsigned char BYTE"]
		DATA_TYPES["CCHAR"] := ["CCHAR","Char","",1,1,"typedef char CCHAR"]
		DATA_TYPES["CHAR"] := ["CHAR","Char","",1,1,"typedef char CHAR"]
		DATA_TYPES["COLORREF"] := ["COLORREF","UInt","",4,4,"typedef DWORD COLORREF"]
		DATA_TYPES["DWORD"] := ["DWORD","UInt","",4,4,"typedef unsigned long DWORD"]
		DATA_TYPES["DWORDLONG"] := ["DWORDLONG","Int64","",8,8,"typedef unsigned __int64 DWORDLONG"]
		DATA_TYPES["DWORD_PTR"] := ["DWORD_PTR","UPtr","",4,8,"typedef ULONG_PTR DWORD_PTR"]
		DATA_TYPES["DWORD32"] := ["DWORD32","UInt","",4,4,"typedef unsigned int DWORD32"]
		DATA_TYPES["DWORD64"] := ["DWORD64","Int64","",8,8,"typedef unsigned __int64 DWORD64"]
		DATA_TYPES["FLOAT"] := ["FLOAT","Float","",4,4,"typedef float FLOAT"]
		DATA_TYPES["HACCEL"] := ["HACCEL","Ptr","",4,8,"typedef HANDLE HACCEL"]
		DATA_TYPES["HALF_PTR"] := ["HALF_PTR","Short (32) | Int (64)","",2,4,"typedef short HALF_PTR | typedef int HALF_PTR"]
		DATA_TYPES["HANDLE"] := ["HANDLE","Ptr","",4,8,"typedef PVOID HANDLE"]
		DATA_TYPES["HBITMAP"] := ["HBITMAP","Ptr","",4,8,"typedef HANDLE HBITMAP"]
		DATA_TYPES["HBRUSH"] := ["HBRUSH","Ptr","",4,8,"typedef HANDLE HBRUSH"]
		DATA_TYPES["HCOLORSPACE"] := ["HCOLORSPACE","Ptr","",4,8,"typedef HANDLE HCOLORSPACE"]
		DATA_TYPES["HCONV"] := ["HCONV","Ptr","",4,8,"typedef HANDLE HCONV"]
		DATA_TYPES["HCONVLIST"] := ["HCONVLIST","Ptr","",4,8,"typedef HANDLE HCONVLIST"]
		DATA_TYPES["HCURSOR"] := ["HCURSOR","Ptr","",4,8,"typedef HICON HCURSOR"]
		DATA_TYPES["HDC"] := ["HDC","Ptr","",4,8,"typedef HANDLE HDC"]
		DATA_TYPES["HDDEDATA"] := ["HDDEDATA","Ptr","",4,8,"typedef HANDLE HDDEDATA"]
		DATA_TYPES["HDESK"] := ["HDESK","Ptr","",4,8,"typedef HANDLE HDESK"]
		DATA_TYPES["HDROP"] := ["HDROP","Ptr","",4,8,"typedef HANDLE HDROP"]
		DATA_TYPES["HDWP"] := ["HDWP","Ptr","",4,8,"typedef HANDLE HDWP"]
		DATA_TYPES["HENHMETAFILE"] := ["HENHMETAFILE","Ptr","",4,8,"typedef HANDLE HENHMETAFILE"]
		DATA_TYPES["HFILE"] := ["HFILE","Int","",4,8,"typedef int HFILE"]
		DATA_TYPES["HFONT"] := ["HFONT","Ptr","",4,8,"typedef HANDLE HFONT"]
		DATA_TYPES["HGDIOBJ"] := ["HGDIOBJ","Ptr","",4,8,"typedef HANDLE HGDIOBJ"]
		DATA_TYPES["HGLOBAL"] := ["HGLOBAL","Ptr","",4,8,"typedef HANDLE HGLOBAL"]
		DATA_TYPES["HHOOK"] := ["HHOOK","Ptr","",4,8,"typedef HANDLE HHOOK"]
		DATA_TYPES["HICON"] := ["HICON","Ptr","",4,8,"typedef HANDLE HICON"]
		DATA_TYPES["HINSTANCE"] := ["HINSTANCE","Ptr","",4,8,"typedef HANDLE HINSTANCE"]
		DATA_TYPES["HKEY"] := ["HKEY","Ptr","",4,8,"typedef HANDLE HKEY"]
		DATA_TYPES["HKL"] := ["HKL","Ptr","",4,8,"typedef HANDLE HKL"]
		DATA_TYPES["HLOCAL"] := ["HLOCAL","Ptr","",4,8,"typedef HANDLE HLOCAL"]
		DATA_TYPES["HMENU"] := ["HMENU","Ptr","",4,8,"typedef HANDLE HMENU"]
		DATA_TYPES["HMETAFILE"] := ["HMETAFILE","Ptr","",4,8,"typedef HANDLE HMETAFILE"]
		DATA_TYPES["HMODULE"] := ["HMODULE","Ptr","",4,8,"typedef HINSTANCE HMODULE"]
		DATA_TYPES["HMONITOR"] := ["HMONITOR","Ptr","",4,8,"typedef HANDLE HMONITOR"]
		DATA_TYPES["HPALETTE"] := ["HPALETTE","Ptr","",4,8,"typedef HANDLE HPALETTE"]
		DATA_TYPES["HPEN"] := ["HPEN","Ptr","",4,8,"typedef HANDLE HPEN"]
		DATA_TYPES["HRESULT"] := ["HRESULT","Int","",4,4,"typedef LONG HRESULT"]
		DATA_TYPES["HRGN"] := ["HRGN","Ptr","",4,8,"typedef HANDLE HRGN"]
		DATA_TYPES["HRSRC"] := ["HRSRC","Ptr","",4,8,"typedef HANDLE HRSRC"]
		DATA_TYPES["HSZ"] := ["HSZ","Ptr","",4,8,"typedef HANDLE HSZ"]
		DATA_TYPES["HWINSTA"] := ["HWINSTA","Ptr","",4,8,"typedef HANDLE WINSTA"]
		DATA_TYPES["HWND"] := ["HWND","Ptr","",4,8,"typedef HANDLE HWND"]
		DATA_TYPES["INT"] := ["INT","Int","",4,4,"typedef int INT"]
		DATA_TYPES["INT_PTR"] := ["INT_PTR","Ptr","",4,8,"typedef int INT_PTR / __int64 INT_PTR"]
		DATA_TYPES["INT8"] := ["INT8","Char","",1,1,"typedef signed char INT8"]
		DATA_TYPES["INT16"] := ["INT16","Short","",2,2,"typedef signed short INT16"]
		DATA_TYPES["INT32"] := ["INT32","Int","",4,4,"typedef signed int INT32"]
		DATA_TYPES["INT64"] := ["INT64","Int64","",8,8,"typedef signed __int64 INT64"]
		DATA_TYPES["LANGID"] := ["LANGID","UShort","",2,2,"typedef WORD LANGID"]
		DATA_TYPES["LCID"] := ["LCID","UInt","",4,4,"typedef DWORD LCID"]
		DATA_TYPES["LCTYPE"] := ["LCTYPE","UInt","",4,4,"typedef DWORD LCTYPE"]
		DATA_TYPES["LGRPID"] := ["LGRPID","UInt","",4,4,"typedef DWORD LGRPID"]
		DATA_TYPES["LONG"] := ["LONG","Int","",4,4,"typedef long LONG"]
		DATA_TYPES["LONGLONG"] := ["LONGLONG","Int64","",8,8,"typedef __int64 LONGLONG"]
		DATA_TYPES["LONG_PTR"] := ["LONG_PTR","Ptr","",4,8,"typedef long LONG_PTR / __int64 LONG_PTR"]
		DATA_TYPES["LONG32"] := ["LONG32","Int","",4,4,"typedef signed int LONG32"]
		DATA_TYPES["LONG64"] := ["LONG64","Int64","",8,8,"typedef __int64 LONG64"]
		DATA_TYPES["LPARAM"] := ["LPARAM","Ptr","",4,8,"typedef LONG_PTR LPARAM"]
		DATA_TYPES["LPBOOL"] := ["LPBOOL","Ptr","IntP",4,8,"typedef BOOL far *LPBOOL"]
		DATA_TYPES["LPBYTE"] := ["LPBYTE","Ptr","UCharP",4,8,"typedef BYTE far *LPBYTE"]
		DATA_TYPES["LPCOLORREF"] := ["LPCOLORREF","Ptr","UIntP",4,8,"typedef DWORD *LPCOLORREF"]
		DATA_TYPES["LPCSTR"] := ["LPCSTR","Ptr","Str / AStr",4,8,"typedef __nullterminated CONST CHAR *LPCST"]
		DATA_TYPES["LPCTSTR"] := ["LPCTSTR","Ptr","Str",4,8,"typedef LPCSTR LPCTSTR / LPCWSTR LPCTSTR"]
		DATA_TYPES["LPCVOID"] := ["LPCVOID","Ptr","PtrP",4,8,"typedef CONST void *LPCVOID"]
		DATA_TYPES["LPCWSTR"] := ["LPCWSTR","Ptr","Str / WStr",4,8,"typedef CONST WCHAR *LPCWSTR"]
		DATA_TYPES["LPDWORD"] := ["LPDWORD","Ptr","UIntP",4,8,"typedef DWORD *LPDWORD"]
		DATA_TYPES["LPHANDLE"] := ["LPHANDLE","Ptr","PtrP",4,8,"typedef HANDLE *LPHANDLE"]
		DATA_TYPES["LPINT"] := ["LPINT","Ptr","IntP",4,8,"typedef int *LPINT"]
		DATA_TYPES["LPLONG"] := ["LPLONG","Ptr","IntP",4,8,"typedef long *LPLONG"]
		DATA_TYPES["LPSTR"] := ["LPSTR","Ptr","Str / AStr",4,8,"typedef CHAR *LPSTR"]
		DATA_TYPES["LPTSTR"] := ["LPTSTR","Ptr","Str",4,8,"typedef LPSTR LPTSTR / LPWSTR LPTSTR"]
		DATA_TYPES["LPVOID"] := ["LPVOID","Ptr","PtrP",4,8,"typedef void *LPVOID"]
		DATA_TYPES["LPWORD"] := ["LPWORD","Ptr","UShortP",4,8,"typedef WORD *LPWORD"]
		DATA_TYPES["LPWSTR"] := ["LPWSTR","Ptr","Str / WStr",4,8,"typedef WCHAR *LPWSTR"]
		DATA_TYPES["LRESULT"] := ["LRESULT","Ptr","",4,8,"typedef LONG_PTR LRESULT"]
		DATA_TYPES["PBOOL"] := ["PBOOL","Ptr","IntP",4,8,"typedef BOOL *PBOOL"]
		DATA_TYPES["PBOOLEAN"] := ["PBOOLEAN","Ptr","CharP",4,8,"typedef BOOLEAN *PBOOLEAN"]
		DATA_TYPES["PBYTE"] := ["PBYTE","Ptr","UCharP",4,8,"typedef BYTE *PBYTE"]
		DATA_TYPES["PCHAR"] := ["PCHAR","Ptr","CharP",4,8,"typedef CHAR *PCHAR"]
		DATA_TYPES["PCSTR"] := ["PCSTR","Ptr","Str / AStr",4,8,"typedef CONST CHAR *PCSTR"]
		DATA_TYPES["PCTSTR"] := ["PCTSTR","Ptr","Str",4,8,"typedef LPCSTR PCTSTR / LPCWSTR PCTSTR"]
		DATA_TYPES["PCWSTR"] := ["PCWSTR","Ptr","Str / WStr",4,8,"typedef CONST WCHAR *PCWSTR"]
		DATA_TYPES["PDWORD"] := ["PDWORD","Ptr","UIntP",4,8,"typedef DWORD *PDWORD"]
		DATA_TYPES["PDWORDLONG"] := ["PDWORDLONG","Ptr","Int64P",4,8,"typedef DWORDLONG *PDWORDLONG"]
		DATA_TYPES["PDWORD_PTR"] := ["PDWORD_PTR","Ptr","UPtrP",4,8,"typedef DWORD_PTR *PDWORD_PTR"]
		DATA_TYPES["PDWORD32"] := ["PDWORD32","Ptr","UIntP",4,8,"typedef DWORD32 *PDWORD3"]
		DATA_TYPES["PDWORD64"] := ["PDWORD64","Ptr","Int64P",4,8,"typedef DWORD64 *PDWORD64"]
		DATA_TYPES["PFLOAT"] := ["PFLOAT","Ptr","FloatP",4,8,"typedef FLOAT *PFLOAT"]
		DATA_TYPES["PHALF_PTR"] := ["PHALF_PTR","Short (32) | Int (64)","ShortP | IntP",4,8,"typedef HALF_PTR *PHALF_PTR | typedef HALF_PTR *PHALF_PTR"]
		DATA_TYPES["PHANDLE"] := ["PHANDLE","Ptr","PtrP",4,8,"typedef HANDLE *PHANDLE"]
		DATA_TYPES["PHKEY"] := ["PHKEY","Ptr","PtrP",4,8,"typedef HKEY *PHKEY"]
		DATA_TYPES["PINT"] := ["PINT","Ptr","IntP",4,8,"typedef int *PINT"]
		DATA_TYPES["PINT_PTR"] := ["PINT_PTR","Ptr","PtrP",4,8,"typedef INT_PTR *PINT_PTR"]
		DATA_TYPES["PINT8"] := ["PINT8","Ptr","CharP",4,8,"typedef INT8 *PINT8"]
		DATA_TYPES["PINT16"] := ["PINT16","Ptr","ShortP",4,8,"typedef INT16 *PINT16"]
		DATA_TYPES["PINT32"] := ["PINT32","Ptr","IntP",4,8,"typedef INT32 *PINT32"]
		DATA_TYPES["PINT64"] := ["PINT64","Ptr","Int64P",4,8,"typedef INT64 *PINT64"]
		DATA_TYPES["PLCID"] := ["PLCID","Ptr","UIntP",4,8,"typedef PDWORD PLCID"]
		DATA_TYPES["PLONG"] := ["PLONG","Ptr","IntP",4,8,"typedef LONG *PLONG"]
		DATA_TYPES["PLONGLONG"] := ["PLONGLONG","Ptr","Int64P",4,8,"typedef LONGLONG *PLONGLONG"]
		DATA_TYPES["PLONG_PTR"] := ["PLONG_PTR","Ptr","PtrP",4,8,"typedef LONG_PTR *PLONG_PTR"]
		DATA_TYPES["PLONG32"] := ["PLONG32","Ptr","IntP",4,8,"typedef LONG32 *PLONG32"]
		DATA_TYPES["PLONG64"] := ["PLONG64","Ptr","Int64P",4,8,"typedef LONG64 *PLONG64"]
		DATA_TYPES["POINTER_32"] := ["POINTER_32","Int","","","","#define POINTER_32 __ptr32"]
		DATA_TYPES["POINTER_64"] := ["POINTER_64","Int64","","","","#define POINTER_64 __ptr64"]
		DATA_TYPES["POINTER_SIGNED"] := ["POINTER_SIGNED","Ptr","","","","#define POINTER_SIGNED __sptr"]
		DATA_TYPES["POINTER_UNSIGNED"] := ["POINTER_UNSIGNED","UPtr","","","","#define POINTER_UNSIGNED __uptr"]
		DATA_TYPES["PSHORT"] := ["PSHORT","Ptr","ShortP",4,8,"typedef SHORT *PSHORT"]
		DATA_TYPES["PSIZE_T"] := ["PSIZE_T","Ptr","UPtrP",4,8,"typedef SIZE_T *PSIZE_T"]
		DATA_TYPES["PSSIZE_T"] := ["PSSIZE_T","Ptr","PtrP",4,8,"typedef SSIZE_T *PSSIZE_T"]
		DATA_TYPES["PSTR"] := ["PSTR","Ptr","Str / AStr",4,8,"typedef CHAR *PSTR"]
		DATA_TYPES["PTBYTE"] := ["PTBYTE","Ptr","UCharP (A) | UShortP (U)",4,8,"typedef TBYTE *PTBYTE | typedef TBYTE *PTBYTE"]
		DATA_TYPES["PTCHAR"] := ["PTCHAR","Ptr","CharP (A) | ShortP (U)",4,8,"typedef TCHAR *PTCHAR | typedef TCHAR *PTCHAR"]
		DATA_TYPES["PTSTR"] := ["PTSTR","Ptr","Str / AStr / WStr",4,8,"typedef LPSTR PTSTR / LPWSTR PTSTR"]
		DATA_TYPES["PUCHAR"] := ["PUCHAR","Ptr","UCharP",4,8,"typedef UCHAR *PUCHAR"]
		DATA_TYPES["PUHALF_PTR"] := ["PUHALF_PTR","UShort (32) | UInt (64)","UShortP | UIntP",4,8,"typedef UHALF_PTR *PUHALF_PTR | typedef UHALF_PTR *PUHALF_PTR"]
		DATA_TYPES["PUINT"] := ["PUINT","Ptr","UIntP",4,8,"typedef UINT *PUINT"]
		DATA_TYPES["PUINT_PTR"] := ["PUINT_PTR","UPtr","UPtrP",4,8,"typedef UINT_PTR *PUINT_PTR"]
		DATA_TYPES["PUINT8"] := ["PUINT8","Ptr","UCharP",4,8,"typedef UINT8 *PUINT8"]
		DATA_TYPES["PUINT16"] := ["PUINT16","Ptr","UShortP",4,8,"typedef UINT16 *PUINT16"]
		DATA_TYPES["PUINT32"] := ["PUINT32","Ptr","UIntP",4,8,"typedef UINT32 *PUINT32"]
		DATA_TYPES["PUINT64"] := ["PUINT64","Ptr","Int64P",4,8,"typedef UINT64 *PUINT64"]
		DATA_TYPES["PULONG"] := ["PULONG","Ptr","UIntP",4,8,"typedef ULONG *PULONG"]
		DATA_TYPES["PULONGLONG"] := ["PULONGLONG","Ptr","Int64P",4,8,"typedef ULONGLONG *PULONGLONG"]
		DATA_TYPES["PULONG_PTR"] := ["PULONG_PTR","UPtr","UPtrP",4,8,"typedef ULONG_PTR *PULONG_PTR"]
		DATA_TYPES["PULONG32"] := ["PULONG32","Ptr","UIntP",4,8,"typedef ULONG32 *PULONG32"]
		DATA_TYPES["PULONG64"] := ["PULONG64","Ptr","Int64P",4,8,"typedef ULONG64 *PULONG64"]
		DATA_TYPES["PUSHORT"] := ["PUSHORT","Ptr","UShortP",4,8,"typedef USHORT *PUSHORT"]
		DATA_TYPES["PVOID"] := ["PVOID","Ptr","PtrP",4,8,"typedef void *PVOID"]
		DATA_TYPES["PWCHAR"] := ["PWCHAR","Ptr","UShortP",4,8,"typedef WCHAR *PWCHAR"]
		DATA_TYPES["PWORD"] := ["PWORD","Ptr","UShortP",4,8,"typedef WORD *PWORD"]
		DATA_TYPES["PWSTR"] := ["PWSTR","Ptr","Str / WStr",4,8,"typedef WCHAR *PWSTR"]
		DATA_TYPES["QWORD"] := ["QWORD","Int64","","","","typedef unsigned __int64 QWORD"]
		DATA_TYPES["SC_HANDLE"] := ["SC_HANDLE","Ptr","",4,8,"typedef HANDLE SC_HANDLE"]
		DATA_TYPES["SC_LOCK"] := ["SC_LOCK","Ptr","PtrP",4,8,"typedef LPVOID SC_LOCK"]
		DATA_TYPES["SERVICE_STATUS_HANDLE"] := ["SERVICE_STATUS_HANDLE","Ptr","",4,8,"typedef HANDLE SERVICE_STATUS_HANDLE"]
		DATA_TYPES["SHORT"] := ["SHORT","Short","",2,2,"typedef short SHORT"]
		DATA_TYPES["SIZE_T"] := ["SIZE_T","UPtr","",4,8,"typedef ULONG_PTR SIZE_T"]
		DATA_TYPES["SSIZE_T"] := ["SSIZE_T","Ptr","",4,8,"typedef LONG_PTR SSIZE_T"]
		DATA_TYPES["TBYTE"] := ["TBYTE","UChar (A) | UShort (U)","",1,1,"typedef unsigned char TBYTE | typedef WCHAR TBYTE"]
		DATA_TYPES["TCHAR"] := ["TCHAR","Char (A) | UShort (U)","",1,1,"typedef char TCHAR | typedef WCHAR TCHAR"]
		DATA_TYPES["UCHAR"] := ["UCHAR","UChar","",1,1,"typedef unsigned char UCHAR"]
		DATA_TYPES["UHALF_PTR"] := ["UHALF_PTR","UShort (32) | UInt (64)","",2,4,"typedef unsigned short UHALF_PTR | typedef unsigned int UHALF_PTR"]
		DATA_TYPES["UINT"] := ["UINT","UInt","",4,4,"typedef unsigned int UINT"]
		DATA_TYPES["UINT_PTR"] := ["UINT_PTR","UPtr","",4,8,"typedef unsigned int UINT_PTR / unsigned __int64 UINT_PTR"]
		DATA_TYPES["UINT8"] := ["UINT8","UChar","",1,1,"typedef unsigned char UINT8"]
		DATA_TYPES["UINT16"] := ["UINT16","UShort","",2,2,"typedef unsigned short UINT16"]
		DATA_TYPES["UINT32"] := ["UINT32","UInt","",4,4,"typedef unsigned int UINT32"]
		DATA_TYPES["UINT64"] := ["UINT64","Int64","",8,8,"typedef unsigned __int 64 UINT64"]
		DATA_TYPES["ULONG"] := ["ULONG","UInt","",4,4,"typedef unsigned long ULONG"]
		DATA_TYPES["ULONGLONG"] := ["ULONGLONG","Int64","",8,8,"typedef unsigned __int64 ULONGLONG"]
		DATA_TYPES["ULONG_PTR"] := ["ULONG_PTR","UPtr","",4,8,"typedef unsigned long ULONG_PTR / unsigned __int64 ULONG_PTR"]
		DATA_TYPES["ULONG32"] := ["ULONG32","UInt","",4,4,"typedef unsigned int ULONG32"]
		DATA_TYPES["ULONG64"] := ["ULONG64","Int64","",8,8,"typedef unsigned __int64 ULONG64"]
		DATA_TYPES["USHORT"] := ["USHORT","UShort","",2,2,"typedef unsigned short USHORT"]
		DATA_TYPES["USN"] := ["USN","Int64","",8,8,"typedef LONGLONG USN"]
		DATA_TYPES["VOID"] := ["VOID","Ptr","",4,8,"#define VOID void"]
		DATA_TYPES["WCHAR"] := ["WCHAR","UShort","",2,2,"typedef wchar_t WCHAR"]
		DATA_TYPES["WORD"] := ["WORD","UShort","",2,2,"typedef unsigned short WORD"]
		DATA_TYPES["WPARAM"] := ["WPARAM","UPtr","",4,8,"typedef UINT_PTR WPARAM"]
		return DATA_TYPES
	}
}

; ===========================================================================================================================================================================
