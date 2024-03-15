#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Off

;@Ahk2Exe-Set FileVersion, 1.0.1
;@Ahk2Exe-Set ProductVersion, 1.0.1.0
;@Ahk2Exe-Set CompanyName, Pikakid98
;@Ahk2Exe-ConsoleApp

if (PID := ProcessExist("turbo.exe")) {
		MsgBox "Text-in-ator is already open. Please use Turbo's Open option"
		ExitApp
}

if A_Args.Length < 1
{
    MsgBox "Error! Please launch this with a .compile file"
    ExitApp
}

Loop Files, A_Args[1], "F"
SetWorkingDir A_LoopFileDir

for n, param in A_Args
{

	if not FileExist(A_Temp "\Cmpl8rTE") {
		DirCreate A_Temp "\Cmpl8rTE"
	}

	
	if not FileExist(A_Temp "\Cmpl8rTE\TE.bat") {
		FileAppend "
		(
			@ECHO OFF
			;title Text-in-ator (v1.0.1)   [Based on Turbo (Commit 8d42224)]
			"%tmp%\Cmpl8rTE\Turbo.exe" "%~1"
		)", A_Temp "\Cmpl8rTE\TE.bat"
	}
	
	FileInstall "Turbo.exe", A_Temp "\Cmpl8rTE\Turbo.exe", 1
	RunWait A_Temp "\Cmpl8rTE\TE.bat" " " '"' A_Args[1] '"'
	
	FileDelete A_Temp "\Cmpl8rTE\TE.bat"
}