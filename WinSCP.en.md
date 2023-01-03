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
- replace first ```?``` of {URL:QUERY} with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line for WinSCP: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
