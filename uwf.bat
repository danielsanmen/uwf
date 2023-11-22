@echo off
:opcion
cls
powershell -command "uwfmgr get-config" > "C:\Users\Public\Documents\uwf.txt"
type "C:\Users\Public\Documents\uwf.txt" | findstr /n "^" | findstr /b "8:"
echo Espacio Ocupado:
powershell -command "uwfmgr overlay get-consumption"
echo Espacio libre:
powershell -command "uwfmgr overlay get-availablespace"
echo  :
echo  : Elija una opcion:
echo  :
echo  : 1. Configuración Inicial
echo  : 2. Activar UWF
echo  : 3. Desactivar UWF
echo  : 4. Forzar actualizaciones
echo  : 5. Mostrar configuracion
echo  : 6. Reiniciar
echo  : 0. Salir
echo  :
set /p opcion=  : Ingrese el numero de la opcion que desea elegir:
if %opcion%==1 goto opcion1
if %opcion%==2 goto opcion2
if %opcion%==3 goto opcion3
if %opcion%==4 goto opcion4
if %opcion%==5 goto opcion5
if %opcion%==6 goto opcion6
if %opcion%==0 goto opcion0
echo Opcion invalida. Intentelo de nuevo.
pause
goto opcion
exit

:opcion1
cls
echo Se está preparando la configuración inicial...
powershell -command "uwfmgr overlay set-type Disk"
echo - Se ha cambiado al guardado en disco.
powershell -command "uwfmgr overlay set-size 8192"
echo - Se ha aumentado el tamaño a 8Gb.
powershell -command "uwfmgr overlay set-criticalthreshold 8192"
echo - Se ha configurado la alerta crítica a 8Gb.
powershell -command "uwfmgr overlay set-warningthreshold 7168"
echo - Se ha configurado la primera alerta a 7Gb.
powershell -command "uwfmgr volume protect C:"
echo - Se ha activado UWF para la unidad C:
pause
goto opcion

:opcion2
cls
powershell -command "uwfmgr filter enable"
echo Se ha activado UWF. Debe reiniciar el equipo (5.)
pause
goto opcion

:opcion3
cls
powershell -command "uwfmgr filter disable"
echo Se ha desactivado UWF. Debe reiniciar el equipo (5.)
pause
goto opcion

:opcion4
cls
powershell -command "uwfmgr servicing update-windows"
echo Se han forzado las actualizaciones.
echo Actualice Windows y reinicie el equipo.
echo UWF permanecerá activado.
pause
goto opcion

:opcion5
cls
powershell -command "uwfmgr get-config" > "C:\Users\Public\Documents\uwf.txt"
start "C:\Users\Public\Documents\uwf.txt"
echo Se ha mostrado el archivo de configuracion.
pause
goto opcion

:opcion6
cls
echo Preparado para reiniciar el equipo.
pause
shutdown -r -t 5
cls
exit

:opcion0
cls
exit