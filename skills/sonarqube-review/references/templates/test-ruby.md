# Template de Teste Ruby (RSpec)

```ruby
require 'rspec'
require 'example'

RSpec.describe ExampleClass do
  let(:mock_dependency) { double('Dependency') }
  let(:example) { ExampleClass.new(mock_dependency) }

  describe '#method' do
    it 'should return expected value' do
      # Given
      allow(mock_dependency).to receive(:get_value).and_return('expected')

      # When
      result = example.method

      # Then
      expect(result).to eq('expected')
      expect(mock_dependency).to have_received(:get_value).once
    end
  end
end
```

## Padrões

- Use RSpec
- Use double para mocks
- Given-When-Then pattern
- Verifique todas as chamadas de mocks
- Use let para setup lazy
