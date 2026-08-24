# Template de Teste Scala (ScalaTest + Mockito)

```scala
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import org.scalatestplus.mockito.MockitoSugar
import org.mockito.Mockito._

class ExampleClassSpec extends AnyFlatSpec with Matchers with MockitoSugar {

  "ExampleClass" should "return expected value" in {
    // Given
    val mockDependency = mock[Dependency]
    when(mockDependency.getValue()).thenReturn("expected")
    val sut = new ExampleClass(mockDependency)

    // When
    val result = sut.method()

    // Then
    result shouldBe "expected"
    verify(mockDependency).getValue()
  }
}
```

## Padrões

- Use ScalaTest
- Use Mockito para mocks
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use shouldMatchers para asserções
