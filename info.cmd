@echo off

rem set-executionPolicy remoteSigned

pushd %~dp0

powershell -executionPolicy bypass -file ".\info.ps1" %*

pause