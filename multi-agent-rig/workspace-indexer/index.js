// Workspace Indexer
// Watches /workspace/project and keeps ChromaDB in sync for code-search skill
const { ChromaClient } = require("chromadb");
const chokidar = require("chokidar");
const fs = require("fs");
const path = require("path");
const { glob } = require("glob");

const CHROMA_URL = process.env.CHROMA_URL || "http://chromadb:8000";
const WORKSPACE_DIR = process.env.WORKSPACE_DIR || "/workspace/project";
const EXTENSIONS = [".ts", ".tsx", ".js", ".jsx", ".py", ".md", ".json", ".yaml", ".yml"];

const client = new ChromaClient({ path: CHROMA_URL });

async function indexFile(collection, filePath) {
    try {
        const content = fs.readFileSync(filePath, "utf-8");
        if (!content.trim()) return;
        const id = filePath.replace(WORKSPACE_DIR, "").replace(/\//g, "__");
        await collection.upsert({
            ids: [id],
            documents: [content],
            metadatas: [{ path: filePath, ext: path.extname(filePath) }],
        });
        console.log(`[indexed] ${filePath.replace(WORKSPACE_DIR, "")}`);
    } catch (e) {
        console.warn(`[skip] ${filePath}: ${e.message}`);
    }
}

async function main() {
    console.log("🔍 Workspace Indexer starting...");
    console.log(`  ChromaDB: ${CHROMA_URL}`);
    console.log(`  Workspace: ${WORKSPACE_DIR}`);

    const codeCollection = await client.getOrCreateCollection({ name: "codebase" });
    const docCollection = await client.getOrCreateCollection({ name: "documentation" });

    // Initial full index
    const files = await glob(`${WORKSPACE_DIR}/**/*{${EXTENSIONS.join(",")}}`, {
        ignore: ["**/node_modules/**", "**/.git/**", "**/dist/**", "**/.next/**"],
    });

    console.log(`📚 Indexing ${files.length} files...`);
    for (const file of files) {
        const collection = file.includes("/docs/") ? docCollection : codeCollection;
        await indexFile(collection, file);
    }
    console.log("✅ Initial index complete.");

    // Watch for changes
    const watcher = chokidar.watch(WORKSPACE_DIR, {
        ignored: /(node_modules|\.git|dist|\.next)/,
        persistent: true,
        ignoreInitial: true,
    });

    watcher
        .on("add", async (fp) => {
            if (EXTENSIONS.some(e => fp.endsWith(e))) {
                const col = fp.includes("/docs/") ? docCollection : codeCollection;
                await indexFile(col, fp);
            }
        })
        .on("change", async (fp) => {
            if (EXTENSIONS.some(e => fp.endsWith(e))) {
                const col = fp.includes("/docs/") ? docCollection : codeCollection;
                await indexFile(col, fp);
            }
        });

    console.log("👀 Watching for file changes...");
}

main().catch(console.error);
