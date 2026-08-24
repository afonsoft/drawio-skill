# Template de Teste TypeScript (Jest)

```typescript
import { ExampleClass } from './example';

describe('ExampleClass', () => {
  let example: ExampleClass;
  let mockDependency: jest.Mocked<Dependency>;

  beforeEach(() => {
    mockDependency = {
      getValue: jest.fn()
    } as jest.Mocked<Dependency>;
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

- Use Jest com TypeScript
- Use jest.Mocked para type safety
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use beforeEach para setup
