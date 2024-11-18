@echo off

rem set-executionPolicy remoteSigned

pushd %~dp0

powershell -executionPolicy bypass -file ".\to_mp4.ps1" %*

pause