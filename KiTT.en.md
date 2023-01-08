KiTTY have -loginscript [option](http://www.9bis.net/kitty/#!pages/LogonScript.md)   
For call KiTTY from KeePass with -loginscript use url like:
```
telne|tl|seria|ss|rs://serverIP/LoginScriptFile?other options for KiTTY
```
### ex:
```
telne://10.30.15.133/tMeSuSy
```
where in file ```KeePass\..\KiTTY\loginscript\tMeSuSy```
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
If path to portable_kitty.exe is ```KeePass\..\KiTTY\portable_kitty.exe```
- write ```KeePass\..\KiTTY\portable_kitty.bat```: [KiTTY_portable.bat](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTY_portable.bat)
- set URL override for rs as: [KiTTYurlOverrideRS](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverrideRS)   
- set URL override for ss, telne, tl, seria as: [KiTTYurlOverrid](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverrid)   

##How it work:
- replace any ```/``` of {URL:PATH} with {ENV_DIRSEP}: ```{T-REPLACE-RX:|{URL:PATH}|/|{ENV_DIRSEP}|}```
- get login script: ```{CMD:`findstr.exe x* {APPDIR}{ENV_DIRSEP}..{ENV_DIRSEP}kiTTY{ENV_DIRSEP}loginscript{T-REPLACE-RX:|{URL:PATH}|/|{ENV_DIRSEP}|}`M=C,WS=H`}```
- encode login script to base64 string for pass to bat file as argument: ```"{T-CONV:<{CMD:`findstr.exe x* {APPDIR}{ENV_DIRSEP}..{ENV_DIRSEP}kiTTY{ENV_DIRSEP}loginscript{T-REPLACE-RX:|{URL:PATH}|/|{ENV_DIRSEP}|}`M=C,WS=H`}<base64<}"```
- replace first ```?``` of query with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line for KiTTY: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
