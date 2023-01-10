WinSCP имеет  [опцию](https://winscp.net/eng/docs/rawconfig) /rawconfig   
Чтоб вызвать WinSCP из KeePass с параметрами, укажите url типа этого:
```
sftp|ftp|ftps|ftpes|scp|winscp-http://serverIP/path?other parametrs for WinSCP
```
### Например:
```
scp://10.161.115.160/etc/config/?/rawconfig Interface\Commander\LocalPanel\LastPath=Y:\config\
```
Если путь до  WinSCP.exe это ```KeePass\..\WinSCP\WinSCP.exe```
установите URL override для sftp, ftp, ftps, ftpes, scp, winscp-http как: [WinSCPurlOverride](WinSCPurlOverride)   
или создайте в [Login window](https://winscp.net/eng/docs/ui_login) site ```{USERNAME}@{URL:HOST}``` и установите URL override для winscp как: [WinSCPurlOverrideSite](WinSCPurlOverrideSite)   

##Как это работает:
- заменяет первый ```?``` в {URL:QUERY} пустой строкой: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- декодирует uri в параметры WinSCP: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
