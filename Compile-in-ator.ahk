#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

;@Ahk2Exe-Set FileVersion, 1.3.0.2
;@Ahk2Exe-Set ProductVersion, 1.3.0.2
;@Ahk2Exe-Set CompanyName, Pikakid98
;@Ahk2Exe-ConsoleApp

if DirExist(A_Temp "\Cmpl8r") {
	DirDelete A_Temp "\Cmpl8r", 1
}

if A_Args.Length < 1
{
    MsgBox "Error! Please launch this via a .compile file"
    ExitApp
}

Loop Files, A_Args[1], "F"
SetWorkingDir A_LoopFileDir

for n, param in A_Args
{
	if not DirExist(A_Temp "\Cmpl8r") {
		DirCreate A_Temp "\Cmpl8r"
		FileAppend "
		(
			@ECHO OFF
			;title Compile-in-ator (v1.3.0.2)
			@ECHO ON
		)", A_Temp "\Cmpl8r\main.bat"
		
		RunWait A_Temp "\Cmpl8r\main.bat"
		FileCopy A_Args[1], "[CompileTemp].bat"
		RunWait "[CompileTemp].bat"
		FileDelete "[CompileTemp].bat"
		DirDelete A_Temp "\Cmpl8r", 1
		ExitApp
		}
}