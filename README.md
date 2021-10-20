# ProSupportNTWKtest

Automation tool for MS NEtworking 

Thank You Jim Gandy for your help and support.  This is a test of a future network series of test. Hoping to be able to finish it and make it multi-functional

Keep every bit of code you come across and use everything you know and use every bit of code you have to find examples of what works. 

The Tests I have made Do work, but I am hoping to make this a more advanced tool at some point. If I didnt, it at least works, providing basic tests. 

## ProSupportNTWKtest
![NTWKPic](https://user-images.githubusercontent.com/79279019/138011794-f2ad773f-b458-4f36-af78-2a89e3533f22.png)
 
This tool uses all the files to run a few different types of network pings, latency or bandwidth tests with Test-Netconnection, PSPING and IPV4 Network scan - See: https://github.com/BornToBeRoot
  
   

    
   How To Use: 
 Use the URL Below. Put into a powershell window and the files will download into the Downloads Folder. They will unzip and ProSupportNTWKTest will begin. You will 
 see the menu in the above screen shot. You may Test Ports and IP with Menu item 1. You may perform tests with Menu Item 2 and Menu Item 3 is to query a subnet for 
 Mac Addresses in a subnet. This will verify if a Vlan is working and keeping only macs in one segment, showing up in the returned list. :
```Powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="TestHVAAllocation";$repo="PowershellScripts"'+(new-object System.net.webclient).DownloadString('https://raw.githubusercontent.com/Louisjreeves/ProSupportNTWKtest/main/ExpandAnd Run.ps1')); Invoke-ProSupportNTWKTtest
```
