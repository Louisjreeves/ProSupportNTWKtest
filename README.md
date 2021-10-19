# ProSupportNTWKtest

Automation tool for MS NEtworking 

Thank You Jim Gandy for your help and support.  This is a test of a future network series of test. Hoping to be able to finish it and make it multi-functional

Keep every bit of code you come across and use everything you know and use every bit of code you have to find examples of what works. 

## ProSupportNTWKtest
![ProSupportNTWKtest].(https://user-images.githubusercontent.com/79279019/137941861-659a3acb-c45e-4d53-97b1-d599a696bb69.png)

![alt text](readme/ProSupportNTWKtest.png)
  This tool uses all the files to run a few different types of network pings, latency or bandwidth tests with Test-Netconnection, PSPING and IPV4 Network scan - See: https://github.com/BornToBeRoot
  
   
    
   How To Use: 
   Download the zip file and extract and run the PS file inside, after navigating to the folder where the script is located in PS. 
   I am working on automating this, so the link below does not yet work :
```Powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="TestHVAAllocation";$repo="PowershellScripts"'+(new-object System.net.webclient).DownloadString('https://raw.githubusercontent.com/Louisjreeves/ProSupportNTWKtest/main/ProSupportNTWKTtest.zip'));Invoke-ProSupportNTWKTtest
```
