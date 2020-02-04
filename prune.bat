FOR /f "tokens=*" %%i IN ('docker ps -aq -f ancestor^=bin601/h2obuild') DO docker rm -f %%i 

REM wait 5s to close dialog 
@ping 127.0.0.1 -n 5 -w 1000 > nul