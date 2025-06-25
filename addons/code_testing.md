# Code Testing Addon

## Purpose
This addon provides comprehensive guidelines for Cursor OS to implement thorough testing strategies for all code projects, applications, and scripts. It ensures quality, reliability, and functionality through systematic testing approaches.

## Core Testing Philosophy

### 1. Test-First Mindset
- **Always consider testing before and during development**
- Create test plans alongside project creation
- Implement tests as part of the development process, not an afterthought
- Every function, component, or module should have corresponding tests

### 2. Multi-Layer Testing Strategy
- **Unit Tests**: Individual functions and components
- **Integration Tests**: Module interactions and APIs
- **End-to-End Tests**: Complete user workflows
- **Performance Tests**: Speed, memory, and resource usage
- **Security Tests**: Vulnerability assessments

## Testing Protocols by Project Type

### Python Projects
**Required Testing Stack:**
```python
# requirements-test.txt additions
pytest>=7.0.0
pytest-cov>=4.0.0
pytest-mock>=3.0.0
black>=22.0.0
flake8>=5.0.0
mypy>=1.0.0
```

**Testing Structure:**
```
project-name/
├── src/
├── tests/
│   ├── __init__.py
│   ├── unit/
│   ├── integration/
│   └── conftest.py
├── pytest.ini
└── tox.ini
```

**Automated Testing Commands:**
1. `pytest tests/ -v --cov=src --cov-report=html`
2. `black --check src/ tests/`
3. `flake8 src/ tests/`
4. `mypy src/`

### Web Applications (Next.js/React)
**Required Testing Stack:**
```json
{
  "devDependencies": {
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0",
    "@testing-library/user-event": "^14.0.0",
    "jest": "^29.0.0",
    "jest-environment-jsdom": "^29.0.0",
    "cypress": "^13.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0"
  }
}
```

**Testing Commands:**
1. `npm run test` (Jest unit tests)
2. `npm run test:coverage`
3. `npx cypress run` (E2E tests)
4. `npm run lint`
5. `npm run build` (build verification)

### Scripts and Utilities
**Testing Requirements:**
- Input validation testing
- Error handling verification
- Edge case coverage
- Cross-platform compatibility (if applicable)
- Performance benchmarking

## Automated Testing Workflow

### Post-Creation Testing Protocol
**When creating any project, ALWAYS:**

1. **Immediate Syntax Check**
   ```bash
   # Python
   python -m py_compile filename.py
   
   # JavaScript/TypeScript
   npm run build
   
   # General linting
   appropriate-linter-command
   ```

2. **Dependency Verification**
   ```bash
   # Python
   pip check
   
   # Node.js
   npm audit
   
   # Check for missing imports
   ```

3. **Basic Functionality Test**
   - Run main entry points
   - Test core functions with sample data
   - Verify expected outputs

4. **Create Test Suite**
   - Generate basic test files
   - Write smoke tests for main functionality
   - Set up testing infrastructure

### Quality Gates
**Before marking any project as complete:**

✅ **Code Quality**
- [ ] Passes all linting rules
- [ ] Code coverage > 80%
- [ ] No syntax errors
- [ ] Documentation exists

✅ **Functionality**
- [ ] All main features work as expected
- [ ] Error handling is implemented
- [ ] Edge cases are handled
- [ ] User input is validated

✅ **Performance**
- [ ] Acceptable execution time
- [ ] No memory leaks
- [ ] Efficient resource usage
- [ ] Scalability considerations

✅ **Security** (if applicable)
- [ ] Input sanitization
- [ ] Authentication/authorization
- [ ] No hardcoded secrets
- [ ] Dependency security audit

## Testing Implementation Guide

### 1. Test File Creation
**Always create test files immediately after main files:**

```python
# For src/calculator.py, create tests/test_calculator.py
import pytest
from src.calculator import Calculator

class TestCalculator:
    def setup_method(self):
        self.calc = Calculator()
    
    def test_addition(self):
        assert self.calc.add(2, 3) == 5
    
    def test_division_by_zero(self):
        with pytest.raises(ZeroDivisionError):
            self.calc.divide(10, 0)
```

### 2. Mock External Dependencies
```python
import pytest
from unittest.mock import patch, Mock

@patch('requests.get')
def test_api_call(mock_get):
    mock_get.return_value.json.return_value = {'status': 'success'}
    result = api_function()
    assert result['status'] == 'success'
```

### 3. Performance Testing
```python
import time
import pytest

def test_function_performance():
    start_time = time.time()
    result = expensive_function()
    execution_time = time.time() - start_time
    
    assert execution_time < 1.0  # Should complete in under 1 second
    assert result is not None
```

## Continuous Testing Strategy

### 1. Pre-Commit Testing
Create `.pre-commit-config.yaml`:
```yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.3.0
    hooks:
      - id: black
  - repo: https://github.com/pycqa/flake8
    rev: 6.0.0
    hooks:
      - id: flake8
  - repo: local
    hooks:
      - id: pytest
        name: pytest
        entry: pytest
        language: system
        pass_filenames: false
        always_run: true
```

### 2. CI/CD Integration
Create `.github/workflows/test.yml`:
```yaml
name: Test Suite
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install -r requirements-test.txt
      - name: Run tests
        run: pytest --cov=src --cov-report=xml
      - name: Upload coverage
        uses: codecov/codecov-action@v3
```

## Error Detection and Handling

### 1. Common Error Patterns to Test
- **Null/None inputs**
- **Empty collections**
- **Invalid data types**
- **Network failures**
- **File system errors**
- **Memory limitations**
- **Concurrent access issues**

### 2. Test Data Management
```python
# conftest.py
import pytest
import tempfile
import os

@pytest.fixture
def temp_file():
    with tempfile.NamedTemporaryFile(delete=False) as f:
        f.write(b"test data")
        temp_path = f.name
    
    yield temp_path
    
    # Cleanup
    if os.path.exists(temp_path):
        os.unlink(temp_path)

@pytest.fixture
def sample_data():
    return {
        "valid_input": {"name": "test", "value": 123},
        "invalid_input": {"name": "", "value": -1},
        "edge_cases": [None, "", 0, [], {}]
    }
```

## Documentation Testing

### 1. Docstring Examples
```python
def calculate_area(radius: float) -> float:
    """
    Calculate the area of a circle.
    
    Args:
        radius: The radius of the circle
        
    Returns:
        The area of the circle
        
    Examples:
        >>> calculate_area(5)
        78.53981633974483
        >>> calculate_area(0)
        0.0
    """
    import math
    return math.pi * radius ** 2

# Test with: python -m doctest module.py
```

### 2. README Verification
- Verify all code examples in README work
- Test installation instructions
- Validate API documentation examples

## Reporting and Metrics

### 1. Test Reports
Always generate comprehensive test reports:
```bash
# Python
pytest --html=reports/report.html --cov-report=html:reports/coverage

# JavaScript
npm test -- --coverage --watchAll=false --coverageReporters=html
```

### 2. Quality Metrics to Track
- **Code Coverage Percentage**
- **Test Execution Time**
- **Number of Tests per Module**
- **Failed Test Trends**
- **Performance Benchmarks**

## Manual Testing Checklist

### User Experience Testing
- [ ] **Intuitive Interface**: Easy to understand and use
- [ ] **Error Messages**: Clear and helpful
- [ ] **Response Time**: Acceptable performance
- [ ] **Accessibility**: Works for different user needs
- [ ] **Cross-Platform**: Functions on target platforms

### Edge Case Scenarios
- [ ] **Empty/null inputs**
- [ ] **Maximum/minimum values**
- [ ] **Network interruptions**
- [ ] **Insufficient permissions**
- [ ] **Concurrent usage**

## Best Practices Summary

### 1. Test Naming Conventions
```python
def test_should_return_error_when_invalid_input():
    pass

def test_should_calculate_correctly_with_positive_numbers():
    pass
```

### 2. Test Organization
- Group related tests in classes
- Use descriptive test names
- Keep tests focused and simple
- Avoid test interdependencies

### 3. Maintenance
- Update tests when code changes
- Remove obsolete tests
- Refactor test code like production code
- Keep test data fresh and relevant

## Implementation Command for Cursor OS

**When creating any project, immediately after file creation:**

1. **Execute testing setup**:
   ```bash
   # Create test directory structure
   # Install testing dependencies
   # Generate basic test files
   # Run initial test suite
   ```

2. **Document testing approach** in project README
3. **Set up continuous testing** if applicable
4. **Verify all quality gates** before project completion
5. **Generate test report** and save to `documents/`

Remember: **No project is complete without a comprehensive test suite and passing all quality gates.** 