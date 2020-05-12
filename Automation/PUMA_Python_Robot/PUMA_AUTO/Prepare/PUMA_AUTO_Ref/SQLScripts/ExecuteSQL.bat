@echo off
cd  %~dp0
for %%i in (%CD%\*.sql) do (
    set outputpath=%%ilog
    echo %outputpath%
    sqlcmd -U sa -P sa20021224$ -S localhost\GCPACSWS -i %%i
)



