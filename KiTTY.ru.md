У KiTTY есть [опция](http://www.9bis.net/kitty/#!pages/LogonScript.md) -loginscript    
Чтобы вызвать KiTTY из KeePass с -loginscript используйте такой url:
```
telnet|tls|serial|ssh|rsa://serverIP/expectPartFirst/sendPartFirst/expectPartSecond/sendPartSecond/.../expectPartLast/sendPartLast?other options for KiTTY
```
Любую часть path можно заменить [ссылкой](https://keepass.info/help/base/placeholders.html)
типа этой:
```
telnet|serial|ssh|rsa://serverIP/{notes}
```
Где в поле notes KeePass:
```
expectPartFirst
sendPartFirst
expectPartSecond
sendPartSecond
...
expectPartLast
sendPartLast
```
### Например:
```
telnet://10.30.15.133/me:/{REF:U@T:tacacs}/rd:/{REF:P@T:tacacs}/>/su/rd:/{REF:P@U:apteka}/sy
```
### Например:
```
tls://10.30.15.133/me:/{REF:U@T:tacacs}/rd:/{REF:P@T:tacacs}/>/su/rd:/{REF:P@U:apteka}/sy?-xpos 0 -ypos 0
```
Вызовёт KiTTY с таким логин скриптом:
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
KeePass игнорирует {URL:QUERY} если {URL:SCM} это telnet, используйте tls вместо telnet для этого
### Например:
```
serial://com5:9600/me:/{REF:U@T:con0}/rd:/{REF:P@T:con0}/%23/conf t
```
Вызовет KiTTY c таким логин скриптом:
me:
```
{REF:U@T:con0}
rd:/{REF:P@T:con0}
#
conf t
```
где ```%23``` в path это закодированный в uri символ ```#``` ({URL:PATH} заканчивается ```?``` или ```#``` {URL:QUERY} заканчивается ```#```)   
- используйте ```%23``` для символа ```#``` в логин скрипте
- используйте ```%3F``` для символа ```?``` в логин скрипте
- используйте ```%2F``` для символа ```/``` в логин скрипте

Если путь к portable_kitty.exe это ```KeePass\..\KiTTY\portable_kitty.exe```
задайте URL override как: [KiTTYurlOverride](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTYurlOverride)   
и запишите в ```KeePass\..\KiTTY\portable_kitty.bat```: [KiTTY_portable.bat](https://github.com/abakum/KeePassURLOverride/blob/main/KiTTY_portable.bat)

##Как это работает:
- заменяет первый ```/``` в path пустой строкой: ```{T-REPLACE-RX:|{URL:PATH}|^/||}```
- заменяет остальные ```/``` в path на ```%0D%0A```: ```{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}```
- раскодирует uri в логин скрипт: ```{T-CONV:`{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}`uri-dec`}```
- кодирует логин скрипт в base64 строку для передачи в bat файл как аргумент: ```"{T-CONV:<{T-CONV:`{T-REPLACE-RX:\{T-REPLACE-RX:|{URL:PATH}|^/||}\/\%0D%0A\}`uri-dec`}<base64<}"```
- заменяет первый ```?``` в query пустой строкой: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- раскодирует uri в параметры KiTTY: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
