# Template de Teste C# (xUnit + Moq)

```csharp
using Xunit;
using Moq;

namespace Example.Tests
{
    public class ExampleClassTests
    {
        private readonly Mock<IDependency> _mockDependency;
        private readonly ExampleClass _sut;

        public ExampleClassTests()
        {
            _mockDependency = new Mock<IDependency>();
            _sut = new ExampleClass(_mockDependency.Object);
        }

        [Fact]
        public void Method_ShouldReturnExpectedValue()
        {
            // Given
            _mockDependency.Setup(x => x.GetValue()).Returns("expected");

            // When
            var result = _sut.Method();

            // Then
            Assert.Equal("expected", result);
            _mockDependency.Verify(x => x.GetValue(), Times.Once);
        }
    }
}
```

## Padrões

- Use xUnit
- Use Moq para mocks
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use construtor para setup
