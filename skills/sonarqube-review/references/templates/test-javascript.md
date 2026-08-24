# Template de Teste JavaScript (Jest)

```javascript
const { ExampleClass } = require('./example');

describe('ExampleClass', () => {
  let example;
  let mockDependency;

  beforeEach(() => {
    mockDependency = {
      getValue: jest.fn()
    };
    example = new ExampleClass(mockDependency);
  });

  test('method should return expected value', () => {
    // Given
    mockDependency.getValue.mockReturnValue('expected');

    // When
    const result = example.method();

    // Then
    expect(result).toBe('expected');
    expect(mockDependency.getValue).toHaveBeenCalled();
  });
});
```

## Padrões

- Use Jest
- Use jest.fn() para mocks
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use beforeEach para setup
