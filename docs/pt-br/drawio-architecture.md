# Diagramas de Arquitetura Draw.io
Integra a autoria profissional de diagramas com o servidor MCP oficial do draw.io para visualização automatizada de sistemas.

## 🎯 Objetivo
Preencher a lacuna entre requisitos em texto e a arquitetura visual. Permite que agentes não apenas descrevam um sistema, mas construam e abram um diagrama profissional e editável no draw.io.

## 🛠️ Como Funciona
A skill utiliza dois caminhos principais de entrega:
1. **Integração MCP**: Chama o servidor `@drawio/mcp` para abrir diagramas diretamente no navegador, eliminando a necessidade de importações manuais de arquivos.
2. **CLI Local**: Gera XML nativo `.drawio` e o exporta para PNG/SVG/PDF para entregáveis.

Ela segue regras estritas de autoria de XML (grades rígidas, cores semânticas e containers aninhados) para garantir que o resultado seja profissional e editável.

## 🚀 Uso
Use esta skill sempre que precisar visualizar a arquitetura de um sistema, topologia de rede, infraestrutura de nuvem ou fluxos de negócio complexos.

## 🔗 Correlação
- **Harness**: A configuração MCP para o draw.io deve ser documentada no `TOOLS.md` de um harness criado pelo `create-agent-harness`.
- **Design**: Este é o resultado visual da fase de planejamento que geralmente ocorre antes de implementar os padrões discutidos em `building-mcp-servers`.
