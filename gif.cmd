@echo off

rem set-executionPolicy remoteSigned

pushd %~dp0

powershell -executionPolicy bypass -file ".\gif.ps1" %*

pause