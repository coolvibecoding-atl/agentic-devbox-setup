#!/usr/bin/env node
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import axios from "axios";

// Using spline API if available, or providing mocked interactive hooks for Splinetool URLs
const SPLINE_API_BASE = "https://api.spline.design/v1";

const server = new Server(
    {
        name: "spline-mcp",
        version: "1.0.0",
    },
    {
        capabilities: {
            tools: {},
        },
    }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
    return {
        tools: [
            {
                name: "generate_spline_react_component",
                description: "Takes a public Spline URL and generates the standard @splinetool/react-spline implementation code.",
                inputSchema: {
                    type: "object",
                    properties: {
                        splineUrl: {
                            type: "string",
                            description: "The public URL to the spline export (e.g., https://prod.spline.design/abc/scene.splinecode)",
                        },
                        componentName: {
                            type: "string",
                            description: "Name of the react component to generate"
                        }
                    },
                    required: ["splineUrl", "componentName"],
                },
            },
        ],
    };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    if (request.params.name === "generate_spline_react_component") {
        const { splineUrl, componentName } = request.params.arguments;

        // Antigravity frontend-lead needs the exact syntax to embed spline 3d models
        const reactCode = `
import Spline from '@splinetool/react-spline';

export default function ${componentName}() {
  return (
    <div className="w-full h-screen">
      <Spline scene="${splineUrl}" />
    </div>
  );
}
`;

        return {
            content: [{ type: "text", text: `Successfully generated Spline React Component. Requires 'npm install @splinetool/react-spline'\n\n${reactCode}` }],
        };
    }

    throw new Error("Tool not found");
});

const transport = new StdioServerTransport();
server.connect(transport).catch(console.error);
