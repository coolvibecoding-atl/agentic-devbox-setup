const express = require('express');
const { exec } = require('child_process');
const app = express();

app.use(express.json());
const PORT = process.env.PORT || 8003;

app.post('/webhook', (req, res) => {
    const event = req.headers['x-github-event'];

    if (event === 'push') {
        console.log('📦 Push event received. Triggering qa-guardian...');
        exec('openclaw message send --agent qa-guardian --message "Run full quality audit on recent push"', (err, stdout) => {
            if (err) console.error('Failed to trigger QA:', err.message);
            else console.log('✅ QA Triggered:', stdout);
        });
    }
    // Enhancement #11 & #12: Self-healing CI/CD + Voice Briefings
    else if (event === 'workflow_run') {
        const payload = req.body;
        if (payload.action === 'completed' && payload.workflow_run && payload.workflow_run.conclusion === 'failure') {
            console.log('🚨 CI/CD Pipeline Failed! Activating Self-Healing Protocol...');

            // 1. Trigger the auto-repair loop
            exec('openclaw message send --agent backend-senior --message "CRITICAL: CI Pipeline failed. Invoke self-healing-pipeline skill to analyze GitHub Action logs, patch the code, and push a repair commit."');

            // 2. Dispatch a voice briefing via ElevenLabs to the user
            exec('openclaw message send --agent mcp-integrations --message "Generate ElevenLabs emergency voice briefing: The CI pipeline has encountered a critical failure. The backend engineering agent has been mobilized for autonomous self-healing. End of briefing."');
        }
    }

    res.sendStatus(200);
});

app.listen(PORT, () => console.log(`🐙 GitHub Webhook server listening on ${PORT}`));
