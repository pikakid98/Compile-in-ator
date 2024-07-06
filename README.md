# Compile-in-ator
A pointless and overly complicated way of renaming batch scripts that compile other scripts inspired by things like Make Cmake etc.

This version and all subsequent versions include the [Turbo](https://github.com/magiblot/turbo) text editor by Magiblot. However, the source code does NOT include it. You'll need to download and/or compile it yourself

> [!WARNING]
> The current version contains a bug when running scripts from within other scripts as it will use your the first working dir
> \
> [Click here for the workaround script](https://github.com/pikakid98/Compile-in-ator/issues/1#issuecomment-2211834764)
> \
> Please also be aware that there are numerous bugs that can occur [[1](https://github.com/pikakid98/Compile-in-ator/issues/2)] [[2](https://github.com/pikakid98/Compile-in-ator/issues/3)] [[3](https://github.com/pikakid98/Compile-in-ator/issues/5)] if closing the command line window

# How to compile
> [!NOTE]
Please also be aware that the base compile file assumes you have my forked Dark Mode for AHK-v2 script downloaded and in a folder above in a folder called "DarkMode". If you would prefer it to all be in the same folder, You can simply edit the .compile script (Please be aware that this tool requires you to have SOME knowledge of Batch.. Not to be confused with Bash)

Another recommendation would be to associate `.compile` files with `Compile-in-ator FE.exe`. That's specifically the frontend

# Build requirements
[AutoHotkey (v2)](https://github.com/AutoHotkey/AutoHotkey)
\
[Ahk2Exe](https://github.com/AutoHotkey/Ahk2Exe)
\
[Upx](https://github.com/upx/upx)
\
[Dark Mode for AHK-v2](https://github.com/pikakid98/Dark-Mode-For-AHK-v2)
\
[Turbo](https://github.com/magiblot/turbo)


# Environment Variables (REQUIRED!!)
`%AHK%`
   Should be set to your AutoHotkey path. An example `C:\Users\username\AutoHotkey` (Make sure you aren't using a subdirectory)
\
`%sevenz%`
	7-Zip is an OPTIONAL tool to extract Turbo.7z which is what I tend to do. Feel free to remove this line