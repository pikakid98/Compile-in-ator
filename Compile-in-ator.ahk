#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Off

;@Ahk2Exe-Set FileVersion, 1.2
;@Ahk2Exe-Set ProductVersion, 1.2.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98
;@Ahk2Exe-ConsoleApp

if A_Args.Length < 1
{
    MsgBox "Error! Please launch this via a .compile file (Renamed batch script)"
    ExitApp
}

Loop Files, A_Args[1], "F"
SetWorkingDir A_LoopFileDir
/*
if FileExist(A_Temp "\tempcompile2.bat") {
	MsgBox "No more than 3 tempcompile files can be created. Please finish or stop an existing compile first"
	ExitApp
}

if FileExist(A_Temp "\tempcompile1.bat") {
	FileCopy A_Args[1] , A_Temp "\tempcompile2.bat"
	RunWait A_Temp "\tempcompile2.bat"
	FileDelete A_Temp "\tempcompile2.bat"
}

if FileExist(A_Temp "\tempcompile.bat") {
	FileCopy A_Args[1] , A_Temp "\tempcompile1.bat"
	RunWait A_Temp "\tempcompile1.bat"
	FileDelete A_Temp "\tempcompile1.bat"
}
*/
for n, param in A_Args
{
	if not FileExist(A_Temp "\tempcompile.bat") {
		DirCreate A_Temp "\Cmpl8r"
		FileCopy A_Args[1] , A_Temp "\Cmpl8r\tempcompile.bat"
		RunWait A_Temp "\Cmpl8r\tempcompile.bat"
		DirDelete A_Temp "\Cmpl8r", 1
	}
}