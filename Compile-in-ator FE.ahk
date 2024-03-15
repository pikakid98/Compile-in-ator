#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Off

;@Ahk2Exe-Set FileVersion, 1.1.0
;@Ahk2Exe-Set ProductVersion, 1.1.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

if not DirExist(A_Temp "\Cmpl8rFE") {
	DirCreate A_Temp "\Cmpl8rFE"
}

if A_Args.Length < 1
{
    SelectedFile := FileSelect(3, , "Open a file", "Compile-in-ator scripts (*.compile)")
	if SelectedFile = "" {
		ExitApp
	} else {
		DirCreate A_Temp "\Cmpl8rFE"
		IniWrite "", A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit"
		IniWrite '"' SelectedFile '"', A_Temp "\Cmpl8rFE\FE.ini", "launch", "CompileScript"
	}
}

if A_Args.Length = 1 {
	DirCreate A_Temp "\Cmpl8rFE"
	IniWrite "", A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit"
	IniWrite '"' A_Args[1] '"', A_Temp "\Cmpl8rFE\FE.ini", "launch", "CompileScript"
}

CompileScript := IniRead(A_Temp "\Cmpl8rFE\FE.ini", "launch", "CompileScript")

Loop Files, CompileScript, "F"
SetWorkingDir A_LoopFileDir

MyGui := Gui()

; call dark mode for window title + menu
SetWindowAttribute(MyGui)

; call dark mode for controls
SetWindowTheme(MyGui)

#include DarkMode.scriptlet

MyGui.Title := "Compile-in-ator FE (v1.1)"

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {
	if DirExist(A_Temp "\Cmpl8rFE") {
		DirDelete A_Temp "\Cmpl8rFE", 1
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
	if not DirExist(A_Temp "\Cmpl8rFE") {
		DirCreate A_Temp "\Cmpl8rFE"
	}
	IniWrite "Data\Compile-in-ator.exe", A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit"
}

MyBtn_op2(*)
{
	if not DirExist(A_Temp "\Cmpl8rFE") {
		DirCreate A_Temp "\Cmpl8rFE"
	}
	IniWrite "Data\Text-in-ator.exe", A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit"
}

MyBtn_Click(*) {
	WhatToRun := IniRead(A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit")

	if WhatToRun := IniRead(A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit", "")
	{
		MyGui.Hide()
		RunWait '"' WhatToRun '"' " " '"' CompileScript '"'
			
		if WhatToRun := IniRead(A_Temp "\Cmpl8rFE\FE.ini", "launch", "RunOrEdit", "Data\Text-in-ator.exe")
		{
			if not (PID := ProcessExist("turbo.exe")) {
				DirDelete A_Temp "\Cmpl8rTE", 1
			}
			MyGui.Show()
		} else {
			ExitApp
		}
	} else {
		MsgBox "Error! Please select an option", "Error!"
	}
}

MyGui.Show("w150")