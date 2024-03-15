#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

;@Ahk2Exe-Set FileVersion, 1.2.2
;@Ahk2Exe-Set ProductVersion, 1.2.2.0
;@Ahk2Exe-Set CompanyName, Pikakid98
;@Ahk2Exe-ConsoleApp

if FileExist(A_Temp "\Cmpl8r") {
	DirDelete A_Temp "\Cmpl8r", 1
	FileAppend "@ECHO OFF`n;title Compile-in-ator (v1.2.2)`n@ECHO ON", A_Temp "\Cmpl8r\main.bat"
	RunWait A_Temp "\Cmpl8r\main.bat"
}

if A_Args.Length < 1
{
    MsgBox "Error! Please launch this via a .compile file (Renamed batch script)"
    ExitApp
}

Loop Files, A_Args[1], "F"
SetWorkingDir A_LoopFileDir

for n, param in A_Args
{
	if not FileExist(A_Temp "\Cmpl8r\tempcompile.bat") {
		DirCreate A_Temp "\Cmpl8r"
		FileAppend "@ECHO OFF`n;title Compile-in-ator (v1.2.2)`n@ECHO ON", A_Temp "\Cmpl8r\main.bat"
		RunWait A_Temp "\Cmpl8r\main.bat"
		FileCopy A_Args[1], A_Temp "\Cmpl8r\tempcompile.bat"
		RunWait A_Temp "\Cmpl8r\tempcompile.bat"
		DirDelete A_Temp "\Cmpl8r", 1
	}
}