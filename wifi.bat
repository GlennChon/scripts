@ECHO off
SETLOCAL enabledelayedexpansion
:: ---------------------------------------------------------------------------------------------:: 
:: - Displays wlan profile name and key if security key is present.
:: ---------------------------------------------------------------------------------------------:: 
SET profile_name=
SET available=
SET wifi_pass=

FOR /F "tokens=2 delims=: " %%n in ('netsh wlan show interfaces ^| find "Profile"') DO (
	SET "profile_name=%%n"
)
FOR /F "tokens=3 delims=: " %%k in ('netsh wlan show profile name^="%profile_name%" ^| findstr "Security key"') DO (
	SET "available=%%k"
)	
FOR /F "tokens=3 delims=: " %%p in ('netsh wlan show profile name^="%profile_name%" key^=clear ^| findstr "Key Content"') DO (
	SET "wifi_pass=%%p"
)	
	
ECHO Profile: %profile_name%
ECHO Security Key: %available%
IF Present == %available% (
	ECHO Password: %wifi_pass%
)
