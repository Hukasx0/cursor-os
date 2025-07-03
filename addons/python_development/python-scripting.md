# Python Scripting Addon

## Purpose
Guidelines for creating well-structured, documented, and maintainable Python scripts following industry best practices and coding standards.

## Script Placement Strategy

⚠️ **CRITICAL RULE**: When creating Python scripts, always determine the intended user:

### Scripts for AI/Automation Use (Cursor OS Internal)
**Location**: `scripts/` folder  
**When to use**: Scripts intended for Cursor OS automation, system tasks, or AI-assisted workflows
**Structure**: Simple, single-file scripts

```
scripts/
├── utilities/
│   ├── data-processor.py
│   ├── file-organizer.py
│   └── system-monitor.py
├── automation/
│   ├── backup-manager.py
│   └── deployment-helper.py
└── development/
    ├── project-setup.py
    └── code-generator.py
```

### Scripts for User (Standalone Projects)
**Location**: `documents/projects/project-name/` folder  
**When to use**: ANY script created FOR THE USER (not for Cursor OS automation)
**Structure**: Complete GitHub-style repository with all project files

**🎯 DEFAULT CHOICE**: Unless explicitly stated that the script is for Cursor OS automation, ALWAYS create user projects in `documents/projects/` with full structure.

```
documents/projects/project-name/
├── README.md
├── requirements.txt
├── setup.py
├── .gitignore
├── src/
│   ├── __init__.py
│   ├── main.py
│   └── modules/
│       ├── __init__.py
│       └── core.py
├── tests/
│   ├── __init__.py
│   ├── test_main.py
│   └── test_core.py
├── docs/
│   ├── installation.md
│   └── usage.md
├── examples/
│   └── example_usage.py
└── data/
    └── sample_data.csv
```

## Core Principles
- **Readable**: Code should be self-documenting and easy to understand
- **Maintainable**: Follow consistent patterns and structure
- **Robust**: Include proper error handling and input validation
- **Documented**: Comprehensive docstrings and comments
- **Testable**: Write code that can be easily tested

## Script Structure Template

```python
#!/usr/bin/env python3
"""
Script Title: Brief description of what the script does

This script [detailed description of functionality and purpose].

Author: [Author Name]
Created: [YYYY-MM-DD]
Last Modified: [YYYY-MM-DD]
Version: [X.Y.Z]

Requirements:
    - Python 3.7+
    - [dependency1] (pip install dependency1)
    - [dependency2] (pip install dependency2)

Usage:
    python script_name.py [arguments]
    
Examples:
    python script_name.py --input data.csv --output results.json
    python script_name.py --help

License: [License information if applicable]
"""

import argparse
import logging
import sys
from pathlib import Path
from typing import Optional, List, Dict, Any

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('script.log'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# Constants
DEFAULT_OUTPUT_DIR = Path("output")
SUPPORTED_FORMATS = ["csv", "json", "xlsx"]
VERSION = "1.0.0"

class ScriptError(Exception):
    """Custom exception for script-specific errors."""
    pass

def validate_input(input_path: Path) -> bool:
    """
    Validate input file exists and is readable.
    
    Args:
        input_path (Path): Path to input file
        
    Returns:
        bool: True if valid, False otherwise
        
    Raises:
        ScriptError: If file doesn't exist or isn't readable
    """
    if not input_path.exists():
        raise ScriptError(f"Input file does not exist: {input_path}")
    
    if not input_path.is_file():
        raise ScriptError(f"Input path is not a file: {input_path}")
    
    if not os.access(input_path, os.R_OK):
        raise ScriptError(f"Input file is not readable: {input_path}")
    
    return True

def process_data(data: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """
    Process input data according to business logic.
    
    Args:
        data (List[Dict[str, Any]]): Input data to process
        
    Returns:
        List[Dict[str, Any]]: Processed data
        
    Raises:
        ScriptError: If data processing fails
    """
    try:
        # Implementation here
        processed_data = []
        
        for item in data:
            # Process each item
            processed_item = transform_item(item)
            processed_data.append(processed_item)
        
        logger.info(f"Processed {len(processed_data)} items")
        return processed_data
        
    except Exception as e:
        raise ScriptError(f"Data processing failed: {str(e)}")

def transform_item(item: Dict[str, Any]) -> Dict[str, Any]:
    """
    Transform a single data item.
    
    Args:
        item (Dict[str, Any]): Single item to transform
        
    Returns:
        Dict[str, Any]: Transformed item
    """
    # Implementation details
    return item

def save_results(data: List[Dict[str, Any]], output_path: Path) -> None:
    """
    Save processed data to output file.
    
    Args:
        data (List[Dict[str, Any]]): Data to save
        output_path (Path): Output file path
        
    Raises:
        ScriptError: If saving fails
    """
    try:
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        # Implement saving logic based on file extension
        if output_path.suffix.lower() == '.json':
            import json
            with open(output_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, indent=2, ensure_ascii=False)
        elif output_path.suffix.lower() == '.csv':
            import csv
            if data:
                with open(output_path, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.DictWriter(f, fieldnames=data[0].keys())
                    writer.writeheader()
                    writer.writerows(data)
        else:
            raise ScriptError(f"Unsupported output format: {output_path.suffix}")
        
        logger.info(f"Results saved to: {output_path}")
        
    except Exception as e:
        raise ScriptError(f"Failed to save results: {str(e)}")

def parse_arguments() -> argparse.Namespace:
    """
    Parse command line arguments.
    
    Returns:
        argparse.Namespace: Parsed arguments
    """
    parser = argparse.ArgumentParser(
        description="Script description",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
    %(prog)s --input data.csv --output results.json
    %(prog)s --input data.json --output results.csv --verbose
        """
    )
    
    parser.add_argument(
        '--input', '-i',
        type=Path,
        required=True,
        help='Input file path'
    )
    
    parser.add_argument(
        '--output', '-o',
        type=Path,
        default=DEFAULT_OUTPUT_DIR / "results.json",
        help='Output file path (default: %(default)s)'
    )
    
    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Enable verbose logging'
    )
    
    parser.add_argument(
        '--version',
        action='version',
        version=f'%(prog)s {VERSION}'
    )
    
    return parser.parse_args()

def main() -> int:
    """
    Main function - entry point of the script.
    
    Returns:
        int: Exit code (0 for success, non-zero for failure)
    """
    try:
        # Parse arguments
        args = parse_arguments()
        
        # Configure logging level
        if args.verbose:
            logging.getLogger().setLevel(logging.DEBUG)
        
        logger.info(f"Starting script with input: {args.input}")
        
        # Validate inputs
        validate_input(args.input)
        
        # Load data (implement based on input format)
        data = load_data(args.input)
        
        # Process data
        processed_data = process_data(data)
        
        # Save results
        save_results(processed_data, args.output)
        
        logger.info("Script completed successfully")
        return 0
        
    except ScriptError as e:
        logger.error(f"Script error: {e}")
        return 1
    except KeyboardInterrupt:
        logger.info("Script interrupted by user")
        return 130
    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        return 1

if __name__ == "__main__":
    sys.exit(main())
```

## Documentation Standards

### Docstring Format (Google Style)
```python
def function_name(param1: type, param2: type) -> return_type:
    """
    Brief description of the function.
    
    Longer description if needed. Explain the purpose, behavior,
    and any important implementation details.
    
    Args:
        param1 (type): Description of parameter 1
        param2 (type): Description of parameter 2
        
    Returns:
        return_type: Description of return value
        
    Raises:
        ExceptionType: Description of when this exception is raised
        
    Examples:
        >>> result = function_name("value1", 42)
        >>> print(result)
        Expected output
        
    Note:
        Any additional notes or warnings
    """
```

### Class Documentation
```python
class DataProcessor:
    """
    A class for processing data files.
    
    This class provides methods to load, process, and save data
    in various formats.
    
    Attributes:
        input_path (Path): Path to input file
        output_path (Path): Path to output file
        config (Dict): Configuration settings
        
    Examples:
        >>> processor = DataProcessor("input.csv", "output.json")
        >>> processor.process()
        >>> print(f"Processed {processor.record_count} records")
    """
    
    def __init__(self, input_path: str, output_path: str):
        """
        Initialize the DataProcessor.
        
        Args:
            input_path (str): Path to input file
            output_path (str): Path to output file
        """
```

## Best Practices

### Error Handling
```python
# Use specific exceptions
try:
    result = risky_operation()
except FileNotFoundError:
    logger.error("File not found")
    raise
except PermissionError:
    logger.error("Permission denied")
    raise
except Exception as e:
    logger.error(f"Unexpected error: {e}")
    raise

# Custom exceptions for script-specific errors
class ValidationError(Exception):
    """Raised when input validation fails."""
    pass

class ProcessingError(Exception):
    """Raised when data processing fails."""
    pass
```

### Input Validation
```python
def validate_config(config: Dict[str, Any]) -> None:
    """Validate configuration parameters."""
    required_keys = ["input_dir", "output_dir", "format"]
    
    for key in required_keys:
        if key not in config:
            raise ValidationError(f"Missing required config key: {key}")
    
    if config["format"] not in SUPPORTED_FORMATS:
        raise ValidationError(f"Unsupported format: {config['format']}")
```

### Logging Best Practices
```python
# Use appropriate log levels
logger.debug("Detailed information for debugging")
logger.info("General information about script progress")
logger.warning("Something unexpected happened")
logger.error("Error occurred but script can continue")
logger.critical("Serious error, script cannot continue")

# Include context in log messages
logger.info(f"Processing file: {filename} ({file_size} bytes)")
logger.error(f"Failed to process record {record_id}: {error_message}")
```

### Type Hints
```python
from typing import Optional, List, Dict, Any, Union, Tuple

def process_records(
    records: List[Dict[str, Any]], 
    config: Optional[Dict[str, str]] = None
) -> Tuple[List[Dict[str, Any]], int]:
    """Process records with optional configuration."""
    pass
```

### Configuration Management
```python
import json
from pathlib import Path

def load_config(config_path: Path) -> Dict[str, Any]:
    """Load configuration from JSON file."""
    try:
        with open(config_path, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        logger.warning(f"Config file not found: {config_path}")
        return get_default_config()
```

## Testing Guidelines

### Unit Test Structure
```python
import unittest
from unittest.mock import patch, MagicMock
import tempfile
from pathlib import Path

class TestDataProcessor(unittest.TestCase):
    """Test cases for DataProcessor class."""
    
    def setUp(self):
        """Set up test fixtures."""
        self.temp_dir = tempfile.mkdtemp()
        self.input_file = Path(self.temp_dir) / "test_input.csv"
        self.output_file = Path(self.temp_dir) / "test_output.json"
    
    def tearDown(self):
        """Clean up test fixtures."""
        shutil.rmtree(self.temp_dir)
    
    def test_validate_input_valid_file(self):
        """Test input validation with valid file."""
        # Create test file
        self.input_file.touch()
        
        # Test validation
        self.assertTrue(validate_input(self.input_file))
    
    def test_validate_input_missing_file(self):
        """Test input validation with missing file."""
        with self.assertRaises(ScriptError):
            validate_input(self.input_file)
    
    @patch('script_name.logger')
    def test_process_data_success(self, mock_logger):
        """Test successful data processing."""
        test_data = [{"id": 1, "name": "test"}]
        result = process_data(test_data)
        
        self.assertEqual(len(result), 1)
        mock_logger.info.assert_called()

if __name__ == "__main__":
    unittest.main()
```

## Performance Considerations

### Memory Management
```python
# Use generators for large datasets
def process_large_file(file_path: Path):
    """Process large file line by line."""
    with open(file_path, 'r') as f:
        for line_num, line in enumerate(f, 1):
            yield process_line(line, line_num)

# Process in chunks
def process_in_chunks(data: List, chunk_size: int = 1000):
    """Process data in chunks to manage memory."""
    for i in range(0, len(data), chunk_size):
        chunk = data[i:i + chunk_size]
        yield process_chunk(chunk)
```

### Progress Tracking
```python
from tqdm import tqdm

def process_with_progress(items: List) -> List:
    """Process items with progress bar."""
    results = []
    
    for item in tqdm(items, desc="Processing items"):
        result = process_item(item)
        results.append(result)
    
    return results
```

## Security Best Practices

### Input Sanitization
```python
import re
from pathlib import Path

def sanitize_filename(filename: str) -> str:
    """Sanitize filename to prevent path traversal."""
    # Remove or replace dangerous characters
    safe_filename = re.sub(r'[<>:"/\\|?*]', '_', filename)
    return safe_filename[:255]  # Limit length

def validate_path(path: Path, allowed_dir: Path) -> Path:
    """Validate that path is within allowed directory."""
    resolved_path = path.resolve()
    allowed_resolved = allowed_dir.resolve()
    
    if not str(resolved_path).startswith(str(allowed_resolved)):
        raise SecurityError("Path outside allowed directory")
    
    return resolved_path
```

### Environment Variables
```python
import os
from typing import Optional

def get_env_var(name: str, default: Optional[str] = None) -> str:
    """Get environment variable with validation."""
    value = os.getenv(name, default)
    
    if value is None:
        raise EnvironmentError(f"Required environment variable not set: {name}")
    
    return value

# Usage
API_KEY = get_env_var("API_KEY")
DEBUG_MODE = get_env_var("DEBUG", "false").lower() == "true"
```

## Quality Checklist

### Code Quality
- [ ] Functions are single-purpose and well-named
- [ ] Variables have descriptive names
- [ ] Code follows PEP 8 style guidelines
- [ ] No magic numbers or hardcoded values
- [ ] Proper error handling throughout
- [ ] Type hints for all function parameters and returns

### Documentation
- [ ] Script header with purpose and usage
- [ ] Docstrings for all functions and classes
- [ ] Inline comments for complex logic
- [ ] Examples in docstrings
- [ ] README or usage documentation

### Testing & Validation
- [ ] Input validation for all user inputs
- [ ] Unit tests for core functions
- [ ] Error cases tested
- [ ] Edge cases considered
- [ ] Integration tests if applicable

### Maintainability
- [ ] Configuration externalized
- [ ] Logging implemented throughout
- [ ] Version information included
- [ ] Dependencies clearly documented
- [ ] Code is modular and reusable

## Project Structure Templates

### For AI/Automation Scripts (scripts/ folder)
```python
#!/usr/bin/env python3
"""
AI-Usable Script Template

Simple, focused script for automation tasks.
Designed to be called by Cursor OS or other automation systems.
"""

import logging
from pathlib import Path
from typing import Optional

# Simple logging for automation
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def main(input_path: Optional[str] = None) -> bool:
    """
    Main function optimized for AI usage.
    
    Args:
        input_path: Optional input parameter
        
    Returns:
        bool: True if successful, False otherwise
    """
    try:
        # Simple, focused logic
        logger.info("Starting automation task")
        # Implementation here
        logger.info("Task completed successfully")
        return True
    except Exception as e:
        logger.error(f"Task failed: {e}")
        return False

if __name__ == "__main__":
    import sys
    input_arg = sys.argv[1] if len(sys.argv) > 1 else None
    success = main(input_arg)
    sys.exit(0 if success else 1)
```

### For Standalone Projects (documents/projects/ folder)
When creating a full project, generate this complete structure:

#### README.md Template
```markdown
# Project Name

Brief description of what this project does.

## Installation

```bash
pip install -r requirements.txt
```

## Usage

```bash
python src/main.py --help
```

## Examples

```python
from src.modules.core import MainClass

# Example usage
app = MainClass()
result = app.process()
```

## Development

```bash
# Run tests
python -m pytest tests/

# Install in development mode
pip install -e .
```

## License

MIT License (or your preferred license)
```

#### requirements.txt Template
```
# Core dependencies
click>=8.0.0
requests>=2.28.0
pandas>=1.5.0

# Development dependencies
pytest>=7.0.0
black>=22.0.0
flake8>=5.0.0
mypy>=1.0.0
```

#### setup.py Template
```python
from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements.txt", "r", encoding="utf-8") as fh:
    requirements = [line.strip() for line in fh if line.strip() and not line.startswith("#")]

setup(
    name="project-name",
    version="0.1.0",
    author="Your Name",
    author_email="your.email@example.com",
    description="Brief project description",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/username/project-name",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
    python_requires=">=3.8",
    install_requires=requirements,
    entry_points={
        "console_scripts": [
            "project-name=src.main:main",
        ],
    },
)
```

#### .gitignore Template
```
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# Distribution / packaging
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

# PyInstaller
*.manifest
*.spec

# Unit test / coverage reports
htmlcov/
.tox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
.hypothesis/
.pytest_cache/

# Virtual environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Project specific
data/private/
config/local.yaml
logs/
```

## Decision Matrix: Where to Place Your Script

| Script Characteristic | Location | Structure |
|----------------------|----------|-----------|
| **System automation** | `scripts/utilities/` | Single file, simple |
| **Cursor OS enhancement** | `scripts/automation/` | Single file, focused |
| **Development tooling** | `scripts/development/` | Single file, reusable |
| **Learning project** | `documents/projects/` | Full project structure |
| **Shareable application** | `documents/projects/` | Full project structure |
| **Data analysis** | `documents/projects/` | Full project with notebooks |
| **Web application** | `documents/projects/` | Full project with requirements |
| **Library/package** | `documents/projects/` | Full project with setup.py |

## Quick Decision Questions

**PRIMARY QUESTION**: "Is this script FOR Cursor OS automation, or FOR the user?"

### For Cursor OS → `scripts/` folder:
- System automation tasks
- Cursor OS enhancements  
- AI workflow utilities
- Internal tool scripts

### For User → `documents/projects/project-name/` folder:
- Learning projects
- Personal applications
- Shareable code
- Any script the user will run directly
- Data analysis projects
- Web applications
- **DEFAULT: When in doubt, create user project**

**🔄 Simple Rule**: If user says "create a Python script" without specifying it's for automation → create full project in `documents/projects/`

Remember: Write code as if the person maintaining it is a violent psychopath who knows where you live. Make it clear, documented, and robust! 