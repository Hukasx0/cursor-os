# Python Virtual Environment Management Addon

## AI Guidance System for Virtual Environments

### When to Use This Addon (Instructions for Cursor OS AI)

This addon should be activated when:

1. **User mentions Python development** - any Python project setup
2. **Dependencies management** - when installing packages, managing requirements
3. **Project isolation** - when user wants separate environments  
4. **Cross-platform Python work** - when working across different operating systems
5. **Package version conflicts** - when dealing with incompatible package versions
6. **Production deployment** - when preparing Python apps for deployment
7. **Team collaboration** - when sharing Python projects with consistent environments

### AI Decision Tree for Virtual Environment Actions

```
User Request Analysis:
├── New Python Project?
│   ├── YES → Create new venv + setup project structure
│   └── NO → Check if venv exists
│       ├── EXISTS → Activate existing venv
│       └── NOT EXISTS → Analyze project needs → Create venv
│
├── Installing Packages?
│   ├── venv ACTIVE → Install in current venv
│   └── venv INACTIVE → Warn + activate venv first
│
├── Running Python Scripts?
│   ├── Project has venv → Activate venv first
│   └── No venv → Suggest creating venv for isolation
│
└── Dependency Issues?
    ├── Version conflicts → Create separate venv
    ├── Missing packages → Install in active venv
    └── Environment corruption → Recreate venv
```

## Core Principles & Best Practices

### 1. Environment Isolation Strategy
- **One venv per project** - never share environments between projects
- **Name venvs descriptively** - use project name or purpose
- **Keep venvs outside project directory** - store in dedicated location
- **Document environment setup** - always include setup instructions

### 2. Cross-Platform Compatibility
- **Use platform-agnostic commands** - detect OS and adapt
- **Handle path separators correctly** - use os.path.join() equivalents
- **Account for shell differences** - PowerShell vs Bash vs Zsh
- **Respect OS conventions** - follow platform-specific practices

### 3. Dependency Management
- **Always use requirements.txt** - pin exact versions for reproducibility
- **Separate dev and prod dependencies** - requirements-dev.txt for development
- **Regular dependency updates** - keep packages up to date securely
- **Lock file generation** - use pip-tools for advanced dependency resolution

## Cross-Platform Virtual Environment System

### OS Detection & Command Mapping
```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Python Virtual Environment Cross-Platform Manager

Provides unified interface for managing Python virtual environments
across Windows, macOS, and Linux with automatic OS detection and
appropriate command selection.

Features:
- Automatic OS detection and command adaptation
- Cross-platform venv creation and activation
- Dependency management with requirements handling
- Project structure initialization
- Environment validation and health checks

Author: Cursor OS Development Team
Version: 1.0.0
License: MIT
"""

import os
import sys
import platform
import subprocess
import json
import shutil
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Union
from dataclasses import dataclass
from enum import Enum

class OperatingSystem(Enum):
    """Supported operating systems for cross-platform compatibility"""
    WINDOWS = "Windows"
    MACOS = "Darwin" 
    LINUX = "Linux"
    UNKNOWN = "Unknown"

@dataclass
class VenvConfig:
    """Virtual environment configuration container"""
    name: str
    path: Path
    python_version: str
    requirements_file: Optional[Path] = None
    dev_requirements_file: Optional[Path] = None
    description: str = ""
    created_date: str = ""
    last_used: str = ""

@dataclass
class PlatformCommands:
    """Platform-specific command mappings for virtual environment operations"""
    python_exe: str
    venv_create: List[str]
    venv_activate: str
    venv_deactivate: str
    pip_install: List[str]
    pip_freeze: List[str]
    shell_type: str

class VirtualEnvironmentManager:
    """
    Cross-platform virtual environment manager with comprehensive functionality
    
    Handles creation, activation, management, and cleanup of Python virtual
    environments across different operating systems. Provides unified interface
    for common venv operations while respecting platform-specific conventions.
    
    Attributes:
        os_type (OperatingSystem): Detected operating system
        platform_commands (PlatformCommands): OS-specific command mappings
        venv_base_dir (Path): Base directory for storing virtual environments
        current_venv (Optional[VenvConfig]): Currently active virtual environment
    
    Example:
        >>> manager = VirtualEnvironmentManager()
        >>> venv_config = manager.create_venv("my-project", "3.11")
        >>> manager.activate_venv(venv_config)
        >>> manager.install_requirements("requirements.txt")
    """
    
    def __init__(self, venv_base_dir: Optional[Union[str, Path]] = None):
        """
        Initialize virtual environment manager with OS detection
        
        Args:
            venv_base_dir: Custom base directory for venvs. If None, uses
                          platform-appropriate default location.
        
        Raises:
            OSError: If the system is not supported or Python is not found
            PermissionError: If venv base directory cannot be created
        """
        self.os_type = self._detect_operating_system()
        self.platform_commands = self._get_platform_commands()
        self.venv_base_dir = self._setup_venv_base_directory(venv_base_dir)
        self.current_venv: Optional[VenvConfig] = None
        
        # Validate Python installation
        self._validate_python_installation()
        
        # Initialize venv registry
        self.venv_registry_file = self.venv_base_dir / "venv_registry.json"
        self._load_venv_registry()
    
    def _detect_operating_system(self) -> OperatingSystem:
        """
        Detect the current operating system for command adaptation
        
        Returns:
            OperatingSystem enum value representing the detected OS
        
        Note:
            Uses platform.system() for detection. Falls back to UNKNOWN
            for unsupported systems.
        """
        system_name = platform.system()
        
        # Map platform.system() output to our enum
        os_mapping = {
            "Windows": OperatingSystem.WINDOWS,
            "Darwin": OperatingSystem.MACOS,
            "Linux": OperatingSystem.LINUX
        }
        
        detected_os = os_mapping.get(system_name, OperatingSystem.UNKNOWN)
        
        if detected_os == OperatingSystem.UNKNOWN:
            print(f"Warning: Unsupported operating system '{system_name}' detected")
            print("Some features may not work correctly")
        
        return detected_os
    
    def _get_platform_commands(self) -> PlatformCommands:
        """
        Get platform-specific command mappings for venv operations
        
        Returns:
            PlatformCommands object with OS-appropriate command definitions
        
        Raises:
            NotImplementedError: If the operating system is not supported
        """
        if self.os_type == OperatingSystem.WINDOWS:
            return PlatformCommands(
                python_exe="python",
                venv_create=["python", "-m", "venv"],
                venv_activate=r"Scripts\activate.bat",  # For cmd
                venv_deactivate="deactivate",
                pip_install=["python", "-m", "pip", "install"],
                pip_freeze=["python", "-m", "pip", "freeze"],
                shell_type="cmd"  # Default to cmd, can be PowerShell
            )
        
        elif self.os_type in [OperatingSystem.MACOS, OperatingSystem.LINUX]:
            return PlatformCommands(
                python_exe="python3",
                venv_create=["python3", "-m", "venv"],
                venv_activate="bin/activate",
                venv_deactivate="deactivate",
                pip_install=["python3", "-m", "pip", "install"],
                pip_freeze=["python3", "-m", "pip", "freeze"],
                shell_type="bash"
            )
        
        else:
            raise NotImplementedError(f"Operating system {self.os_type} is not supported")
    
    def _setup_venv_base_directory(self, custom_dir: Optional[Union[str, Path]]) -> Path:
        """
        Setup base directory for storing virtual environments
        
        Args:
            custom_dir: User-specified directory path
        
        Returns:
            Path object pointing to the venv base directory
        
        Directory Selection Logic:
            Windows: %USERPROFILE%\\.venvs
            macOS: ~/.venvs  
            Linux: ~/.venvs
            Custom: User-specified path
        """
        if custom_dir:
            base_dir = Path(custom_dir)
        else:
            # Use platform-appropriate default locations
            if self.os_type == OperatingSystem.WINDOWS:
                base_dir = Path.home() / ".venvs"
            else:  # macOS and Linux
                base_dir = Path.home() / ".venvs"
        
        # Create directory if it doesn't exist
        try:
            base_dir.mkdir(parents=True, exist_ok=True)
            
            # Verify write permissions
            test_file = base_dir / ".test_write"
            test_file.touch()
            test_file.unlink()
            
        except PermissionError as e:
            raise PermissionError(
                f"Cannot create or write to venv directory '{base_dir}'. "
                f"Please check permissions or specify a different location."
            ) from e
        
        return base_dir
    
    def _validate_python_installation(self) -> None:
        """
        Validate that Python is properly installed and accessible
        
        Raises:
            OSError: If Python executable is not found or not functional
        """
        try:
            # Test Python executable
            result = subprocess.run(
                [self.platform_commands.python_exe, "--version"],
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode != 0:
                raise OSError(f"Python executable failed: {result.stderr}")
            
            print(f"✓ Python found: {result.stdout.strip()}")
            
            # Test venv module availability
            result = subprocess.run(
                [self.platform_commands.python_exe, "-m", "venv", "--help"],
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode != 0:
                raise OSError("Python venv module is not available")
            
            print("✓ Python venv module available")
            
        except subprocess.TimeoutExpired:
            raise OSError("Python command timed out - installation may be corrupted")
        except FileNotFoundError:
            raise OSError(
                f"Python executable '{self.platform_commands.python_exe}' not found. "
                f"Please install Python and ensure it's in your PATH."
            )

    def create_venv(
        self,
        name: str,
        python_version: Optional[str] = None,
        requirements_file: Optional[Union[str, Path]] = None,
        description: str = ""
    ) -> VenvConfig:
        """
        Create a new virtual environment with comprehensive setup
        
        Args:
            name: Name for the virtual environment (used as directory name)
            python_version: Specific Python version to use (e.g., "3.11")
            requirements_file: Path to requirements.txt file to install
            description: Human-readable description of the environment purpose
        
        Returns:
            VenvConfig object representing the created environment
        
        Raises:
            FileExistsError: If virtual environment already exists
            subprocess.CalledProcessError: If venv creation fails
            ValueError: If name contains invalid characters
        
        Example:
            >>> venv = manager.create_venv(
            ...     name="web-scraper",
            ...     python_version="3.11",
            ...     requirements_file="requirements.txt",
            ...     description="Environment for web scraping project"
            ... )
        """
        # Validate environment name
        if not name or not name.replace("-", "").replace("_", "").isalnum():
            raise ValueError(
                "Environment name must contain only alphanumeric characters, "
                "hyphens, and underscores"
            )
        
        venv_path = self.venv_base_dir / name
        
        # Check if environment already exists
        if venv_path.exists():
            raise FileExistsError(
                f"Virtual environment '{name}' already exists at {venv_path}"
            )
        
        print(f"Creating virtual environment '{name}'...")
        
        try:
            # Prepare creation command
            create_cmd = self.platform_commands.venv_create.copy()
            
            # Add specific Python version if requested
            if python_version:
                if self.os_type == OperatingSystem.WINDOWS:
                    # Windows: try py launcher first, then python
                    create_cmd = [f"py", f"-{python_version}", "-m", "venv"]
                else:
                    # Unix-like: try versioned python
                    create_cmd = [f"python{python_version}", "-m", "venv"]
            
            create_cmd.append(str(venv_path))
            
            # Execute venv creation
            result = subprocess.run(
                create_cmd,
                capture_output=True,
                text=True,
                timeout=60  # 1 minute timeout
            )
            
            if result.returncode != 0:
                # Try fallback command if specific version failed
                if python_version:
                    print(f"Warning: Python {python_version} not found, using default")
                    fallback_cmd = self.platform_commands.venv_create + [str(venv_path)]
                    result = subprocess.run(fallback_cmd, capture_output=True, text=True)
                
                if result.returncode != 0:
                    raise subprocess.CalledProcessError(
                        result.returncode, create_cmd, result.stdout, result.stderr
                    )
            
            print(f"✓ Virtual environment created at {venv_path}")
            
            # Get actual Python version from created environment
            actual_version = self._get_venv_python_version(venv_path)
            
            # Create venv configuration
            venv_config = VenvConfig(
                name=name,
                path=venv_path,
                python_version=actual_version,
                description=description,
                created_date=self._get_current_timestamp()
            )
            
            # Install requirements if provided
            if requirements_file:
                req_path = Path(requirements_file)
                if req_path.exists():
                    self._install_requirements_in_venv(venv_config, req_path)
                    venv_config.requirements_file = req_path
                else:
                    print(f"Warning: Requirements file {req_path} not found")
            
            # Register the new environment
            self._register_venv(venv_config)
            
            return venv_config
            
        except subprocess.TimeoutExpired:
            raise OSError("Virtual environment creation timed out")
        except subprocess.CalledProcessError as e:
            raise OSError(
                f"Failed to create virtual environment: {e.stderr}"
            ) from e
    
    def activate_venv(self, venv_config: VenvConfig) -> str:
        """
        Generate activation command for the specified virtual environment
        
        Args:
            venv_config: Configuration for the environment to activate
        
        Returns:
            String containing the platform-appropriate activation command
        
        Note:
            This method returns the command string rather than executing it,
            as activation must be done in the user's shell session.
        """
        if not venv_config.path.exists():
            raise FileNotFoundError(
                f"Virtual environment not found at {venv_config.path}"
            )
        
        activate_script = venv_config.path / self.platform_commands.venv_activate
        
        if not activate_script.exists():
            raise FileNotFoundError(
                f"Activation script not found: {activate_script}"
            )
        
        # Update last used timestamp
        venv_config.last_used = self._get_current_timestamp()
        self._register_venv(venv_config)  # Update registry
        
        # Return platform-specific activation command
        if self.os_type == OperatingSystem.WINDOWS:
            if self._is_powershell():
                # PowerShell activation
                ps_activate = venv_config.path / "Scripts" / "Activate.ps1"
                return f"& '{ps_activate}'"
            else:
                # Command Prompt activation
                return f'"{activate_script}"'
        else:
            # Unix-like systems (macOS, Linux)
            return f"source '{activate_script}'"
    
    def list_venvs(self) -> List[VenvConfig]:
        """
        List all registered virtual environments with their details
        
        Returns:
            List of VenvConfig objects for all registered environments
        """
        return list(self.venv_registry.values())
    
    def remove_venv(self, name: str, force: bool = False) -> bool:
        """
        Remove a virtual environment and clean up associated files
        
        Args:
            name: Name of the environment to remove
            force: If True, skip confirmation prompts
        
        Returns:
            True if removal was successful, False otherwise
        
        Raises:
            ValueError: If environment name is not found
        """
        if name not in self.venv_registry:
            raise ValueError(f"Virtual environment '{name}' not found")
        
        venv_config = self.venv_registry[name]
        
        if not force:
            response = input(f"Remove virtual environment '{name}'? [y/N]: ")
            if response.lower() not in ['y', 'yes']:
                print("Removal cancelled")
                return False
        
        try:
            # Remove directory
            if venv_config.path.exists():
                shutil.rmtree(venv_config.path)
                print(f"✓ Removed environment directory: {venv_config.path}")
            
            # Remove from registry
            del self.venv_registry[name]
            self._save_venv_registry()
            
            print(f"✓ Virtual environment '{name}' removed successfully")
            return True
            
        except Exception as e:
            print(f"Error removing virtual environment: {e}")
            return False
```

## AI Usage Instructions & Decision Matrix

### Automatic Environment Detection
```python
def should_create_venv(project_path: Path, ai_context: dict) -> bool:
    """
    AI decision function for when to create virtual environments
    
    Args:
        project_path: Path to the project directory
        ai_context: Context from user interaction
    
    Returns:
        Boolean indicating whether venv should be created
    """
    # Check for existing venv indicators
    venv_indicators = [
        "venv", ".venv", "env", ".env", "virtualenv",
        "requirements.txt", "pyproject.toml", "setup.py",
        "Pipfile", "poetry.lock"
    ]
    
    has_venv_files = any(
        (project_path / indicator).exists() 
        for indicator in venv_indicators
    )
    
    # Analyze user intent from context
    python_keywords = [
        "python", "pip", "install", "package", "dependency",
        "requirements", "virtual environment", "venv"
    ]
    
    mentions_python = any(
        keyword in ai_context.get("user_message", "").lower()
        for keyword in python_keywords
    )
    
    # Decision logic
    if has_venv_files and not mentions_python:
        return False  # Likely already configured
    
    if mentions_python and not has_venv_files:
        return True   # Python work without venv setup
    
    if "new project" in ai_context.get("user_message", "").lower():
        return True   # New projects should have isolated environments
    
    return False
```

### Cross-Platform Command Generator
```python
def generate_venv_commands(action: str, venv_name: str, os_type: str) -> Dict[str, str]:
    """
    Generate cross-platform commands for virtual environment operations
    
    Args:
        action: Type of operation ('create', 'activate', 'install', 'freeze')
        venv_name: Name of the virtual environment
        os_type: Operating system type ('Windows', 'Darwin', 'Linux')
    
    Returns:
        Dictionary with platform-specific commands
    """
    commands = {}
    
    if action == "create":
        if os_type == "Windows":
            commands["cmd"] = f"python -m venv {venv_name}"
            commands["powershell"] = f"python -m venv {venv_name}"
        else:  # macOS/Linux
            commands["bash"] = f"python3 -m venv {venv_name}"
            commands["zsh"] = f"python3 -m venv {venv_name}"
    
    elif action == "activate":
        if os_type == "Windows":
            commands["cmd"] = f"{venv_name}\\Scripts\\activate.bat"
            commands["powershell"] = f".\\{venv_name}\\Scripts\\Activate.ps1"
        else:  # macOS/Linux
            commands["bash"] = f"source {venv_name}/bin/activate"
            commands["zsh"] = f"source {venv_name}/bin/activate"
    
    elif action == "install":
        # Same across platforms when venv is active
        commands["universal"] = "pip install -r requirements.txt"
    
    elif action == "freeze":
        # Same across platforms when venv is active
        commands["universal"] = "pip freeze > requirements.txt"
    
    return commands
```

## Project Structure Templates

### Python Project with Virtual Environment
```
python-project/
├── README.md                   # Project documentation
├── requirements.txt            # Production dependencies
├── requirements-dev.txt        # Development dependencies  
├── .python-version            # Python version specification
├── .venv/                     # Virtual environment (local)
├── setup.py                   # Package installation script
├── pyproject.toml             # Modern Python project config
├── .gitignore                 # Git ignore patterns
├── src/                       # Source code
│   ├── __init__.py
│   ├── main.py
│   └── package_name/
│       ├── __init__.py
│       ├── core.py
│       └── utils.py
├── tests/                     # Test files
│   ├── __init__.py
│   ├── test_main.py
│   └── test_utils.py
├── docs/                      # Documentation
│   ├── api.md
│   └── setup.md
├── scripts/                   # Utility scripts
│   ├── setup_env.py
│   └── run_tests.py
└── .env.example              # Environment variables template
```

## Best Practices Implementation

### Automated Environment Setup Script
```python
#!/usr/bin/env python3
"""
Automated Python Virtual Environment Setup Script

Cross-platform script for setting up Python development environments
with best practices, dependency management, and project structure.

Usage:
    python setup_env.py [project_name] [--python-version 3.11]
"""

import argparse
import os
import sys
import subprocess
import platform
from pathlib import Path
from typing import List, Optional

def detect_shell() -> str:
    """Detect the current shell for appropriate activation commands"""
    if platform.system() == "Windows":
        if "POWERSHELL" in os.environ.get("PSModulePath", ""):
            return "powershell"
        else:
            return "cmd"
    else:
        shell = os.environ.get("SHELL", "/bin/bash")
        return Path(shell).name

def create_project_structure(project_path: Path) -> None:
    """Create standard Python project directory structure"""
    directories = [
        "src",
        "tests", 
        "docs",
        "scripts"
    ]
    
    for directory in directories:
        (project_path / directory).mkdir(exist_ok=True)
        
        # Create __init__.py files for Python packages
        if directory in ["src", "tests"]:
            (project_path / directory / "__init__.py").touch()

def create_gitignore(project_path: Path) -> None:
    """Create comprehensive .gitignore for Python projects"""
    gitignore_content = """
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environments
.venv/
venv/
ENV/
env/
.env

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Testing
.coverage
.pytest_cache/
.tox/
htmlcov/

# Documentation
docs/_build/
"""
    
    with open(project_path / ".gitignore", "w") as f:
        f.write(gitignore_content.strip())

def create_requirements_files(project_path: Path) -> None:
    """Create requirements files with common development dependencies"""
    
    # Production requirements (minimal)
    requirements_txt = """
# Add your production dependencies here
# Example:
# requests>=2.25.0
# numpy>=1.21.0
"""
    
    # Development requirements
    requirements_dev_txt = """
# Development dependencies
pytest>=7.0.0
pytest-cov>=4.0.0
black>=22.0.0
flake8>=5.0.0
mypy>=0.991
pre-commit>=2.20.0
"""
    
    with open(project_path / "requirements.txt", "w") as f:
        f.write(requirements_txt.strip())
    
    with open(project_path / "requirements-dev.txt", "w") as f:
        f.write(requirements_dev_txt.strip())

def main():
    """Main setup function with argument parsing and execution"""
    parser = argparse.ArgumentParser(
        description="Setup Python virtual environment and project structure"
    )
    parser.add_argument(
        "project_name", 
        help="Name of the Python project"
    )
    parser.add_argument(
        "--python-version",
        default="3.11",
        help="Python version to use (default: 3.11)"
    )
    parser.add_argument(
        "--no-structure", 
        action="store_true",
        help="Skip creating project directory structure"
    )
    
    args = parser.parse_args()
    
    # Initialize virtual environment manager
    manager = VirtualEnvironmentManager()
    
    project_path = Path.cwd() / args.project_name
    
    try:
        # Create project directory
        project_path.mkdir(exist_ok=True)
        os.chdir(project_path)
        
        print(f"Setting up Python project: {args.project_name}")
        print(f"Location: {project_path}")
        print(f"Python version: {args.python_version}")
        
        # Create virtual environment
        venv_config = manager.create_venv(
            name=args.project_name,
            python_version=args.python_version,
            description=f"Virtual environment for {args.project_name} project"
        )
        
        # Create project structure
        if not args.no_structure:
            create_project_structure(project_path)
            create_gitignore(project_path)
            create_requirements_files(project_path)
            print("✓ Project structure created")
        
        # Generate activation instructions
        shell = detect_shell()
        activation_cmd = manager.activate_venv(venv_config)
        
        print("\n" + "="*50)
        print("Setup completed successfully!")
        print("="*50)
        print(f"Virtual environment: {venv_config.name}")
        print(f"Python version: {venv_config.python_version}")
        print(f"Location: {venv_config.path}")
        print("\nTo activate the virtual environment:")
        print(f"  {activation_cmd}")
        print("\nTo install development dependencies:")
        print("  pip install -r requirements-dev.txt")
        print("\nTo deactivate when done:")
        print("  deactivate")
        
    except Exception as e:
        print(f"Error setting up project: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
```

## AI Integration Guidelines

### When Cursor OS Should Use This Addon

1. **Project Initialization**:
   ```
   User: "Create a new Python project for web scraping"
   AI Action: Use addon to create venv + project structure
   ```

2. **Dependency Management**:
   ```
   User: "Install requests and beautifulsoup4"
   AI Action: Check if venv is active, activate if needed, then install
   ```

3. **Cross-Platform Development**:
   ```
   User: "I'm working on Windows but my team uses Mac"
   AI Action: Generate platform-specific commands for all team members
   ```

4. **Environment Issues**:
   ```
   User: "I'm getting package conflicts"
   AI Action: Suggest creating isolated venv for problematic packages
   ```

### AI Decision Prompts

**Before any Python package installation:**
```
if not venv_active():
    suggest_venv_activation()
    wait_for_confirmation()
```

**When creating new Python files:**
```
if is_new_project() and not has_venv():
    suggest_venv_creation()
    offer_project_template()
```

**When user mentions deployment:**
```
if "deploy" in user_message:
    ensure_requirements_txt_exists()
    suggest_production_dependencies_separation()
```

## Deployment Strategy

### When using this addon:

1. **Always check for existing venv** before creating new ones
2. **Use cross-platform commands** based on detected OS
3. **Separate dev and prod dependencies** in different files
4. **Create comprehensive project structure** for new projects
5. **Validate Python installation** before proceeding
6. **Document activation commands** for user reference
7. **Handle shell differences** (PowerShell vs CMD vs Bash)
8. **Provide fallback options** when specific Python versions unavailable

This addon ensures proper Python environment isolation and cross-platform compatibility while educating the AI about when and how to use virtual environments effectively. 