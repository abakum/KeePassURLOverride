# KeePassURLOverride
KeePass URL Override for KiTTY and WinSCP
## Credits
- [Dominik Reichl](https://keepass.info) - for KeePass
- [Cyril as Cyd](https://github.com/cyd01/KiTTY) - for KiTTY
- [Martin Přikryl](https://github.com/winscp/winscp) - for WinSCP
## Usage
- Look usage [KiTTY](https://github.com/abakum/KeePassURLOverride/blob/master/KiTTY.en.md) [WinSCP](https://github.com/abakum/KeePassURLOverride/blob/master/WinSCP.en.md)
- Смотри использование [KiTTY](https://github.com/abakum/KeePassURLOverride/blob/master/KiTTY.ru.md) [WinSCP](https://github.com/abakum/KeePassURLOverride/blob/master/WinSCP.ru.md)

# KeePass URL Override for KiTTY
KiTTY have -loginscript [option](http://www.9bis.net/kitty/#!pages/LogonScript.md)   
For call KiTTY from KeePass with -loginscript use url like:
```
telnet|tls|serial|ssh|rsa://serverIP/expectPartFirst/sendPartFirst/expectPartSecond/sendPartSecond/.../expectPartLast/sendPartLast?other options for KiTTY
```
any part of path my be [placeholder](https://keepass.info/help/base/placeholders.html)
like:
```
telnet|serial|ssh|rsa://serverIP/{notes}
```
where in notes:
```
expectPartFirst
sendPartFirst
expectPartSecond
sendPartSecond
...
expectPartLast
sendPartLast
```
### ex:
```
telnet://10.30.15.133/me:/{REF:U@T:tacacs}/rd:/{REF:P@T:tacacs}/>/su/rd:/{REF:P@U:apteka}/sy
```
### ex:
```
tls://10.30.15.133/me:/{REF:U@T:tacacs}/rd:/{REF:P@T:tacacs}/>/su/rd:/{REF:P@U:apteka}/sy?-xpos 0 -ypos 0
```
call KiTTY with login script:
```
me:
{REF:U@T:tacacs}
rd:
{REF:P@T:tacacs}
>
su
rd:
{REF:P@U:apteka}
sy
```
KeePass ignored {URL:QUERY} if {URL:SCM} is telnet, use tls instead telnet for that   
### ex:
```
serial://com5:9600/me:/{REF:U@T:con0}/rd:/{REF:P@T:con0}/%23/conf t
```
call KiTTY with login script:
me:
```
{REF:U@T:con0}
rd:/{REF:P@T:con0}
#
conf t
```
where ```%23``` in path is uri encoded char ```#``` ({URL:PATH} must ended with ```?``` or ```#``` {URL:QUERY} must ended with ```#```)   
- use ```%23``` for char ```#``` in login script
- use ```%3F``` for char ```?``` in login script
- use ```%2F``` for char ```/``` in login script

If path to portable_kitty.exe is ```KeePass\..\KiTTY\portable_kitty.exe```
set URL override as: [KiTTYurlOverride](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverride)   
and write ```KeePass\..\KiTTY\portable_kitty.bat```: [KiTTY_portable.bat](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTY_portable.bat)

##How it work:
- replace first ```/``` of path with empty string: ```{T-REPLACE-RX:|{URL:PATH}|^/||}```
- replace other ```/``` of path witn ```%0D%0A```: ```{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}```
- decode uri to login script: ```{T-CONV:`{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}`uri-dec`}```
- encode login script to base64 string for pass to bat file as argument: ```"{T-CONV:<{T-CONV:`{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}`uri-dec`}<base64<}"```
- replace first ```?``` of query with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line for KiTTY: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```

# KeePass URL Override for WinSCP
WinSCP have /rawconfig [option](https://winscp.net/eng/docs/rawconfig)   
For call WinSCP from KeePass with options use url like:
```
scp|winscp-http://serverIP/path?other options for WinSCP
```
### ex:
```
scp://10.161.115.160/etc/config/?/rawconfig Interface\Commander\LocalPanel\LastPath=Y:\config\
```
If path to WinSCP.exe is ```KeePass\..\WinSCP\WinSCP.exe```
set URL override as: [WinSCPurlOverride](https://github.com/abakum/KeePassURLOverride/blob/main/WinSCPurlOverride)   

##How it work:
- replace first ```?``` of query with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line for WinSCP: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
