# Criando README e CHANGELOG
Esta skill automatiza a geração de documentação profissional de projetos, garantindo que READMEs e Changelogs sejam baseados em evidências e sigam padrões da indústria.

## 🎯 Objetivo
Eliminar a "dívida de documentação", transformando o estado real do código e o histórico do git em um `README.md` e `CHANGELOG.md` claros, navegáveis e profissionais.

## 🛠️ Como Funciona
A skill evita a armadilha dos "templates genéricos" ao forçar uma Fase de Descoberta primeiro. Ela analisa o DNA do projeto (stack, arquitetura, commits) antes de escrever. Em seguida, aplica dois padrões rigorosos:
- **README**: Uma estrutura abrangente de 11 seções que cobre desde o valor de negócio até a implementação técnica.
- **CHANGELOG**: Aderência estrita ao padrão "Keep a Changelog" e Versionamento Semântico (SemVer).

## 🚀 Uso
Use esta skill ao iniciar um novo repositório, ao assumir um projeto legado com documentação precária ou ao preparar um release. Ela garante que qualquer pessoa (humana ou agente) que chegue ao repositório saiba exatamente o que o projeto é, como executá-lo e o que mudou.

## 🔗 Correlação
- **Integração com Harness**: Esta skill é frequentemente a etapa final do fluxo de `create-agent-harness` para garantir que a página inicial do repositório seja profissional.
- **Qualidade**: Um README profissional faz parte do eixo de "Legibilidade" da skill `code-review-and-quality`.
