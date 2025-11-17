@echo off
cd /d "V:\Steam\SteamApps\common\GarrysMod\bin"
gmad.exe create -folder "D:\Github\sui-scoreboard" -out "D:\Github\sui-scoreboard.gma"
gmpublish update -addon "D:\Github\sui-scoreboard.gma" -id "160121673" -changes "Change it later"
pause