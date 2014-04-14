@echo off

set concat=concat_CSVs.txt
del /q %concat%

for /f "tokens=*" %%d in ('dir /b /o:n /A:-D "*.csv"') do (
	echo # File: %%d
	echo.
	echo # File: %%d>>%concat%
	type %%d>>%concat%
)

