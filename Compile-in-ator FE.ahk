#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Off

;@Ahk2Exe-Set FileVersion, 1.2.2.1
;@Ahk2Exe-Set ProductVersion, 1.2.2.1
;@Ahk2Exe-Set CompanyName, Pikakid98

if A_Args.Length < 1
{
    SelectedFile := FileSelect(3, , "Open a file", "Compile-in-ator scripts (*.compile)")
	if SelectedFile = "" {
		ExitApp
	} else {
		IniWrite "", A_Temp "\FE.ini", "launch", "RunOrEdit"
		IniWrite '"' SelectedFile '"', A_Temp "\FE.ini", "launch", "CompileScript"
	}
}

if A_Args.Length = 1 {
	IniWrite "", A_Temp "\FE.ini", "launch", "RunOrEdit"
	IniWrite '"' A_Args[1] '"', A_Temp "\FE.ini", "launch", "CompileScript"
}

CompileScript := IniRead(A_Temp "\FE.ini", "launch", "CompileScript")

Loop Files, CompileScript, "F"
SetWorkingDir A_LoopFileDir

if DirExist(".Cmpl8r") {
	MsgBox "Error!, This compile script is already running. Please close the frontend first or manually run it via the command line"
	FileDelete A_Temp "\FE.ini"
	ExitApp
} else {
	DirCreate ".Cmpl8r"
}

FileMove A_Temp "\FE.ini", A_WorkingDir "\.Cmpl8r\FE.ini"

MyGui := Gui()

; call dark mode for window title + menu
SetWindowAttribute(MyGui)

; call dark mode for controls
SetWindowTheme(MyGui)

#include .Cmpl8r\DarkMode.scriptlet

MyGui.Title := "Compile-in-ator FE (v1.2.2.1)"

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {
	if DirExist(".Cmpl8r") {
		DirDelete ".Cmpl8r", 1
	}
	ExitApp
}

MyRadio := MyGui.AddRadio("vMyRadioGroup cwhite", "Compile")
MyRadio.OnEvent("Click", MyBtn_op1)

MyRadio2 := MyGui.AddRadio("vMyRadioGroup2 cwhite", "Edit")
MyRadio2.OnEvent("Click", MyBtn_op2)

MyBtn := MyGui.AddButton("Default w80", "OK")
MyBtn.OnEvent("Click", MyBtn_Click)

MyBtn_op1(*)
{
	IniWrite "Compile", ".Cmpl8r\FE.ini", "launch", "RunOrEdit"
}

MyBtn_op2(*)
{
	IniWrite "Text", ".Cmpl8r\FE.ini", "launch", "RunOrEdit"
}

MyBtn_Click(*) {
	WhatToRun := IniRead(".Cmpl8r\FE.ini", "launch", "RunOrEdit")

	if WhatToRun := IniRead(".Cmpl8r\FE.ini", "launch", "RunOrEdit", "")
	{
		MyGui.Hide()
		
		RunWait '"' "Data\" WhatToRun "-in-ator.exe" '"' " " '"' CompileScript '"'
		
		if WhatToRun := IniRead(".Cmpl8r\FE.ini", "launch", "RunOrEdit", "") {
			if not (PID := ProcessExist("Text-in-ator.exe")) {
				if DirExist(A_Temp "\Cmpl8rTE") {
					DirDelete A_Temp "\Cmpl8rTE", 1
					}
				}
			}
		MyGui.Show()
	} else {
		MsgBox "Error! Please select an option", "Error!"
	}
}

MyGui.Show("w150")