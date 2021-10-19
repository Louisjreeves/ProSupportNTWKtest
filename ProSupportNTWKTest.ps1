function Show-Menu
{
    param (
        [string]$Title = 'My Menu'
    )

    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' to Ping a destination IP based on a TCP port and secondary ICMP jumbo Ping test."
    Write-Host "2: Press '2' Performance test either Latency or Bandwidth."
    Write-Host "3: Press '3' Query Network for Other devices on subnet which should not be there."
    Write-Host "4: Press '4' Use HNVDIagnostics Module to test the Switch - VIP BGP etc..."
    Write-Host "Q: Press 'Q' to quit."
}

function ping-port # option number 1
{

$OriginalProgressPreference = $Global:ProgressPreference
$Global:ProgressPreference = 'SilentlyContinue'
#write-host "Testing between 2 points can help isolate an issue." -ForegroundColor Green
#$Ans1= Read-host "ENter the IP of the Client (source) Windows device"
$ans2= Read-host "Enter the IP of the Server (destination) that will recieve the packets"
# Use $pwd if you are executing line by line
$ans3 = Read-host "Enter the port of the desired query"
$IPPort= "${ans2}:$ans3"
$IPPort

Test-NetConnection -Port $ans3 -ComputerName $ans2 -InformationLevel Detailed -WarningAction SilentlyContinue$Global:ProgressPreference = $OriginalProgressPreference$ans6= read-host "Test Complete: would you alos like to test jumbo ports for the same address? (y/n)"if ($ans6 -eq "y"){$size= read-host "what size jumbo packet? Less then 8972 recomended.."Write-host "ping.exe $ans2 -l" | Out-File myfile.batSet-Content -path myfile.bat -Value "ping.exe $ans2 -l $size"
cmd /c .\myfile.bat#172.24.66.2}  

 
}

#100.92.24.158:1000:
# psping 192.168.0.160 -h 10 -i 0 -l 1500 -n 10 -4
# psping 192.168.0.160:8181 -4 -h 10 -n 10 -l 1000

Function get-test  # Option numbber 3
{
# https://github.com/Louisjreeves/NetworkMonitoring
# Future option 
#https://github.com/MicrosoftDocs/windows-powershell-docs/blob/master/docset/winserver2019-ps/hnvdiagnostics/HNVDiagnostics.md


Write-host "This will tell you if you have other devices on your subnet and if you may have offending devices" -ForegroundColor green
Write-host " Send a message to suspect users to find out who is on the network - msg * /server:computername message "

    Write-Host "1: Press '1' Best list to get IP,Hostname,mac and vendor (long query)."
    Write-Host "2: Press '2' List a subnet range without DNS Resolver."
    Write-Host "3: Press '3' list a range of start and stop IP addesses within a Subnet."
    Write-Host "Q: Press 'Q' to quit."

    $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         '1' {
             'You chose Mac Resolved List by vendor'
             
             $myans= Read-host "Enter the First IP Address of the CIDR block IE 192.168.0.1"
             $myans2= Read-host "enter the CIDR block # for example 24 for 255 addresses"
            .\IPv4NetworkScan.ps1 -IPv4Address $myans -CIDR $myans2 -EnableMACResolving | out-file mysubnet.txt
           
              Write-host "file written with list of devices, Called mysubnet.txt.
              
               Check it out!" -ForegroundColor Green
              Sleep(4)
         } '2' {
             'You chose to list a subnet range without DNS Resolver'
             $myans= Read-host "Enter the First IP Address of the CIDR block IE 192.168.0.1"
             $myans2= Read-host "enter the subnet address, for example 255.255.255.0"
             .\IPv4NetworkScan.ps1 -IPv4Address $myans -Mask $myans2 -DisableDNSResolving
         } '3' {
             'You chose to list a range of start and stop IP addesses within a Subnet'
             $myans= Read-host "Enter the First IP Address of the range IE 192.168.0.1"
             $myans2= Read-host "enter the Last Ip of the range, for example 192.168.0.200"
             .\IPv4NetworkScan.ps1 -StartIPv4Address $myans -EndIPv4Address $myans2

         }
     }
     pause
 }
 until ($selection -eq 'q')


Function get-histo # Option #2
{

Write-host "latency test is how long it takes informaton to get to its destination, across the network" -ForegroundColor Green
Write-host "Bandwidth Testing is how much data can be written between devices in a givin time" -ForegroundColor Green

do
 {
     
     $ans10= read-host " Which test would you like? 1= Latency or 2= Bandwidth or 3 = simple latency test until Q=Quit"
     switch ($ans10)
     {
         '1' {
             'You chose option #1'
              
Clear-host
Write-host " this test will show a histogram of how long it takes to go from this server to the target."
Write-host " After the series of questions, you will need to copy the the PSPING EXE, along with the batch file called TARGET.BAT to the target machine and run the `
batch file before continuing, Savvy?" -ForegroundColor Green
Write-host "---------------Series of question-----------" -ForegroundColor DarkCyan

# Setup to copy file to other server
$Myansw= Read-host "what IP is the target server?"
$myansw2= read-host "what port is the target server going to listen on?" 
$TargetIPPort= "${Myansw}:$myansw2"
Write-host "psping.exe -s $TargetIPPort -f -accepteula" | Out-File myfile.batSet-Content -path TARGET.bat -Value "psping.exe -s $TargetIPPort -f -accepteula"

# if you wanted to include source ip and port
#$hostansw1 = read-host "what IP is this server sending on? "
#$hostansw2 = read-host "what port is this server sending on? "
#$myhostIPPort= "${hostansw1}:$hostansw2"
# Generate Host side batch file call myfilerun and kick it off
Write-host "place PSPING.EXE and TARGET.BAT on the target host and run in a command window as administrator" -ForegroundColor green
$akey = Read-host "hit a key when you have completed this task and hit enter"

# Setup for This host to begin test
Write-host " this test is for 20 runs of 20 buckets of 9000 bytes of data to the tcp port." -ForegroundColor Green
Write-host "If your other machine is now running Target.bat Myfilerun.bat will be run against it in 4 seconds" -ForegroundColor Green
$an1= Read-host " Acknowledge you need to take a screen shot to get the resulte- When you hit a key then enter to continue- you will loose your test if you dont take a screen shot---"
Sleep(4)
Write-host "psping.exe $TargetIPPort -4 -n 20 -l 9000 -h 20 -accepteula" | Out-File myfilerun.batSet-Content -path myfilerun.bat -Value "psping.exe $TargetIPPort -4 -n 20 -l 9000 -h 20 -accepteula"
cmd /c .\myfilerun.bat

# latency 4000 packets with 5000 bytes- psping -4 -n 4000 -l 5000 172.24.66.2:89 -h -accepteula
#psping -4 -h 20 -n 20 -l 1000 10.44.1.12:8181

#server Psping -s 100.72.4.39:1000 -f
         } '2' {
             
             
             Clear-host
write-host " you choose 2... Bandwidth measure"
Write-host " this test will show a bandwith for 4000 packets with 5000 bytes of data to go from this server to the target."
Write-host " After the series of questions, you will need to copy the the PSPING EXE, along with the batch file called TARGET.BAT to the target machine and run the `
batch file before continuing, Savvy?" -ForegroundColor Green
Write-host "---------------Series of question-----------" -ForegroundColor DarkCyan

# Setup to copy file to other server
$Myansw= Read-host "what IP is the target server?"
$myansw2= read-host "what port is the target server going to listen on?" 
$TargetIPPort= "${Myansw}:$myansw2"
Write-host "psping.exe -s $TargetIPPort -f -accepteula" | Out-File TARGET.BATSet-Content -path TARGET.bat -Value "psping.exe -s $TargetIPPort -f -accepteula"

# if you wanted to use source server info
#$hostansw1 = read-host "what IP is this server sending on? "
#$hostansw2 = read-host "what port is this server sending on? "
#$myhostIPPort= "${hostansw1}:$hostansw2"
# Generate Host side batch file call myfilerun and kick it off
Write-host "place PSPING.EXE and TARGET.BAT on the target host and run in a command window as administrator" -ForegroundColor green
$akey = Read-host "hit a key when you have completed this task"

# Setup for This host to begin test
Write-host " this test is for 20 runs of 20 buckets of 9000 bytes of data to the tcp port." -ForegroundColor Green
Write-host "If your other machine is now running Target.bat Myfilerun.bat will be run against it in 4 seconds" -ForegroundColor Green
$an1= Read-host " Acknowledge you need to take a screen shot to get the resulte- When you hit enter to continue- you will loos your test---"
Sleep(4)
Write-host "psping.exe -b -4 -n 4000 -l 5000 $TargetIPPort -accepteula" | Out-File myfilerun.batSet-Content -path myfilerun.bat -Value "psping.exe -b -4 -n 4000 -l 5000 $TargetIPPort -accepteula"
# this test psping -b -4 -n 4000 -l 5000 172.24.66.2:89
cmd /c .\myfilerun.bat

#psping -4 -h 20 -n 20 -l 1000 10.44.1.12:8181

#server Psping -s 100.72.4.39:1000 -f

         } '3' {
             'You chose option #3'
             write-host " you choose 3"

$ans4= Read-host "Enter the IP of the Server (destination) that will recieve the packets"
# Use $pwd if you are executing line by line
$ans5 = Read-host "Enter the port of the desired query"
$IPPort= "${ans4}:$ans5"
#100.26.66.2
Write-host "psping.exe $IPPort -nobanner -I 0 -h -q" | Out-File myfilerun.batSet-Content -path myfilerun.bat -Value "psping.exe $IPPort -nobanner -I 0 -h -q -accepteula"
cmd /c .\myfilerun.bat




#client psping -h 10 -i 0 -l 1500 -n 100 -4 100.72.4.39:999
#$ans4= Read-host "Enter the IP of the Server (destination) that will recieve the packets"
# Use $pwd if you are executing line by line
#$ans5 = Read-host "Enter the port of the desired query"
#$IPPort= "${ans4}:$ans5"

#Write-host "psping.exe $IPPort -nobanner -I 0 -h -q" | Out-File myfile.bat#Set-Content -path myfile.bat -Value "psping.exe $IPPort -nobanner -I 0 -h -q"
#cmd /c .\myfile.bat
 
#Psping -nobanner -I 0 -h -q 192.168.0.160:443
#psping.exe -nobanner -I 0 -h -q 192.168.0.160:80
         }
     }
     pause
 }
 until ($ans10 -eq 'q')
}


Function get-trace # option 4
{
# https://devblogs.microsoft.com/scripting/packet-sniffing-with-powershell-getting-started/
Write-host " future testing to include HVNetwork tests possibly- modularized https://github.com/MicrosoftDocs/windows-powershell-docs/blob/master/docset/winserver2019-ps/hnvdiagnostics/HNVDiagnostics.md" -foregroundcolor green 
}


$PSScriptRoot 

$url= "http://live.sysinternals.com/psping.exe"
$output = "$PSScriptRoot\PSPING.Exe"
$start_time = Get-Date

# $wc = New-Object System.Net.WebClient
# $wc.DownloadFile($url, $output)
#OR
(New-Object System.Net.WebClient).DownloadFile($url, $output)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Write-host " choose your test" -ForegroundColor Green
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         '1' {
             'You chose option #1'
             clear-host
              ping-port
         } '2' {
             'You chose option #2'
             Get-histo
         } '3' {
             'You chose option #3'
             get-test
         } '4' {
             'You chose option #4'
             get-trace
     }
         }
     pause
 }
 until ($selection -eq 'q')