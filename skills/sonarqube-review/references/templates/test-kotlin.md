# Template de Teste Kotlin (KotlinTest + Mockk)

```kotlin
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import org.junit.jupiter.api.Test
import kotlin.test.assertEquals

class ExampleClassTest {

    @Test
    fun `method should return expected value`() {
        // Given
        val mockDependency = mockk<Dependency>()
        every { mockDependency.getValue() } returns "expected"
        val sut = ExampleClass(mockDependency)

        // When
        val result = sut.method()

        // Then
        assertEquals("expected", result)
        verify { mockDependency.getValue() }
    }
}
```

## Padrões

- Use KotlinTest ou JUnit 5
- Use Mockk para mocks
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use backticks para nomes de testes descritivos
