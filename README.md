# Compile-in-ator
 A pointless and overly complicated way of renaming batch scripts that compile other scripts inspired by things like Make Cmake etc.

This version and all subsequent versions include the [Turbo](https://github.com/magiblot/turbo) text editor by Magiblot. However, the source code does NOT include it. You'll need to download and/or compile it yourself

Please also be aware that the base compile file assumes you have my forked Dark Mode for AHK-v2 script downloaded and in a folder above in a folder called "DarkMode". If you would prefer it to all be in the same folder, You can simply edit the .compile script (Please be aware that this tool requires you to have SOME knowledge of Batch.. Not to be confused with Bash)

Another recommendation would be to associate `.compile` files with `Compile-in-ator FE.exe`. That's specifically the frontend

# Known issue
There's an issue when trying to run the compiler from in a sub-script.. Example, you're compiling one program which calls to another .compile file from within.. Doing this causes a weird issue which I'm still trying to figure out. For now, Please include this in your code

<details>
<summary>Click here to expand</summary>

```
PUSHD "%CD%"

cd "{PATH}"
mkdir ".Cmpl8r"
copy ".compile" ".Cmpl8r"
ren ".Cmpl8r\.compile" "[CompileTemp].bat"
call ".Cmpl8r\[CompileTemp].bat"
rmdir ".Cmpl8r" /S /Q

POPD

robocopy "{PATH}\Output" "Output" /MIR

rmdir "{PATH}\Output" /S /Q
```

Make sure to replace `{PATH}` with the actual path

</details>

# Build requirements
[AutoHotkey (v2)](https://github.com/AutoHotkey/AutoHotkey)
\
[Ahk2Exe](https://github.com/AutoHotkey/Ahk2Exe)
\
[Upx](https://github.com/upx/upx)
\
[Dark Mode for AHK-v2](https://github.com/Git-Pikakid98/Dark-Mode-For-AHK-v2)
\
[Turbo](https://github.com/magiblot/turbo)


# Environment Variables (REQUIRED!!)
`%AHK%`
   Should be set to your AutoHotkey path. An example `C:\Users\username\AutoHotkey` (Make sure you aren't using a subdirectory)
\
`%sevenz%`
	7-Zip is an OPTIONAL tool to extract Turbo.7z which is what I tend to do. Feel free to remove this line