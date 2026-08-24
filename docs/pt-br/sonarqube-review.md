# Revisão SonarQube
Um sistema automatizado para identificar e corrigir problemas de qualidade de código reportados pelo SonarQube em qualquer stack tecnológica.

## 🎯 Objetivo
Fechar o ciclo entre a análise estática automatizada e as correções reais de código. Ela transforma uma lista de "smells" e "vulnerabilidades" em melhorias de código verificadas, testadas e mergeadas.

## 🛠️ Como Funciona
A skill fornece um pipeline autônomo para remediação de qualidade:
1. **Detecção de Stack**: Identifica automaticamente a linguagem e as ferramentas de build do projeto.
2. **Extração de Issues**: Baixa as issues não resolvidas do SonarQube via API.
3. **Correção Iterativa**: Para cada issue: Corrige → Gera Teste → Verifica 100% de cobertura das linhas alteradas → Formata.
4. **Validação**: Usa scripts de scan local para verificar as correções antes de enviar para o CI/CD.
5. **Métricas**: Gera um dashboard mostrando o tempo economizado e as issues resolvidas.

## 🚀 Uso
Use esta skill quando tiver um relatório do SonarQube e precisar limpar a base de código sem ter que triar manualmente centenas de issues.

## 🔗 Correlação
- **Automação**: Esta é a contraparte "automatizada" da skill manual `code-review-and-quality`.
- **Testes**: Depende fortemente dos princípios de TDD usados nos sub-agentes de teste do `create-agent-harness`.
