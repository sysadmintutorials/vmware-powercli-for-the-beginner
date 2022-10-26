### Extracting vSphere Information ###
### Version 1.1                    ###
### Date: 26/10/2022               ###
### Author: Your Name              ###
######################################

### Variables

$date = (Get-Date).ToString("dd-MM-yyyy") # Can also change to MM-dd-yyy
$htmlfile = "C:\Scripts\vsphere-report.html" # Change the location to suite you

### Remove any old HTML files

Remove-Item $htmlfile -force

### Connecting to vCenter

Connect-VIServer -Server yourserver.yourdomain # Enter in your vCenter Server FQDN or IP

#### Create HTML

## Main HTML

Add-Content $htmlfile "<!DOCTYPE html>"
Add-Content $htmlfile "<html>"
Add-Content $htmlfile "<head>"
Add-Content $htmlfile "<title>VMware vSphere Report</title>"
Add-Content $htmlfile "<center><h1 style='font-size:36px;'>VMWARE VSPHERE REPORT: $($date)</h1></center>"

## Table Style

Add-Content $htmlfile "<style>"
Add-Content $htmlfile "table, th, td {"
Add-Content $htmlfile "border: 1px solid black;"
Add-Content $htmlfile "}"
Add-Content $htmlfile "th, td {"
Add-Content $htmlfile "padding: 10px;"
Add-Content $htmlfile "}"
Add-Content $htmlfile "</style>"

## Close Heading, Start Body

Add-Content $htmlfile "</head>"
Add-Content $htmlfile "<body>"

## Main border

Add-Content $htmlfile "<center>" # Center Border
Add-Content $htmlfile "<table>" # New Table
Add-Content $htmlfile "<tr>" # New Row
Add-Content $htmlfile "<th>" # New Heading

## Write Hosts Heading

Add-Content $htmlfile "<center><h2>Hosts</h2></center>"

## Start New Table and Write Headings

Add-Content $htmlfile "<center>" # Center Table
Add-Content $htmlfile "<table>" # New Table
Add-Content $htmlfile "<tr>" # New Row
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Name</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Server Model</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>CPU's</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Memory GB</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Version</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Build</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Overall Status</th>" # Heading
Add-Content $htmlfile "</tr>" # Close Heading Row

## Get Host Information and Write to HTML File

$vmhosts = Get-VMHost | Sort-Object Name

ForEach($vmhost in $vmhosts)
    {
    Write-Host "-----"
    Write-Host $vmhost.Name
    Write-Host $vmhost.Model
    Write-Host $vmhost.NumCpu
    Write-Host [Int]$vmhost.MemoryTotalGB
    Write-Host $vmhost.Version
    Write-Host $vmhost.Build
    Write-Host $vmhost.ExtensionData.OverallStatus

    Add-Content $htmlfile "<tr>" # New Row
    Add-Content $htmlfile "<td>$($vmhost.Name)</td>" # Data
    Add-Content $htmlfile "<td>$($vmhost.Model)</td>" # Data
    Add-Content $htmlfile "<td>$($vmhost.NumCpu)</td>" # Data
    Add-Content $htmlfile "<td>$([Int]$vmhost.MemoryTotalGB)</td>" # Data
    Add-Content $htmlfile "<td>$($vmhost.Version)</td>" # Data
    Add-Content $htmlfile "<td>$($vmhost.Build)</td>" # Data
    Add-Content $htmlfile "<td>$($vmhost.ExtensionData.OverallStatus)</td>" # Data
    Add-Content $htmlfile "</tr>" # Close Row
    }

## Close Table

Add-Content $htmlfile "</table>" # Close Table
Add-Content $htmlfile "</center>" # Close Center Table

## Write Virtual Machines Heading

Add-Content $htmlfile "<center><h2>Virtual Machines</h2></center>"

Add-Content $htmlfile "<center>" # Center Table
Add-Content $htmlfile "<table>" # New Table
Add-Content $htmlfile "<tr>" # New Row
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Name</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>CPU's</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Memory GB</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Storage GB</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Power State</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Hardware Version</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>VM Tools Status</th>" # Heading
Add-Content $htmlfile "<th style='background-color:#f7ce5e;'>Overall Status</th>" # Heading
Add-Content $htmlfile "</tr>" # Close Row

## Get Virtual Machine Information and Write to HTML File

$vms = Get-VM | Sort-Object Name

ForEach ($vm in $vms)
    {
    Write-Host "-----"
    Write-Host $vm.Name
    Write-Host $vm.NumCpu
    Write-Host $vm.MemoryGB
    Write-Host $vm.ProvisionedSpaceGB
    Write-Host $vm.PowerState
    Write-Host $vm.HardwareVersion
    Write-Host $vm.ExtensionData.Guest.ToolsStatus
    Write-Host $vm.ExtensionData.OverallStatus

    Add-Content $htmlfile "<tr>" # New Row
    Add-Content $htmlfile "<td>$($vm.Name)</td>" # Data
    Add-Content $htmlfile "<td>$($vm.NumCpu)</td>" # Data
    Add-Content $htmlfile "<td>$([Int]$vm.MemoryGB)</td>" # Data
    Add-Content $htmlfile "<td>$([Int]$vm.ProvisionedSpaceGB)</td>" # Data
    Add-Content $htmlfile "<td>$($vm.PowerState)</td>" # Data
    Add-Content $htmlfile "<td>$($vm.HardwareVersion)</td>" # Data
    Add-Content $htmlfile "<td>$($vm.ExtensionData.Guest.ToolsStatus)</td>" # Data
    Add-Content $htmlfile "<td>$($vm.ExtensionData.OverallStatus)</td>" # Data
    Add-Content $htmlfile "</tr>" # Close Row

    }
   
## Close Table

Add-Content $htmlfile "</table>" # Close Table
Add-Content $htmlfile "</center>" # Close Center Table

## Close Main border

Add-Content $htmlfile "</table>" # CloseTable
Add-Content $htmlfile "</th>" # Close Heading
Add-Content $htmlfile "</tr>" # Close Row

## Close Body and HTML

Add-Content $htmlfile "</body>"
Add-Content $htmlfile "</html>"
