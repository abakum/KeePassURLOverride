У KiTTY есть [опция](http://www.9bis.net/kitty/#!pages/LogonScript.md) -loginscript    
Чтобы вызвать KiTTY из KeePass с -loginscript используйте такой url:
```
telne|tl|seria|ss|rs://serverIP/LoginScriptFile?other options for KiTTY
```
### ex:
```
telne://10.30.15.133/tMeSuSy
```
где в файле KeePass\..\KiTTY\loginscript\tMeSuSy
```
me:
{REF:U@T:tacacs}
rd:
{REF:P@T:tacacs}
>
su
rd:
{REF:P@U:apteka}
>
sy
```
Если путь к portable_kitty.exe это ```KeePass\..\KiTTY\portable_kitty.exe```
- запишите в ```KeePass\..\KiTTY\portable_kitty.bat```: [KiTTY_portable.bat](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTY_portable.bat)
- задайте URL override для rs as: [KiTTYurlOverrideRS](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverrideRS)   
- задайте URL override для ss, telne, tl, seria as: [KiTTYurlOverrid](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverrid)   

##Как это работает:
- заменяет любой ```/``` в {URL:PATH} на {ENV_DIRSEP}: ```{T-REPLACE-RX:|{URL:PATH}|/|{ENV_DIRSEP}|}```
- читает логин скрипт: ```{CMD:`findstr.exe x* {APPDIR}{ENV_DIRSEP}..{ENV_DIRSEP}kiTTY{ENV_DIRSEP}loginscript{T-REPLACE-RX:|{URL:PATH}|/|{ENV_DIRSEP}|}`M=C,WS=H`}```
- кодирует логин скрипт в base64 строку для передачи в bat файл как аргумент: ```"{T-CONV:<{CMD:`findstr.exe x* {APPDIR}{ENV_DIRSEP}..{ENV_DIRSEP}kiTTY{ENV_DIRSEP}loginscript{T-REPLACE-RX:|{URL:PATH}|/|{ENV_DIRSEP}|}`M=C,WS=H`}<base64<}"```
- заменяет первый ```?``` в query пустой строкой: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- раскодирует uri в параметры KiTTY: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
