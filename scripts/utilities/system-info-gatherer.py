#!/usr/bin/env python3
"""
System Information Gatherer for Cursor OS
Automatically collects system specs, installed software, and development environment info
Author: Cursor OS
Created: 2024-01-01
"""

import platform
import subprocess
import sys
import json
import os
from pathlib import Path
import shutil
from datetime import datetime

def get_system_info():
    """Gather basic system information"""
    return {
        "os": platform.system(),
        "os_version": platform.version(),
        "os_release": platform.release(),
        "architecture": platform.architecture()[0],
        "machine": platform.machine(),
        "processor": platform.processor(),
        "python_version": platform.python_version(),
        "hostname": platform.node()
    }

def get_hardware_info():
    """Gather hardware information (cross-platform)"""
    hardware = {}
    
    try:
        if platform.system() == "Windows":
            # Windows hardware info
            result = subprocess.run(['wmic', 'computersystem', 'get', 'TotalPhysicalMemory'], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')
                if len(lines) > 1:
                    memory_bytes = int(lines[1].strip())
                    hardware["ram_gb"] = round(memory_bytes / (1024**3), 1)
            
            # CPU info
            result = subprocess.run(['wmic', 'cpu', 'get', 'Name'], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')
                if len(lines) > 1:
                    hardware["cpu"] = lines[1].strip()
                    
        elif platform.system() == "Darwin":  # macOS
            # Memory info
            result = subprocess.run(['sysctl', 'hw.memsize'], capture_output=True, text=True)
            if result.returncode == 0:
                memory_bytes = int(result.stdout.split(': ')[1])
                hardware["ram_gb"] = round(memory_bytes / (1024**3), 1)
            
            # CPU info
            result = subprocess.run(['sysctl', '-n', 'machdep.cpu.brand_string'], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                hardware["cpu"] = result.stdout.strip()
                
        elif platform.system() == "Linux":
            # Memory info
            with open('/proc/meminfo', 'r') as f:
                for line in f:
                    if 'MemTotal:' in line:
                        memory_kb = int(line.split()[1])
                        hardware["ram_gb"] = round(memory_kb / (1024**2), 1)
                        break
            
            # CPU info
            with open('/proc/cpuinfo', 'r') as f:
                for line in f:
                    if 'model name' in line:
                        hardware["cpu"] = line.split(': ')[1].strip()
                        break
                        
    except Exception as e:
        hardware["error"] = f"Could not gather hardware info: {str(e)}"
    
    return hardware

def check_installed_software():
    """Check for commonly used development tools"""
    tools = {}
    
    # Define tools to check
    check_commands = {
        "git": ["git", "--version"],
        "node": ["node", "--version"],
        "npm": ["npm", "--version"],
        "python": ["python", "--version"],
        "python3": ["python3", "--version"],
        "pip": ["pip", "--version"],
        "docker": ["docker", "--version"],
        "code": ["code", "--version"],
        "curl": ["curl", "--version"],
        "wget": ["wget", "--version"],
        "rust": ["rustc", "--version"],
        "cargo": ["cargo", "--version"],
        "go": ["go", "version"],
        "java": ["java", "-version"],
        "mvn": ["mvn", "--version"],
        "gradle": ["gradle", "--version"],
        "yarn": ["yarn", "--version"],
        "composer": ["composer", "--version"],
        "php": ["php", "--version"],
        "ruby": ["ruby", "--version"],
        "gem": ["gem", "--version"],
        "terraform": ["terraform", "--version"],
        "kubectl": ["kubectl", "version", "--client"],
        "ansible": ["ansible", "--version"],
        "vagrant": ["vagrant", "--version"]
    }
    
    for tool, command in check_commands.items():
        if shutil.which(command[0]):
            try:
                result = subprocess.run(command, capture_output=True, text=True, timeout=5)
                if result.returncode == 0:
                    # Extract version number (first line, clean it up)
                    version = result.stdout.split('\n')[0].strip()
                    if result.stderr:  # Some tools output version to stderr (like java)
                        version = result.stderr.split('\n')[0].strip()
                    tools[tool] = version
                else:
                    tools[tool] = "installed (version check failed)"
            except subprocess.TimeoutExpired:
                tools[tool] = "installed (timeout)"
            except Exception:
                tools[tool] = "installed (error checking version)"
    
    return tools

def detect_development_environments():
    """Detect IDEs, editors, and development environments"""
    environments = {}
    
    # Common paths to check
    if platform.system() == "Windows":
        common_paths = [
            ("Visual Studio Code", "Microsoft VS Code"),
            ("Visual Studio", "Microsoft Visual Studio"),
            ("IntelliJ IDEA", "JetBrains"),
            ("PyCharm", "JetBrains"),
            ("WebStorm", "JetBrains"),
            ("Sublime Text", "Sublime HQ"),
            ("Atom", "GitHub"),
            ("Notepad++", "Notepad++")
        ]
    elif platform.system() == "Darwin":  # macOS
        common_paths = [
            ("/Applications/Visual Studio Code.app", "VS Code"),
            ("/Applications/Xcode.app", "Xcode"),
            ("/Applications/IntelliJ IDEA.app", "IntelliJ IDEA"),
            ("/Applications/PyCharm.app", "PyCharm"),
            ("/Applications/WebStorm.app", "WebStorm"),
            ("/Applications/Sublime Text.app", "Sublime Text"),
            ("/Applications/Atom.app", "Atom")
        ]
        
        for path, name in common_paths:
            if os.path.exists(path):
                environments[name] = "installed"
    
    return environments

def get_shell_info():
    """Get information about the current shell"""
    shell_info = {}
    
    # Get current shell
    shell_info["current_shell"] = os.environ.get("SHELL", "unknown")
    
    # Get shell version if possible
    if platform.system() == "Windows":
        # Check PowerShell version
        try:
            result = subprocess.run(["powershell", "-Command", "$PSVersionTable.PSVersion"], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                shell_info["powershell_version"] = result.stdout.strip()
        except:
            pass
    
    return shell_info

def get_network_info():
    """Get basic network information"""
    network = {}
    
    try:
        # Check internet connectivity
        result = subprocess.run(["ping", "-c", "1", "8.8.8.8"] if platform.system() != "Windows" 
                               else ["ping", "-n", "1", "8.8.8.8"], 
                               capture_output=True, text=True, timeout=5)
        network["internet_connected"] = result.returncode == 0
    except:
        network["internet_connected"] = "unknown"
    
    return network

def save_to_markdown(data, output_file):
    """Save gathered data to markdown format"""
    with open(output_file, 'w') as f:
        f.write(f"# Computer Information\n\n")
        f.write(f"*Generated on {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*\n\n")
        
        f.write("## System Information\n")
        for key, value in data["system"].items():
            f.write(f"- **{key.replace('_', ' ').title()}**: {value}\n")
        f.write("\n")
        
        f.write("## Hardware\n")
        for key, value in data["hardware"].items():
            f.write(f"- **{key.replace('_', ' ').title()}**: {value}\n")
        f.write("\n")
        
        f.write("## Installed Development Tools\n")
        for tool, version in data["software"].items():
            f.write(f"- **{tool}**: {version}\n")
        f.write("\n")
        
        if data["environments"]:
            f.write("## Development Environments\n")
            for env, status in data["environments"].items():
                f.write(f"- **{env}**: {status}\n")
            f.write("\n")
        
        f.write("## Shell Information\n")
        for key, value in data["shell"].items():
            f.write(f"- **{key.replace('_', ' ').title()}**: {value}\n")
        f.write("\n")
        
        f.write("## Network\n")
        for key, value in data["network"].items():
            f.write(f"- **{key.replace('_', ' ').title()}**: {value}\n")

def main():
    """Main function to gather all system information"""
    print("🔍 Gathering system information...")
    
    # Collect all data
    data = {
        "system": get_system_info(),
        "hardware": get_hardware_info(),
        "software": check_installed_software(),
        "environments": detect_development_environments(),
        "shell": get_shell_info(),
        "network": get_network_info()
    }
    
    # Ensure user-data directory exists
    os.makedirs("user-data", exist_ok=True)
    
    # Save to both JSON and Markdown
    json_file = "user-data/computer-info.json"
    md_file = "user-data/computer-info.md"
    
    with open(json_file, 'w') as f:
        json.dump(data, f, indent=2)
    
    save_to_markdown(data, md_file)
    
    print(f"✅ System information saved to {md_file}")
    print(f"📊 Raw data available in {json_file}")
    
    # Print summary
    print(f"\n📋 **System Summary:**")
    print(f"OS: {data['system']['os']} {data['system']['os_release']}")
    if 'ram_gb' in data['hardware']:
        print(f"RAM: {data['hardware']['ram_gb']} GB")
    if 'cpu' in data['hardware']:
        print(f"CPU: {data['hardware']['cpu']}")
    print(f"Development tools found: {len(data['software'])}")
    
    return data

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n❌ System information gathering cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error gathering system information: {e}")
        sys.exit(1) 