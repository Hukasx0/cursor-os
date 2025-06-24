# System Information Gatherer for Cursor OS (PowerShell Version)
# Automatically collects system specs, installed software, and development environment info
# Author: Cursor OS
# Created: 2024-01-01

param(
    [switch]$Verbose = $false
)

Write-Host "🔍 Gathering system information..." -ForegroundColor Cyan

# Function to get system information
function Get-SystemInfo {
    $system = @{}
    
    $computerSystem = Get-WmiObject -Class Win32_ComputerSystem
    $operatingSystem = Get-WmiObject -Class Win32_OperatingSystem
    
    $system.os = $operatingSystem.Caption
    $system.os_version = $operatingSystem.Version
    $system.architecture = $operatingSystem.OSArchitecture
    $system.hostname = $computerSystem.Name
    $system.domain = $computerSystem.Domain
    $system.manufacturer = $computerSystem.Manufacturer
    $system.model = $computerSystem.Model
    $system.powershell_version = $PSVersionTable.PSVersion.ToString()
    
    return $system
}

# Function to get hardware information
function Get-HardwareInfo {
    $hardware = @{}
    
    try {
        # Memory information
        $memory = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
        $hardware.ram_gb = [math]::Round($memory.Sum / 1GB, 1)
        
        # CPU information
        $cpu = Get-WmiObject -Class Win32_Processor | Select-Object -First 1
        $hardware.cpu = $cpu.Name.Trim()
        $hardware.cpu_cores = $cpu.NumberOfCores
        $hardware.cpu_logical_processors = $cpu.NumberOfLogicalProcessors
        
        # Disk information
        $disks = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
        $totalSize = ($disks | Measure-Object -Property Size -Sum).Sum
        $hardware.total_disk_gb = [math]::Round($totalSize / 1GB, 1)
        
        # Graphics card
        $gpu = Get-WmiObject -Class Win32_VideoController | Where-Object { $_.Name -notlike "*Microsoft Basic*" } | Select-Object -First 1
        if ($gpu) {
            $hardware.gpu = $gpu.Name
        }
    }
    catch {
        $hardware.error = "Could not gather hardware info: $($_.Exception.Message)"
    }
    
    return $hardware
}

# Function to check installed software
function Get-InstalledSoftware {
    $tools = @{}
    
    # Define tools to check
    $checkCommands = @{
        "git" = @("git", "--version")
        "node" = @("node", "--version")
        "npm" = @("npm", "--version")
        "python" = @("python", "--version")
        "pip" = @("pip", "--version")
        "docker" = @("docker", "--version")
        "code" = @("code", "--version")
        "curl" = @("curl", "--version")
        "rust" = @("rustc", "--version")
        "cargo" = @("cargo", "--version")
        "go" = @("go", "version")
        "java" = @("java", "-version")
        "mvn" = @("mvn", "--version")
        "yarn" = @("yarn", "--version")
        "dotnet" = @("dotnet", "--version")
        "powershell" = @("pwsh", "--version")
        "terraform" = @("terraform", "--version")
        "kubectl" = @("kubectl", "version", "--client")
    }
    
    foreach ($tool in $checkCommands.Keys) {
        $command = $checkCommands[$tool]
        
        try {
            if (Get-Command $command[0] -ErrorAction SilentlyContinue) {
                $result = & $command[0] $command[1..($command.Length-1)] 2>&1
                if ($LASTEXITCODE -eq 0) {
                    $version = $result[0].ToString().Trim()
                    $tools[$tool] = $version
                }
                else {
                    $tools[$tool] = "installed (version check failed)"
                }
            }
        }
        catch {
            # Tool not found or error occurred
        }
    }
    
    return $tools
}

# Function to detect development environments
function Get-DevelopmentEnvironments {
    $environments = @{}
    
    # Check for installed programs via registry and common paths
    $commonApps = @{
        "Visual Studio Code" = @(
            "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe",
            "$env:PROGRAMFILES\Microsoft VS Code\Code.exe"
        )
        "Visual Studio 2022" = @(
            "$env:PROGRAMFILES\Microsoft Visual Studio\2022\*\Common7\IDE\devenv.exe"
        )
        "Visual Studio 2019" = @(
            "$env:PROGRAMFILES(X86)\Microsoft Visual Studio\2019\*\Common7\IDE\devenv.exe"
        )
        "IntelliJ IDEA" = @(
            "$env:LOCALAPPDATA\JetBrains\IntelliJ IDEA*\bin\idea64.exe",
            "$env:PROGRAMFILES\JetBrains\IntelliJ IDEA*\bin\idea64.exe"
        )
        "PyCharm" = @(
            "$env:LOCALAPPDATA\JetBrains\PyCharm*\bin\pycharm64.exe"
        )
        "Sublime Text" = @(
            "$env:PROGRAMFILES\Sublime Text*\sublime_text.exe"
        )
        "Notepad++" = @(
            "$env:PROGRAMFILES\Notepad++\notepad++.exe",
            "$env:PROGRAMFILES(X86)\Notepad++\notepad++.exe"
        )
    }
    
    foreach ($app in $commonApps.Keys) {
        foreach ($path in $commonApps[$app]) {
            if (Test-Path $path) {
                $environments[$app] = "installed"
                break
            }
        }
    }
    
    return $environments
}

# Function to get network information
function Get-NetworkInfo {
    $network = @{}
    
    try {
        # Test internet connectivity
        $ping = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        $network.internet_connected = $ping
        
        # Get network adapters
        $adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
        $network.active_adapters = $adapters.Count
        
        # Check if VPN is active (basic check)
        $vpnAdapters = $adapters | Where-Object { $_.InterfaceDescription -like "*VPN*" -or $_.InterfaceDescription -like "*TAP*" }
        $network.vpn_active = $vpnAdapters.Count -gt 0
    }
    catch {
        $network.error = "Could not gather network info: $($_.Exception.Message)"
    }
    
    return $network
}

# Function to save data to markdown
function Save-ToMarkdown {
    param(
        [hashtable]$Data,
        [string]$OutputFile
    )
    
    $content = @"
# Computer Information

*Generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')*

## System Information
"@
    
    foreach ($key in $Data.system.Keys) {
        $content += "`n- **$($key -replace '_', ' ' | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) })**: $($Data.system[$key])"
    }
    
    $content += "`n`n## Hardware"
    foreach ($key in $Data.hardware.Keys) {
        $content += "`n- **$($key -replace '_', ' ' | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) })**: $($Data.hardware[$key])"
    }
    
    $content += "`n`n## Installed Development Tools"
    foreach ($tool in $Data.software.Keys | Sort-Object) {
        $content += "`n- **$tool**: $($Data.software[$tool])"
    }
    
    if ($Data.environments.Count -gt 0) {
        $content += "`n`n## Development Environments"
        foreach ($env in $Data.environments.Keys | Sort-Object) {
            $content += "`n- **$env**: $($Data.environments[$env])"
        }
    }
    
    $content += "`n`n## Network"
    foreach ($key in $Data.network.Keys) {
        $content += "`n- **$($key -replace '_', ' ' | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) })**: $($Data.network[$key])"
    }
    
    $content | Out-File -FilePath $OutputFile -Encoding UTF8
}

# Main execution
try {
    # Collect all data
    $data = @{
        system = Get-SystemInfo
        hardware = Get-HardwareInfo
        software = Get-InstalledSoftware
        environments = Get-DevelopmentEnvironments
        network = Get-NetworkInfo
    }
    
    # Ensure user-data directory exists
    if (!(Test-Path "user-data")) {
        New-Item -ItemType Directory -Path "user-data" | Out-Null
    }
    
    # Save to both JSON and Markdown
    $jsonFile = "user-data\computer-info.json"
    $mdFile = "user-data\computer-info.md"
    
    $data | ConvertTo-Json -Depth 3 | Out-File -FilePath $jsonFile -Encoding UTF8
    Save-ToMarkdown -Data $data -OutputFile $mdFile
    
    Write-Host "✅ System information saved to $mdFile" -ForegroundColor Green
    Write-Host "📊 Raw data available in $jsonFile" -ForegroundColor Green
    
    # Print summary
    Write-Host "`n📋 **System Summary:**" -ForegroundColor Yellow
    Write-Host "OS: $($data.system.os)" -ForegroundColor White
    if ($data.hardware.ram_gb) {
        Write-Host "RAM: $($data.hardware.ram_gb) GB" -ForegroundColor White
    }
    if ($data.hardware.cpu) {
        Write-Host "CPU: $($data.hardware.cpu)" -ForegroundColor White
    }
    Write-Host "Development tools found: $($data.software.Count)" -ForegroundColor White
    
    if ($Verbose) {
        Write-Host "`nDetailed Information:" -ForegroundColor Cyan
        $data | ConvertTo-Json -Depth 3
    }
}
catch {
    Write-Host "❌ Error gathering system information: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
} 