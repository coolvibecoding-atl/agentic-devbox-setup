#!/usr/bin/env node
// PAI Memory Hub — ChromaDB persistent agent memory
// Runs as a sidecar HTTP server and persists agent decisions, preferences, and
// architectural decisions across sessions
//
// Usage:
//   node memory-hub.js         → starts on port 8005
//   curl -X POST http://localhost:8005/remember -H "Content-Type: application/json" \
//     -d '{"agent":"arch-director","type":"decision","key":"nav-router","value":"Using React Navigation v6 — NOT Expo Router"}'
//   curl http://localhost:8005/recall?agent=arch-director&query=navigation

const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = process.env.MEMORY_PORT || 8005;
const MEMORY_FILE = path.join(process.env.HOME, '.openclaw', 'memory-hub.json');

// Load or initialize persistent memory store
let memory = { sessions: [], index: [] };
if (fs.existsSync(MEMORY_FILE)) {
    try { memory = JSON.parse(fs.readFileSync(MEMORY_FILE, 'utf8')); } catch { }
}

function save() {
    fs.writeFileSync(MEMORY_FILE, JSON.stringify(memory, null, 2));
}

function remember({ agent, type, key, value, tags = [] }) {
    const entry = {
        id: Date.now().toString(36),
        agent,
        type, // decision | preference | bug | architecture | context
        key,
        value,
        tags,
        ts: new Date().toISOString()
    };
    memory.index.push(entry);
    if (memory.index.length > 10000) memory.index.splice(0, 1000); // rolling window
    save();
    return entry;
}

function recall({ agent, query, limit = 10 }) {
    const q = (query || '').toLowerCase();
    return memory.index
        .filter(e => {
            if (agent && e.agent !== agent && e.agent !== 'ALL') return false;
            if (!q) return true;
            return (
                e.key.toLowerCase().includes(q) ||
                JSON.stringify(e.value).toLowerCase().includes(q) ||
                e.tags.some(t => t.toLowerCase().includes(q))
            );
        })
        .slice(-limit)
        .reverse();
}

const server = http.createServer((req, res) => {
    res.setHeader('Content-Type', 'application/json');

    const url = new URL(req.url, `http://localhost:${PORT}`);
    const pathname = url.pathname;

    if (req.method === 'POST' && pathname === '/remember') {
        let body = '';
        req.on('data', d => body += d);
        req.on('end', () => {
            try {
                const payload = JSON.parse(body);
                const entry = remember(payload);
                res.writeHead(200);
                res.end(JSON.stringify({ ok: true, entry }));
            } catch (e) {
                res.writeHead(400);
                res.end(JSON.stringify({ error: e.message }));
            }
        });
        return;
    }

    if (req.method === 'GET' && pathname === '/recall') {
        const agent = url.searchParams.get('agent');
        const query = url.searchParams.get('query');
        const limit = parseInt(url.searchParams.get('limit') || '10');
        const results = recall({ agent, query, limit });
        res.writeHead(200);
        res.end(JSON.stringify({ count: results.length, results }));
        return;
    }

    if (req.method === 'GET' && pathname === '/health') {
        res.writeHead(200);
        res.end(JSON.stringify({ ok: true, entries: memory.index.length, file: MEMORY_FILE }));
        return;
    }

    if (req.method === 'DELETE' && pathname === '/forget') {
        let body = '';
        req.on('data', d => body += d);
        req.on('end', () => {
            try {
                const { id } = JSON.parse(body);
                memory.index = memory.index.filter(e => e.id !== id);
                save();
                res.writeHead(200);
                res.end(JSON.stringify({ ok: true }));
            } catch (e) {
                res.writeHead(400);
                res.end(JSON.stringify({ error: e.message }));
            }
        });
        return;
    }

    res.writeHead(404);
    res.end(JSON.stringify({ error: 'Not found' }));
});

server.listen(PORT, () => {
    console.log(`🧠 PAI Memory Hub running on :${PORT}`);
    console.log(`   Memory file: ${MEMORY_FILE}`);
    console.log(`   Entries loaded: ${memory.index.length}`);
    console.log('');
    console.log(`   POST /remember  { agent, type, key, value, tags }`);
    console.log(`   GET  /recall?agent=X&query=Y&limit=10`);
    console.log(`   GET  /health`);
});

// Graceful shutdown
process.on('SIGTERM', () => { save(); process.exit(0); });
process.on('SIGINT', () => { save(); process.exit(0); });
