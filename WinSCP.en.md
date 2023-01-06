WinSCP have /rawconfig [option](https://winscp.net/eng/docs/rawconfig)   
For call WinSCP from KeePass with parameters use url like:
```
sftp|ftp|ftps|ftpes|scp|winscp-http://serverIP/path?other parameters for WinSCP
```
### ex:
```
scp://10.161.115.160/etc/config/?/rawconfig Interface\Commander\LocalPanel\LastPath=Y:\config\
```
If path to WinSCP.exe is ```KeePass\..\WinSCP\WinSCP.exe```
set URL override for sftp, ftp, ftps, ftpes, scp, winscp-http as: [WinSCPurlOverride](https://github.com/abakum/KeePassURLOverride/blob/main/WinSCPurlOverride)   

##How it work:
- replace first ```?``` of {URL:QUERY} with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line parameters for WinSCP: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
