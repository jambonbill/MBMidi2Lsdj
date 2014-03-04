@echo off

echo Removing temporary files

if exist _output del /s /q _output
if exist project.cod del /q project.cod
if exist project.map del /q project.map
if exist project.lst del /q project.lst

