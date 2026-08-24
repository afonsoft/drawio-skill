# Building MCP Servers
A comprehensive guide for developing Model Context Protocol (MCP) servers that empower LLMs to interact with external APIs and services.

## 🎯 Purpose
Standardize the creation of MCP servers across different languages (TypeScript, Python, C#) to ensure they are discoverable, efficient, and secure.

## 🛠️ How it Works
The skill guides the developer through a 4-phase lifecycle:
1. **Research & Planning**: Designing tools based on API coverage and discoverability.
2. **Implementation**: Using SDKs (TypeScript, FastMCP, .NET) to build tools, resources, and prompts.
3. **Review & Test**: Validating with the MCP Inspector and ensuring type safety.
4. **Evaluation**: Creating a set of 10 complex QA pairs to verify the server's real-world effectiveness.

## 🚀 Usage
Use this skill when you need to give an agent a "new power"—such as connecting it to a proprietary database, a legacy API, or a custom internal tool.

## 🔗 Correlation
- **Advanced Path**: This is the "power-user" extension of the harness. While `create-agent-harness` sets up the agent, `building-mcp-servers` gives it new capabilities.
- **Integration**: The resulting server can be configured in the `TOOLS.md` of a harness created by `create-agent-harness`.
