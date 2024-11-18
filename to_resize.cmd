@echo off

rem set-executionPolicy remoteSigned

pushd %~dp0

powershell -executionPolicy bypass -file ".\to_resize.ps1" %*

pause