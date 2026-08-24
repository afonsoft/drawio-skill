# Observabilidade e Instrumentação
Um guia para construir sistemas que sejam "operáveis", garantindo que o comportamento em produção seja visível e diagnosticável.

## 🎯 Objetivo
Eliminar a fase de "arqueologia" do debugging. Em vez de tentar adivinhar o que aconteceu durante um crash em produção, esta skill garante que o sistema emita a telemetria correta para responder "o que está acontecendo e por quê?" imediatamente.

## 🛠️ Como Funciona
A skill muda a abordagem de "logar tudo" para "responder perguntas específicas":
1. **Definir Perguntas**: Determinar o que um engenheiro de sobreaviso (on-call) precisa saber.
2. **Seleção de Sinais**: Mapear perguntas para **Métricas** (que algo está errado), **Traces** (onde está errado) e **Logs** (por que está errado).
3. **Implementação**: Impõe logs estruturados (JSON), IDs de correlação e padrões neutros de fornecedor via OpenTelemetry.
4. **Alertas Baseados em Sintomas**: Muda os alertas de causas (CPU alta) para sintomas (Taxa de erro > 1%).

## 🚀 Uso
Use esta skill sempre que estiver implementando uma nova funcionalidade que rodará em produção, especialmente se envolver I/O, APIs externas ou jobs em segundo plano.

## 🔗 Correlação
- **Debugging**: Este é o lado "preventivo" da skill `debugging-and-error-recovery`. Uma boa observabilidade torna o debugging trivial.
- **Qualidade**: Código de alta qualidade (via `code-review-and-quality`) deve incluir a instrumentação como parte do seu eixo de "Corretude".
