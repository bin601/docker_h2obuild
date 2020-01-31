@echo off
setlocal enableextensions 

set BASE_IMAGE=bin601/h2obuild
set CONTAINER=%USERNAME%_h2obuild_app 
set START_SHELL=/bin/bash 
set SOURCE_FOLDER=d:\svn


FOR /F "tokens=* USEBACKQ" %%F IN (`docker ps -q -f name^=%CONTAINER%`) do ( 
    SET HASH=%%F
)
FOR /F "tokens=* USEBACKQ" %%F IN (`docker ps -qa -f name^=%CONTAINER%`) do ( 
    SET HASH_STOPPED=%%F
)

if "%1" == "new" (
  docker run -it --rm -v %SOURCE_FOLDER%:/opt  %BASE_IMAGE% %START_SHELL%
  goto :EOF
)

if not "%HASH%" == "" (
    echo "founding existing running container %CONTAINER%, proceed to exec another shell"
    docker exec -it %HASH% %START_SHELL%
    goto :EOF
) 

if not "%HASH_STOPPED%" == "" (
    echo "founding existing stopped container %CONTAINER%, proceed to start"
    docker start --attach -i %HASH_STOPPED%
    goto :EOF
) else (
    echo "existing container not found, createing a new one, named %CONTAINER%"
    docker run --name=%CONTAINER% --hostname=%CONTAINER% -it  -v %SOURCE_FOLDER%:/opt -v samba-public:/opt2 %BASE_IMAGE% %START_SHELL% 
)


REM set HASH=
REM docker run  -it --rm  -v d:\svn:/opt bin601/h2obuild  /bin/bash
