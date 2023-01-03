setlocal enabledelayedexpansion
set args=
set /a i=0
for %%a in (%*) do (
 set /a i=!i!+1
 if !i! gtr 6 set args=!args! %%a
)
echo "{URL:SCM}" "{URL:HOST}" "{URL:PORT}" "base64({URL:PATH})" "{USERNAME}" "{PASSWORD}" {URL:QUERY}
echo %* 
set loginscript=%tmp%\loginscript
set KiTTY=%~dpn0.exe
set scm=%~1
set host=%~2
set value=%~3
set ls64=%~4
set login=
set password=
if "%scm% %value%"=="tls -1" set value=23
if "%scm%"=="tls" set scm=telnet
rem KeePass ignored {URL:QUERY} if "%scm%"=="telnet"
if "%scm%"=="telnet" goto :nologin
if "%scm%"=="serial" goto :nologin
if "%~5"=="" goto :nologin
set login=-l %~5
if "%scm%"=="rsa" goto :nopassword
if "%~6"=="" goto :nopassword
set password=-pass %~6
:nopassword
:nologin
set option=-P
if "%scm%"=="serial" set option=-sercfg
if "%scm% %value%"=="serial -1" set value=115200
if "%scm%"=="rsa" set scm=ssh
if "%scm% %value%"=="ssh -1" set value=22
set port=%option% %value%
set ls=
if "%ls64%"=="" goto :start
echo %ls64%>%loginscript%64
CertUtil -decode %loginscript%64 %loginscript%
del %loginscript%64
if not exist %loginscript% goto :start
type %loginscript%
set ls=-loginscript %loginscript%
call :start %KiTTY% -%scm% %host% %port% %ls% %login% %password% %args%
timeout /t 2 /NOBREAK
del %loginscript%
goto :EOF
:start
start %KiTTY% -%scm% %host% %port% %ls% %login% %password% %args%
:pause
