@echo off

rem set-executionPolicy remoteSigned

pushd %~dp0

powershell -executionPolicy bypass -file ".\run.ps1" %*

pause