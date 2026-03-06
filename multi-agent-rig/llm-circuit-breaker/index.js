const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const rateLimit = require('express-rate-limit');

const app = express();
const PORT = process.env.PORT || 8002;

// ─── Lane 1: OpenRouter (High Volume) ───
const openrouterLimiter = rateLimit({
    windowMs: 60 * 1000,
    max: parseInt(process.env.MAX_REQ_PER_MIN || '60'), // Increased for multi-agent bursts
    message: { error: { message: 'OpenRouter limit exceeded. Circuit breaker engaged.' } }
});

app.use('/openrouter', openrouterLimiter, createProxyMiddleware({
    target: 'https://openrouter.ai',
    changeOrigin: true,
    pathRewrite: {
        '^/openrouter': '', // strip base path before forwarding
    },
    onProxyReq: (proxyReq, req, res) => {
        // Pass headers cleanly
    }
}));

// ─── Lane 2: Claude Code Pro (Strict Limit) ───
const claudeLimiter = rateLimit({
    windowMs: 60 * 1000,
    max: 5, // STRICT 5 req/min for $20 Pro Plan protection
    message: { error: { message: 'Claude Pro limit exceeded (5/min). Circuit breaker engaged to prevent ban.' } }
});

app.use('/claude', claudeLimiter, createProxyMiddleware({
    target: 'https://api.anthropic.com',
    changeOrigin: true,
    pathRewrite: {
        '^/claude': '', // strip base path before forwarding
    },
    onProxyReq: (proxyReq, req, res) => {
        // Pass headers cleanly
    }
}));

// ─── Fallback Legacy Route ───
app.use('/', openrouterLimiter, createProxyMiddleware({
    target: process.env.TARGET_URL || 'https://openrouter.ai',
    changeOrigin: true
}));

app.listen(PORT, () => {
    console.log(`🛡️ LLM Circuit Breaker Running on port ${PORT}`);
    console.log(` ├── /openrouter : 60 req/min`);
    console.log(` └── /claude     : 5 req/min (Pro Plan Protection)`);
});
