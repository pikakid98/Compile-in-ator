#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Off

;@Ahk2Exe-Set FileVersion, 1.0
;@Ahk2Exe-Set ProductVersion, 1.0.0.0
;@Ahk2Exe-Set CompanyName, Pikakid98

if not FileExist(A_Temp "\Cmpl8r") {
	DirCreate A_Temp "\Cmpl8r"
}

if A_Args.Length < 1
{
    SelectedFile := FileSelect(3, , "Open a file", "Compile-in-ator scripts (*.compile)")
	if SelectedFile = "" {
		ExitApp
	} else {
		DirCreate A_Temp "\Cmpl8r"
		IniWrite "", A_Temp "\Cmpl8r\FE.ini", "launch", "RunOrEdit"
		IniWrite '"' SelectedFile '"', A_Temp "\Cmpl8r\FE.ini", "launch", "CompileScript"
	}
}

if A_Args.Length = 1 {
	DirCreate A_Temp "\Cmpl8r"
	IniWrite "", A_Temp "\Cmpl8r\FE.ini", "launch", "RunOrEdit"
	IniWrite '"' A_Args[1] '"', A_Temp "\Cmpl8r\FE.ini", "launch", "CompileScript"
}

CompileScript := IniRead(A_Temp "\Cmpl8r\FE.ini", "launch", "CompileScript")

Loop Files, CompileScript, "F"
SetWorkingDir A_LoopFileDir

MyGui := Gui()

; call dark mode for window title + menu
SetWindowAttribute(MyGui)

; call dark mode for controls
SetWindowTheme(MyGui)

#include DarkMode.scriptlet

MyGui.Title := "Compile-in-ator FE (v1.0)"

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {
	if not (PID := ProcessExist("Compile-in-ator FE.exe")) {
		DirDelete A_Temp "\Cmpl8r", 1
		ExitApp
	}
	ExitApp
}

MyRadio := MyGui.AddRadio("vMyRadioGroup cwhite", "Compile")
MyRadio.OnEvent("Click", MyBtn_op1)

if (PID := ProcessExist("turbo.exe")) {
	FakeLink := MyGui.Add("Text", "", "Edit [Unavailable]")
} else {
	MyRadio2 := MyGui.AddRadio("vMyRadioGroup2 cwhite", "Edit")
	MyRadio2.OnEvent("Click", MyBtn_op2)
}

MyBtn := MyGui.AddButton("Default w80", "OK")
MyBtn.OnEvent("Click", MyBtn_Click)

MyBtn_op1(*)
{
	IniWrite A_ScriptDir "\Data\Compile-in-ator.exe", A_Temp "\Cmpl8r\FE.ini", "launch", "RunOrEdit"
}

MyBtn_op2(*)
{
	IniWrite A_ScriptDir "\Data\Text-in-ator.exe", A_Temp "\Cmpl8r\FE.ini", "launch", "RunOrEdit"
}

MyBtn_Click(*) {
	WhatToRun := IniRead(A_Temp "\Cmpl8r\FE.ini", "launch", "RunOrEdit")

	if WhatToRun := IniRead(A_Temp "\Cmpl8r\FE.ini", "launch", "RunOrEdit", "")
	{
		MyGui.Hide()
		RunWait '"' WhatToRun '"' " " '"' CompileScript '"'
			
		if FileExist(A_Temp "\Cmpl8r\FE.ini")
		{
			MyGui.Show()
		} else {
			ExitApp
		}
	} else {
		MsgBox "Error! Please select an option", "Error!"
	}
}

MyGui.Show("w150")