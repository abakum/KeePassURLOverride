KiTTY have -loginscript [option](http://www.9bis.net/kitty/#!pages/LogonScript.md)   
For call KiTTY from KeePass with -loginscript use url like:
```
telne|tl|seria|ss|rs://serverIP/LoginScriptFile?other options for KiTTY
```
### ex:
```
telne://10.30.15.133/tMeSuSy
```
where in ..\KiTTY\loginscript\tMeSuSy
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
- set URL override for rs as: [KiTTYurlOverrideRSA](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverrideRSA)   
- set URL override for ss, telne, tl, seria as: [KiTTYurlOverride](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverrid)   

##How it work:
- replace first ```/``` of path with empty string: ```{T-REPLACE-RX:|{URL:PATH}|^/||}```
- replace other ```/``` of path witn ```%0D%0A```: ```{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}```
- decode uri to login script: ```{T-CONV:`{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}`uri-dec`}```
- encode login script to base64 string for pass to bat file as argument: ```"{T-CONV:<{T-CONV:`{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}`uri-dec`}<base64<}"```
- replace first ```?``` of query with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line for KiTTY: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
