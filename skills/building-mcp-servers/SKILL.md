---
name: building-mcp-servers
license: UNLICENSED
description: Use when building MCP (Model Context Protocol) servers that let LLMs call external APIs or services, in TypeScript (MCP SDK), Python (FastMCP), or C# (ModelContextProtocol.AspNetCore). Covers tool design, transports (Streamable HTTP/stdio), OAuth 2.1 auth, and evaluations. Do NOT use for consuming or configuring an existing MCP server, or for non-MCP API integrations.
author: afonsoft
url: https://github.com/afonsoft/skills
metadata:
  version: "1.1.0"
  visibility: public
  author: afonsoft
---

# MCP Server Development Guide

## Overview

Create MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. The quality of an MCP server is measured by how well it enables LLMs to accomplish real-world tasks.

---

# Process

## 🚀 High-Level Workflow

Creating a high-quality MCP server involves four main phases:

### Phase 1: Deep Research and Planning

#### 1.1 Understand Modern MCP Design

**API Coverage vs. Workflow Tools:**
Balance comprehensive API endpoint coverage with specialized workflow tools. Workflow tools can be more convenient for specific tasks, while comprehensive coverage gives agents flexibility to compose operations. Performance varies by client—some clients benefit from code execution that combines basic tools, while others work better with higher-level workflows. When uncertain, prioritize comprehensive API coverage.

**Tool Naming and Discoverability:**
Clear, descriptive tool names help agents find the right tools quickly. Use consistent prefixes (e.g., `github_create_issue`, `github_list_repos`) and action-oriented naming.

**Context Management:**
Agents benefit from concise tool descriptions and the ability to filter/paginate results. Design tools that return focused, relevant data. Some clients support code execution which can help agents filter and process data efficiently.

**Actionable Error Messages:**
Error messages should guide agents toward solutions with specific suggestions and next steps.

#### 1.2 Study MCP Protocol Documentation

**Navigate the MCP specification:**

Start with the sitemap to find relevant pages: `https://modelcontextprotocol.io/sitemap.xml` 

Then fetch specific pages with `.md` suffix for markdown format (e.g., `https://modelcontextprotocol.io/specification/draft.md`).

Key pages to review:
- Specification overview and architecture
- Transport mechanisms (streamable HTTP, stdio)
- Tool, resource, and prompt definitions

#### 1.3 Study Framework Documentation

**Recommended stack:**
- **Language**: TypeScript (high-quality SDK support and good compatibility in many execution environments e.g. MCPB. Plus AI models are good at generating TypeScript code, benefiting from its broad usage, static typing and good linting tools)
- **Transport**: Streamable HTTP for remote servers, using stateless JSON (simpler to scale and maintain, as opposed to stateful sessions and streaming responses). stdio for local servers.

**Load framework documentation:**

- **MCP Best Practices**: [📋 View Best Practices](./reference/mcp_best_practices.md) - Core guidelines

**For TypeScript (recommended):**
- **TypeScript SDK**: Use WebFetch to load `https://raw.githubusercontent.com/modelcontextprotocol/typescript-sdk/main/README.md` 
- [⚡ TypeScript Guide](./reference/node_mcp_server.md) - TypeScript patterns and examples

**For Python:**
- **Python SDK**: Use WebFetch to load `https://raw.githubusercontent.com/modelcontextprotocol/python-sdk/main/README.md` 
- [🐍 Python Guide](./reference/python_mcp_server.md) - Python patterns and examples

**For C# (.NET):**
- **C# SDK**: Use WebFetch to load `https://raw.githubusercontent.com/modelcontextprotocol/csharp-sdk/main/README.md`
- [🔷 .NET Guide](./reference/dotnet_mcp_server.md) - .NET patterns and examples

#### 1.4 Plan Your Implementation

**Understand the API:**
Review the service's API documentation to identify key endpoints, authentication requirements, and data models. Use web search and WebFetch as needed.

**Tool Selection:**
Prioritize comprehensive API coverage. List endpoints to implement, starting with the most common operations.

---

### Phase 2: Implementation

#### 2.1 Set Up Project Structure

See language-specific guides for project setup:
- [⚡ TypeScript Guide](./reference/node_mcp_server.md) - Project structure, package.json, tsconfig.json
- [🐍 Python Guide](./reference/python_mcp_server.md) - Module organization, dependencies
- [🔷 .NET Guide](./reference/dotnet_mcp_server.md) - .csproj, Program.cs, project structure

#### 2.2 Implement Core Infrastructure

Create shared utilities:
- API client with authentication
- Error handling helpers
- Response formatting (JSON/Markdown)
- Pagination support

#### 2.3 Implement Tools

For each tool:

**Input Schema:**
- Use Zod (TypeScript), Pydantic (Python), or Data Annotations (.NET)
- Include constraints and clear descriptions
- Add examples in field descriptions

**Output Schema:**
- Define `outputSchema` where possible for structured data
- Use `structuredContent` in tool responses (TypeScript SDK feature)
- Helps clients understand and process tool outputs

**Tool Description:**
- Concise summary of functionality
- Parameter descriptions
- Return type schema

**Implementation:**
- Async/await for I/O operations
- Proper error handling with actionable messages
- Support pagination where applicable
- Return both text content and structured data when using modern SDKs

**Annotations:**
- `readOnlyHint`: true/false
- `destructiveHint`: true/false
- `idempotentHint`: true/false
- `openWorldHint`: true/false

---

### Phase 3: Review and Test

#### 3.1 Code Quality

Review for:
- No duplicated code (DRY principle)
- Consistent error handling
- Full type coverage
- Clear tool descriptions

#### 3.2 Build and Test

**TypeScript:**
- Run `npm run build` to verify compilation
- Test with MCP Inspector: `npx @modelcontextprotocol/inspector` 

**Python:**
- Verify syntax: `python -m py_compile your_server.py` 
- Test with MCP Inspector

**.NET:**
- Run `dotnet build` to verify compilation
- Run `dotnet run` to test locally
- Test with MCP Inspector

See language-specific guides for detailed testing approaches and quality checklists.

---

### Phase 4: Create Evaluations

After implementing your MCP server, create comprehensive evaluations to test its effectiveness.

**Load [✅ Evaluation Guide](./reference/evaluation.md) for complete evaluation guidelines.**

#### 4.1 Understand Evaluation Purpose

Use evaluations to test whether LLMs can effectively use your MCP server to answer realistic, complex questions.

#### 4.2 Create 10 Evaluation Questions

To create effective evaluations, follow the process outlined in the evaluation guide:

1. **Tool Inspection**: List available tools and understand their capabilities
2. **Content Exploration**: Use READ-ONLY operations to explore available data
3. **Question Generation**: Create 10 complex, realistic questions
4. **Answer Verification**: Solve each question yourself to verify answers

#### 4.3 Evaluation Requirements

Ensure each question is:
- **Independent**: Not dependent on other questions
- **Read-only**: Only non-destructive operations required
- **Complex**: Requiring multiple tool calls and deep exploration
- **Realistic**: Based on real use cases humans would care about
- **Verifiable**: Single, clear answer that can be verified by string comparison
- **Stable**: Answer won't change over time

#### 4.4 Output Format

Create an XML file with this structure:

```xml
<evaluation>
  <qa_pair>
    <question>Find discussions about AI model launches with animal codenames. One model needed a specific safety designation that uses the format ASL-X. What number X was being determined for the model named after a spotted wild cat?</question>
    <answer>3</answer>
  </qa_pair>
<!-- More qa_pairs... -->
</evaluation>
```

---

# Reference Files

## 📚 Documentation Library

Load these resources as needed during development:

### Core MCP Documentation (Load First)
- **MCP Protocol**: Start with sitemap at `https://modelcontextprotocol.io/sitemap.xml`, then fetch specific pages with `.md` suffix
- [📋 MCP Best Practices](./reference/mcp_best_practices.md) - Universal MCP guidelines including:
  - Server and tool naming conventions
  - Response format guidelines (JSON vs Markdown)
  - Pagination best practices
  - Transport selection (streamable HTTP vs stdio)
  - Security and error handling standards

### SDK Documentation (Load During Phase 1/2)
- **Python SDK**: Fetch from `https://raw.githubusercontent.com/modelcontextprotocol/python-sdk/main/README.md` 
- **TypeScript SDK**: Fetch from `https://raw.githubusercontent.com/modelcontextprotocol/typescript-sdk/main/README.md` 
- **C# SDK**: Fetch from `https://raw.githubusercontent.com/modelcontextprotocol/csharp-sdk/main/README.md`

### Language-Specific Implementation Guides (Load During Phase 2)
- [🐍 Python Implementation Guide](./reference/python_mcp_server.md) - Complete Python/FastMCP guide with:
  - Server initialization patterns
  - Pydantic model examples
  - Tool registration with `@mcp.tool` 
  - Complete working examples
  - Quality checklist

- [⚡ TypeScript Implementation Guide](./reference/node_mcp_server.md) - Complete TypeScript guide with:
  - Project structure
  - Zod schema patterns
  - Tool registration with `server.registerTool` 
  - Complete working examples
  - Quality checklist

- [🔷 .NET Implementation Guide](./reference/dotnet_mcp_server.md) - Complete .NET/C# guide with:
  - Project structure and .csproj configuration
  - Attribute-based tool registration with `[McpServerTool]`
  - Dependency injection patterns
  - Complete working examples
  - Quality checklist

### Evaluation Guide (Load During Phase 4)
- [✅ Evaluation Guide](./reference/evaluation.md) - Complete evaluation creation guide with:
  - Question creation guidelines
  - Answer verification strategies
  - XML format specifications
  - Example questions and answers
  - Running an evaluation with the provided scripts

---

# Quick Reference

## Quick Reference

| Language | Package | Version | Transport |
| ---------- | --------- | --------- | ----------- |
| TypeScript | `@modelcontextprotocol/sdk` | 1.25.1 | `StreamableHTTPServerTransport` |
| Python | `mcp` | 1.25.0 | `transport="streamable-http"` |
| C# | `ModelContextProtocol` / `ModelContextProtocol.AspNetCore` | 1.3.0 (stable) | `.WithStdioServerTransport()` / `.WithHttpTransport()` |

> **C# package selection:** use **`ModelContextProtocol`** for stdio/local servers (hosting + DI, lighter deps), **`ModelContextProtocol.AspNetCore`** for HTTP/remote servers, and **`ModelContextProtocol.Core`** when you only need a client. As of 2026 the SDK is **GA (1.x stable)** — no `--prerelease` flag is required.

### Transport Status

| Transport | Status | Use Case |
| ----------- | -------- | ---------- |
| **stdio** | Supported | Local/CLI (Claude Desktop, Cursor) |
| **Streamable HTTP** | Recommended | Remote servers, production |
| **SSE** | Deprecated | Legacy only |

## Streamable HTTP Transport

**Single endpoint** replaces dual SSE endpoints. Supports stateful sessions or stateless (serverless) mode.

### Protocol Flow

```text
Client                              Server
  |------ POST /mcp ---------------->|  (JSON-RPC messages)
  |<----- JSON or SSE response ------|
  |------ GET /mcp ----------------->|  (Optional: server-initiated)
  |<----- SSE stream ----------------|
```

### Required Headers

```http
POST /mcp HTTP/1.1
Content-Type: application/json
Accept: application/json, text/event-stream
Mcp-Session-Id: <session-id>  # After initialization
```

## TypeScript Implementation

### Installation

```bash
npm install @modelcontextprotocol/sdk zod express
npm install -D @types/express
```

### Basic Server

```typescript
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";
import { z } from "zod";
import express from "express";

const app = express();
app.use(express.json());

const server = new McpServer({
  name: "my-server",
  version: "1.0.0"
});

// Tool
server.registerTool("add", {
  description: "Add two numbers",
  inputSchema: { a: z.number(), b: z.number() }
}, async ({ a, b }) => ({
  content: [{ type: "text", text: String(a + b) }]
}));

// Resource
server.registerResource(
  "config",
  "config://app",
  { description: "App configuration" },
  async (uri) => ({
    contents: [{ uri: uri.href, text: JSON.stringify({ env: "prod" }) }]
  })
);

// Prompt
server.registerPrompt("review", {
  description: "Code review",
  argsSchema: { code: z.string() }
}, ({ code }) => ({
  messages: [{ role: "user", content: { type: "text", text: `Review:\n${code}` } }]
}));

// Transport
const transport = new StreamableHTTPServerTransport({
  sessionIdGenerator: () => crypto.randomUUID()
});

await server.connect(transport);

app.all("/mcp", async (req, res) => {
  await transport.handleRequest(req, res);
});

app.listen(3000);
```

> **Note:** Top-level `await` requires Node.js with ES modules (`"type": "module"` in package.json or `.mjs` extension).

### Stateless Mode (Serverless)

```typescript
const transport = new StreamableHTTPServerTransport({
  sessionIdGenerator: undefined  // Disables sessions
});
```

## Python Implementation

### Installation

```bash
pip install "mcp[cli]"
```

### Basic Server (FastMCP)

```python
from mcp.server.fastmcp import FastMCP, Context
from typing import List

mcp = FastMCP("my-server")

# Tool
@mcp.tool()
def add(a: int, b: int) -> int:
    """Add two numbers."""
    return a + b

# Async tool with progress
@mcp.tool()
async def process_files(files: List[str], ctx: Context) -> str:
    """Process files with progress."""
    for i, f in enumerate(files):
        await ctx.report_progress(i + 1, len(files))
    return f"Processed {len(files)} files"

# Resource
@mcp.resource("config://app")
def get_config() -> dict:
    """App configuration."""
    return {"env": "prod", "version": "1.0.0"}

# Dynamic resource
@mcp.resource("users://{user_id}/profile")
def get_user(user_id: str) -> dict:
    """Get user profile."""
    return {"id": user_id, "name": f"User {user_id}"}

# Prompt
@mcp.prompt()
def code_review(code: str, language: str = "python") -> str:
    """Code review prompt."""
    return f"Review this {language} code:\n\n```{language}\n{code}\n```"

if __name__ == "__main__":
    # Streamable HTTP
    mcp.run(transport="streamable-http", host="0.0.0.0", port=8000, path="/mcp")
    # Or stdio: mcp.run()
```

### FastAPI Integration

```python
from fastapi import FastAPI
from mcp.server.fastmcp import FastMCP

api = FastAPI()
mcp = FastMCP("api-tools")

@mcp.tool()
def query(sql: str) -> dict:
    return {"result": "data"}

api.mount("/mcp", mcp.streamable_http_app())
# Run: uvicorn app:api --port 8000
```

## C# Implementation

### Installation

```bash
# HTTP / remote server
dotnet add package ModelContextProtocol.AspNetCore

# stdio / local server (lighter — no ASP.NET Core dependency)
# dotnet add package ModelContextProtocol
```

### Basic Server

```csharp
using System.ComponentModel;
using Microsoft.Extensions.DependencyInjection;
using ModelContextProtocol.Server;

var builder = WebApplication.CreateBuilder(args);

builder.Services
    .AddMcpServer()
    .WithHttpTransport()
    .WithToolsFromAssembly()
    .WithPromptsFromAssembly()
    .WithResourcesFromAssembly();

var app = builder.Build();
app.MapMcp();  // Maps the Streamable HTTP MCP endpoint at the root path
app.Run();

// Tools
[McpServerToolType]
public static class MyTools
{
    [McpServerTool, Description("Add two numbers")]
    public static int Add(
        [Description("First number")] int a,
        [Description("Second number")] int b) => a + b;

    [McpServerTool, Description("Get weather")]
    public static async Task<string> GetWeather(
        HttpClient http,  // Injected from DI
        [Description("City name")] string city,
        CancellationToken ct)
    {
        var data = await http.GetStringAsync($"https://api.weather.example/{city}", ct);
        return data;
    }
}

// Prompts
[McpServerPromptType]
public static class MyPrompts
{
    [McpServerPrompt, Description("Code review prompt")]
    public static ChatMessage CodeReview(
        [Description("Code to review")] string code) =>
        new(ChatRole.User, $"Review this code:\n\n{code}");
}

// Resources
[McpServerResourceType]
public static class MyResources
{
    [McpServerResource(Name = "config://app"), Description("App config")]
    public static string Config() => """{"env": "production"}""";

    [McpServerResource(UriTemplate = "docs://{topic}")]
    public static string GetDoc([Description("Topic")] string topic) =>
        $"Documentation for {topic}";
}
```

### Stdio Transport (Local)

```csharp
var builder = Host.CreateApplicationBuilder(args);

builder.Logging.AddConsole(o => o.LogToStandardErrorThreshold = LogLevel.Trace);

builder.Services
    .AddMcpServer()
    .WithStdioServerTransport()
    .WithToolsFromAssembly();

await builder.Build().RunAsync();
```

> **Package note:** the stdio host above only needs the **`ModelContextProtocol`** package (plus `Microsoft.Extensions.Hosting`). `ModelContextProtocol.AspNetCore` is only required for the HTTP transport.

### Stateless HTTP (Serverless)

For serverless/horizontally-scaled deployments that don't need server-to-client requests (sampling, elicitation), enable stateless mode:

```csharp
builder.Services
    .AddMcpServer()
    .WithHttpTransport(options => options.Stateless = true)
    .WithToolsFromAssembly();
```

## Authentication (OAuth 2.1)

MCP servers are **OAuth Resource Servers** (not Authorization Servers). Key requirements:

- **PKCE mandatory** (S256 method)
- **Resource Indicators** (RFC 8707) required
- **Bearer tokens** in Authorization header
- **Audience validation** on every request

### Discovery Endpoints

```http
GET /.well-known/oauth-protected-resource  # Server metadata
GET /.well-known/oauth-authorization-server  # Auth server metadata
```

### Server Response on 401

```http
HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="mcp",
  resource_metadata="https://mcp.example.com/.well-known/oauth-protected-resource"
```

### Token Validation (Python)

```python
import jwt
from jwt import PyJWKClient

class TokenValidator:
    def __init__(self, jwks_uri: str, audience: str):
        self.jwks = PyJWKClient(jwks_uri)
        self.audience = audience

    def validate(self, token: str) -> dict:
        key = self.jwks.get_signing_key_from_jwt(token)
        return jwt.decode(
            token, key.key,
            algorithms=["RS256"],
            audience=self.audience,
            options={"require": ["exp", "aud", "iss"]}
        )
```

### Protected Resource Metadata Response

```json
{
  "resource": "https://mcp.example.com",
  "authorization_servers": ["https://auth.example.com"],
  "scopes_supported": ["read", "write", "admin"],
  "bearer_methods_supported": ["header"]
}
```

### OAuth Middleware Integration (Python/Starlette)

```python
from starlette.applications import Starlette
from starlette.middleware import Middleware
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.responses import JSONResponse
from mcp.server.fastmcp import FastMCP

class BearerAuthMiddleware(BaseHTTPMiddleware):
    def __init__(self, app, validator: TokenValidator):
        super().__init__(app)
        self.validator = validator

    async def dispatch(self, request, call_next):
        auth = request.headers.get("Authorization", "")
        if not auth.startswith("Bearer "):
            return JSONResponse(
                {"error": "unauthorized"},
                status_code=401,
                headers={"WWW-Authenticate": 'Bearer realm="mcp"'}
            )
        try:
            token = auth.replace("Bearer ", "")
            request.state.auth = self.validator.validate(token)
        except Exception:
            return JSONResponse({"error": "invalid_token"}, status_code=401)
        return await call_next(request)

# Setup
mcp = FastMCP("secure-server")
validator = TokenValidator(
    jwks_uri="https://auth.example.com/.well-known/jwks.json",
    audience="https://mcp.example.com"
)

app = Starlette(
    routes=[Mount("/mcp", app=mcp.streamable_http_app())],
    middleware=[Middleware(BearerAuthMiddleware, validator=validator)]
)
```

### OAuth Middleware Integration (TypeScript/Express)

```typescript
import jwt from "jsonwebtoken";
import jwksClient from "jwks-rsa";

const client = jwksClient({ jwksUri: "https://auth.example.com/.well-known/jwks.json" });

const authMiddleware = async (req, res, next) => {
  const auth = req.headers.authorization;
  if (!auth?.startsWith("Bearer ")) {
    return res.status(401).json({ error: "unauthorized" });
  }
  try {
    const token = auth.slice(7);
    const decoded = jwt.decode(token, { complete: true });
    const key = await client.getSigningKey(decoded.header.kid);
    req.auth = jwt.verify(token, key.getPublicKey(), {
      audience: "https://mcp.example.com",
      algorithms: ["RS256"]
    });
    next();
  } catch (err) {
    res.status(401).json({ error: "invalid_token" });
  }
};

app.use("/mcp", authMiddleware);
```

### Authenticated Client Request

```typescript
const transport = new StreamableHTTPClientTransport(
  new URL("https://mcp.example.com/mcp"),
  {
    requestInit: {
      headers: { Authorization: `Bearer ${accessToken}` }
    }
  }
);
```

### Security Anti-Patterns

| Anti-Pattern | Fix |
| -------------- | ----- |
| Token passthrough to upstream APIs | Use separate tokens for upstream calls |
| Missing audience validation | Always validate `aud` claim |
| Tokens in URLs | Use Authorization header only |

### Scope Enforcement in Tools

Check scopes before executing sensitive operations:

**TypeScript:**

```typescript
const authMiddleware = async (req, res, next) => {
  // ... token validation ...
  req.auth = { sub: decoded.sub, scopes: decoded.scope?.split(" ") || [] };
  next();
};

server.registerTool("delete_user", { /* ... */ }, async ({ userId }, { meta }) => {
  const scopes = meta?.auth?.scopes || [];
  if (!scopes.includes("admin:write")) {
    return { isError: true, content: [{ type: "text", text: "Insufficient scope" }] };
  }
  // ... perform deletion ...
});
```

**Python:** Use HTTP middleware to validate, then check in tools:

```python
# With Starlette middleware (see OAuth Middleware Integration above)
# Store validated claims in request.state, then check in tool:

@mcp.tool()
def delete_user(user_id: str) -> str:
    """Delete user - requires admin:write scope."""
    # Scope enforcement happens at HTTP layer via middleware
    # Tool assumes request already passed auth checks
    return f"Deleted user {user_id}"
```

> **Note:** For advanced middleware with per-tool auth context, use `fastmcp` package (`pip install fastmcp`) which provides `Middleware` class and `Context.get_state()`. The official `mcp` package provides FastMCP but with simpler middleware options.

### Passing Auth Context to Tool Handlers

**TypeScript:** Store auth on transport or use a request-scoped context:

```typescript
// In middleware: attach to request
req.auth = { sub: decoded.sub, email: decoded.email };

// Pass to tool via server context or closure
const sessions = new Map();
app.all("/mcp", async (req, res) => {
  const transport = new StreamableHTTPServerTransport({ /* ... */ });
  sessions.set(transport.sessionId, { auth: req.auth });
  // Tools access via sessions.get(sessionId)
});
```

**Python (with `fastmcp` package):** Use middleware and context state:

```python
# pip install fastmcp
from fastmcp import FastMCP, Context
from fastmcp.server.middleware import Middleware, MiddlewareContext

mcp = FastMCP("my-server")

class AuthMiddleware(Middleware):
    async def on_call_tool(self, context: MiddlewareContext, call_next):
        # Extract and validate token, then store in context
        context.fastmcp_context.set_state("user_id", "user_123")
        context.fastmcp_context.set_state("scopes", ["read", "write"])
        return await call_next()

mcp.add_middleware(AuthMiddleware())

@mcp.tool
async def get_my_profile(ctx: Context) -> dict:
    user_id = ctx.get_state("user_id")  # Set by middleware
    return {"user_id": user_id, "profile": "..."}
```

### Token Refresh Handling

Access tokens are short-lived (typically 1 hour). Strategies:

1. **Client-side refresh:** Clients refresh tokens before expiration and reconnect
2. **Proactive server refresh:** Background task refreshes tokens expiring soon
3. **On-demand refresh:** Return 401, client refreshes and retries

**Recommended pattern:** Use short-lived access tokens (5-60 min) with refresh tokens. On 401:

```typescript
// Client retry logic
async function callWithRefresh(tool: string, args: object) {
  try {
    return await client.callTool(tool, args);
  } catch (err) {
    if (err.status === 401) {
      accessToken = await refreshAccessToken(refreshToken);
      transport.updateHeaders({ Authorization: `Bearer ${accessToken}` });
      return await client.callTool(tool, args);
    }
    throw err;
  }
}
```

## Migration: SSE to Streamable HTTP

### Server Changes

```typescript
// OLD (SSE) - Two endpoints
app.get("/sse", async (req, res) => {
  const transport = new SSEServerTransport("/sse/messages", res);
  await server.connect(transport);
});
app.post("/sse/messages", async (req, res) => { /* ... */ });

// NEW (Streamable HTTP) - Single endpoint
app.all("/mcp", async (req, res) => {
  const transport = new StreamableHTTPServerTransport();
  await server.connect(transport);
  await transport.handleRequest(req, res);
});
```

### Client Changes

```typescript
// OLD
import { SSEClientTransport } from "@modelcontextprotocol/sdk/client/sse.js";
const transport = new SSEClientTransport(new URL("http://localhost:3000/sse"));

// NEW
import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";
const transport = new StreamableHTTPClientTransport(new URL("http://localhost:3000/mcp"));
```

### Backward-Compatible Server

```typescript
// Support both transports during migration
app.all("/mcp", /* new Streamable HTTP handler */);
app.get("/sse", /* legacy SSE handler */);
app.post("/sse/messages", /* legacy message handler */);
```

## Client Configuration

### Claude Desktop / Claude Code (stdio)

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["/path/to/server.js"],
      "env": { "API_KEY": "secret" }
    }
  }
}
```

### Remote Server (Streamable HTTP)

```json
{
  "mcpServers": {
    "remote": {
      "type": "streamable-http",
      "url": "https://mcp.example.com/mcp"
    }
  }
}
```

## Error Handling

Return tool errors (not protocol errors) for model self-correction:

**TypeScript:**

```typescript
server.registerTool("query", { /* ... */ }, async ({ sql }) => {
  if (sql.includes("DROP")) {
    return {
      isError: true,
      content: [{ type: "text", text: "Destructive queries not allowed" }]
    };
  }
  // ...
});
```

**Python:** Raise exceptions in tools - they're caught and returned as errors:

```python
@mcp.tool()
def query(sql: str) -> dict:
    if "DROP" in sql.upper():
        raise ValueError("Destructive queries not allowed")
    return {"result": "data"}
```

## Common Mistakes

| Mistake | Fix |
| --------- | ----- |
| Using SSE for new servers | Use Streamable HTTP |
| Writing to stdout in stdio servers | Use stderr for logs |
| Missing session ID after init | Always include `Mcp-Session-Id` header |
| Not validating OAuth audience | Validate token `aud` matches your server |
| Forwarding client tokens upstream | Use separate credentials for upstream APIs |

## Official Resources

### SDKs

- **TypeScript**: <https://github.com/modelcontextprotocol/typescript-sdk>
- **Python**: <https://github.com/modelcontextprotocol/python-sdk>
- **C#**: <https://github.com/modelcontextprotocol/csharp-sdk>

### Documentation

- **Specification**: <https://modelcontextprotocol.io/specification/2025-11-25>
- **Transports**: <https://modelcontextprotocol.io/specification/2025-11-25/basic/transports>
- **Authorization**: <https://modelcontextprotocol.io/specification/2025-11-25/basic/authorization>

### Testing

```bash
npx @modelcontextprotocol/inspector node path/to/server.js
```
