# Template de Teste Python (pytest)

```python
import pytest
from unittest.mock import Mock, patch
from example import ExampleClass

class TestExampleClass:
    
    @pytest.fixture
    def example_instance(self):
        return ExampleClass()
    
    @pytest.fixture
    def mock_dependency(self):
        return Mock()
    
    def test_method(self, example_instance, mock_dependency):
        # Given
        mock_dependency.get_value.return_value = "expected"
        
        # When
        result = example_instance.method(mock_dependency)
        
        # Then
        assert result == "expected"
        mock_dependency.get_value.assert_called_once()
```

## Padrões

- Use pytest
- Use unittest.mock para mocks
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use fixtures para setup
