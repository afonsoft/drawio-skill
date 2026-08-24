# Template de Teste Go

```go
package example_test

import (
    "testing"
    "github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/mock"
)

type MockDependency struct {
    mock.Mock
}

func (m *MockDependency) GetValue() string {
    args := m.Called()
    return args.String(0)
}

func TestExampleMethod(t *testing.T) {
    // Given
    mockDep := new(MockDependency)
    mockDep.On("GetValue").Return("expected")
    sut := NewExample(mockDep)

    // When
    result := sut.Method()

    // Then
    assert.Equal(t, "expected", result)
    mockDep.AssertExpectations(t)
}
```

## Padrões

- Use testing
- Use testify/mock para mocks
- Use testify/assert para asserções
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
