#!/usr/bin/env node
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import {
    CallToolRequestSchema,
    ListToolsRequestSchema,
} from "@modelcontextprotocol/sdk/types.js";
import { exec } from "child_process";
import fs from "fs";
import path from "path";

const BLENDER_BIN = "/Applications/Blender.app/Contents/MacOS/Blender";

const server = new Server(
    {
        name: "blender-mcp",
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
                name: "render_python_script",
                description: "Executes a headless Python script inside Blender to generate/modify 3D assets.",
                inputSchema: {
                    type: "object",
                    properties: {
                        pythonCode: {
                            type: "string",
                            description: "The full python script to execute using blender's bpy module.",
                        },
                        outputGLBPath: {
                            type: "string",
                            description: "Optional absolute path where the script drops the .glb file. Allows validation that output occurred.",
                        },
                    },
                    required: ["pythonCode"],
                },
            },
        ],
    };
});

server.setRequestHandler(CallToolRequestSchema, async (request) => {
    if (request.params.name === "render_python_script") {
        const { pythonCode, outputGLBPath } = request.params.arguments;

        // We run blender in background without UI, executing the python file.
        const tempScript = path.join("/tmp", `blender_script_${Date.now()}.py`);
        fs.writeFileSync(tempScript, pythonCode);

        try {
            const result = await new Promise((resolve, reject) => {
                // -b runs in background. -P runs python.
                exec(`"${BLENDER_BIN}" -b -P "${tempScript}"`, (error, stdout, stderr) => {
                    if (error) {
                        reject(`Error executing blender script: ${error.message}\nStderr: ${stderr}`);
                    } else {
                        let confirmMsg = "Blender execution complete.\n";
                        if (outputGLBPath && fs.existsSync(outputGLBPath)) {
                            confirmMsg += `Output file confirmed available at: ${outputGLBPath}\n`;
                        }
                        resolve(confirmMsg + `Stdout: ${stdout.substring(0, 1000)}...`);
                    }
                });
            });

            fs.unlinkSync(tempScript); // cleanup

            return {
                content: [{ type: "text", text: result }],
            };
        } catch (err) {
            if (fs.existsSync(tempScript)) fs.unlinkSync(tempScript);
            return {
                content: [{ type: "text", text: err.toString() }],
                isError: true,
            };
        }
    }

    throw new Error("Tool not found");
});

const transport = new StdioServerTransport();
server.connect(transport).catch(console.error);
