@echo off


set SMB_NAME=smb
set RUNNING_HASH=
set STOPPED_HASH=


REM
REM exist a running samba server (container)
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`docker ps -q -f name^=^^%SMB_NAME%$`) do ( 
    goto start 
)

REM
REM exist a stopped samba server (container) 
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`docker ps -qa -f name^=^^%SMB_NAME%$`) do ( 
    docker restart %SMB_NAME%
    goto start 
)

REM
REM create samba-public volume
REM
echo create samba-public volume
docker volume create --name samba-public > nul

REM
REM create samba service
REM
echo create samba service
docker run --name %SMB_NAME% -v samba-public:/mnt/public -d dperson/samba  -u "user;password" -g "aio read size = 0" -g "aio write size = 0" -r -s "public;/mnt/public;yes;no;no;all;user" > nul 

:start

FOR /F "tokens=* USEBACKQ" %%F IN (`docker inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" smb`) DO (
SET IP=%%F
)
echo.
echo smaba information 
echo   IP:%IP% 
echo   UserName: user
echo   Password: password
echo.
echo.
echo If you can't connect %IP%, you must key in below in command window with Administrator right firstly
echo.
echo route -p add 172.17.0.0 mask 255.255.255.0 10.0.75.2
echo.

REM
REM if you want map share windows folder, you can change SHARDED_FOLDER
REM

set SHARDED_FOLDER=d:\svn

if exist %SHARDED_FOLDER% set SHARDED_CMD=-v %SHARDED_FOLDER%:/opt2
docker run  -it --rm --workdir=/opt -v samba-public:/opt %SHARDED_CMD% bin601/h2obuild /bin/bash







