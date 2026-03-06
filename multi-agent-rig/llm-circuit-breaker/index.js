const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const rateLimit = require('express-rate-limit');

const app = express();
const PORT = process.env.PORT || 8002;
const TARGET_URL = process.env.TARGET_URL || 'https://openrouter.ai';

const limiter = rateLimit({
    windowMs: 60 * 1000,
    max: parseInt(process.env.MAX_REQ_PER_MIN || '20'),
    message: { error: { message: 'Rate limit exceeded. Circuit breaker engaged.' } }
});

app.use('/', limiter, createProxyMiddleware({
    target: TARGET_URL,
    changeOrigin: true,
    onProxyReq: (proxyReq, req, res) => {
        // Pass headers cleanly
    }
}));

app.listen(PORT, () => console.log(`🛡️ LLM Circuit Breaker proxying to ${TARGET_URL} on port ${PORT}`));
