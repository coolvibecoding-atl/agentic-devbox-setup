const express = require('express');
const { exec } = require('child_process');
const app = express();

app.use(express.json());
const PORT = process.env.PORT || 8003;

app.post('/webhook', (req, res) => {
    const event = req.headers['x-github-event'];
    if (event === 'push') {
        console.log('📦 Push event received. Triggering qa-guardian...');
        // In the real rig, this hits OpenClaw's HTTP API or uses the CLI inside the container
        exec('openclaw message send --agent qa-guardian --message "Run full quality audit on recent push"', (err, stdout) => {
            if (err) console.error('Failed to trigger QA:', err.message);
            else console.log('✅ QA Triggered:', stdout);
        });
    }
    res.sendStatus(200);
});

app.listen(PORT, () => console.log(`🐙 GitHub Webhook server listening on ${PORT}`));
