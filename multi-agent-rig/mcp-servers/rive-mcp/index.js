#!/usr/bin/env node
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";

const server = new Server(
    { name: "rive-mcp", version: "1.0.0" },
    { capabilities: { tools: {} } }
);

server.setRequestHandler(ListToolsRequestSchema, async () => {
    return {
        tools: [
            {
                name: "generate_rive_component",
                description: "Generates the @rive-app/react-canvas boilerplate for a given .riv file.",
                inputSchema: {
                    type: "object",
                    properties: {
                        rivPath: { type: "string" },
                        stateMachineName: { type: "string" },
                        componentName: { type: "string" }
                    },
                    required: ["rivPath", "stateMachineName", "componentName"],
                },
            },
        ],
    };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    if (request.params.name === "generate_rive_component") {
        const { rivPath, stateMachineName, componentName } = request.params.arguments;

        const reactCode = `
import { useRive, useStateMachineInput } from '@rive-app/react-canvas';

export default function ${componentName}() {
  const { rive, RiveComponent } = useRive({
    src: '${rivPath}',
    stateMachines: '${stateMachineName}',
    autoplay: true,
  });

  // Example Input binding
  // const onHoverInput = useStateMachineInput(rive, '${stateMachineName}', 'Hover');

  return (
    <div className="w-[500px] h-[500px]">
      <RiveComponent />
    </div>
  );
}
`;
        return {
            content: [{ type: "text", text: `Successfully generated Rive component:\n\n${reactCode}` }],
        };
    }
    throw new Error("Tool not found");
});

const transport = new StdioServerTransport();
server.connect(transport).catch(console.error);
