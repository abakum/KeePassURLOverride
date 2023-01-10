WinSCP have /rawconfig [option](https://winscp.net/eng/docs/rawconfig)   
For call WinSCP from KeePass with parameters use url like:
```
sftp|ftp|ftps|ftpes|scp|winscp-http|winscp://serverIP/path?other parameters for WinSCP
```
### ex:
```
scp://10.161.115.160/etc/config/?/rawconfig Interface\Commander\LocalPanel\LastPath=Y:\config\
```
If path to WinSCP.exe is ```KeePass\..\WinSCP\WinSCP.exe```
set URL override for sftp, ftp, ftps, ftpes, scp, winscp-http as: [WinSCPurlOverride](WinSCPurlOverride)   
or create in [Login Dialog](https://winscp.net/eng/docs/ui_login) site ```{USERNAME}@{URL:HOST}``` and set URL override for winscp as: [WinSCPurlOverrideSite](WinSCPurlOverrideSite)   

##How it work:
- replace first ```?``` of {URL:QUERY} with empty string: ```{T-REPLACE-RX:|{URL:QUERY}|^\?||}```
- decode uri to command line parameters for WinSCP: ```{T-CONV:`{T-REPLACE-RX:|{URL:QUERY}|^\?||}`Uri-Dec`}```
