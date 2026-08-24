# Draw.io Architecture Diagrams
Integrates professional architecture authoring with the official draw.io MCP server for automated system visualization.

## 🎯 Purpose
Bridge the gap between text-based requirements and visual architecture. It allows agents to not only describe a system but to actually build and open an editable, professional diagram in draw.io.

## 🛠️ How it Works
The skill uses two primary delivery paths:
1. **MCP Integration**: Calls the `@drawio/mcp` server to open diagrams directly in the browser, eliminating the need for manual file imports.
2. **Local CLI**: Generates native `.drawio` XML and exports it to PNG/SVG/PDF for deliverables.

It follows strict XML authoring rules (rigid grids, semantic coloring, and nested containers) to ensure the output is professional and editable.

## 🚀 Usage
Use this skill whenever you need to visualize a system architecture, network topology, cloud infrastructure, or complex business flow.

## 🔗 Correlation
- **Harness**: The MCP configuration for draw.io should be documented in the `TOOLS.md` of a harness created by `create-agent-harness`.
- **Design**: This is the visual output of the planning phase that usually happens before implementing the patterns discussed in `building-mcp-servers`.
