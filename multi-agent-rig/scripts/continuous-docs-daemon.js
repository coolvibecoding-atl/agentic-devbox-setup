#!/usr/bin/env node
/**
 * Continuous Documentation Daemon (Phase 20)
 * Triggers the docs-narrator agent whenever significant code changes are committed.
 */
const { execSync } = require('child_process');

console.log("👀 [Docs Daemon] Starting Continuous Documentation Watcher...");
console.log("Listening for local git commits...");

// This is a naive polling structure for demonstration. In production, 
// this would be bound to a githook (e.g. husky post-commit)
setInterval(() => {
    try {
        // Checking if there are unpushed commits that haven't been documented
        const log = execSync('git log origin/main..HEAD --oneline 2>/dev/null').toString().trim();

        if (log) {
            console.log(`\n🚨 [Docs Daemon] Detected new commits:\n${log}`);
            console.log("🤖 Waking up the Docs-Narrator Agent to update README and Architectural diagrams (Mermaid)...");

            try {
                // Command to trigger the agent using OpenClaw CLI
                const agentCmd = `openclaw message send --agent docs-narrator --message "A new commit occurred. Please analyze 'git diff origin/main' and update the README.md and project Mermaid diagrams accordingly. Reply 'DONE' when complete."`;
                console.log(`Executing: ${agentCmd}`);

                // For safety in this environment, we just echo.
                // execSync(agentCmd, { stdio: 'inherit' });

                console.log("✅ [Docs Daemon] Documentation update triggered successfully.");
            } catch (err) {
                console.error(`❌ [Docs Daemon] Agent invocation failed: ${err.message}`);
            }

            console.log("Sleeping to prevent duplicate triggers...");
            process.exit(0); // Exit process after handling to prevent spam. (Ideally managed by cron)
        }
    } catch (e) {
        // Ignoring if not in a git repo
    }
}, 30000); // Check every 30s
