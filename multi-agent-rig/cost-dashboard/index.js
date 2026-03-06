const express = require('express');
const app = express();
const PORT = process.env.PORT || 8004;

// Mock data generator for demonstration. In production, this would parse OpenClaw/AgentZero logs or query Postgres.
app.get('/', (req, res) => {
    res.send(`
    <html>
      <head>
        <title>Agent Cost Dashboard</title>
        <style>
          body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; padding: 2rem; background: #0f172a; color: #f8fafc; }
          table { border-collapse: collapse; width: 100%; max-width: 800px; margin-top: 2rem; background: #1e293b; border-radius: 8px; overflow: hidden; }
          th, td { padding: 1rem; text-align: left; border-bottom: 1px solid #334155; }
          th { background: #0f172a; font-weight: 600; color: #94a3b8; }
          tr:hover { background: #334155; }
          .total { font-weight: bold; color: #10b981; }
        </style>
      </head>
      <body>
        <h1>💸 Agent Cost Dashboard</h1>
        <p>Estimated API usage based on session logs.</p>
        <table>
          <tr><th>Agent</th><th>Configured Model</th><th>Estimated Cost ($)</th></tr>
          <tr><td>backend-senior</td><td>openai/gpt-4o</td><td>1.25</td></tr>
          <tr><td>frontend-lead</td><td>zhipu/glm-4</td><td>0.80</td></tr>
          <tr><td>arch-director</td><td>google/gemini-1.5-pro</td><td>0.50</td></tr>
          <tr><td>qa-guardian</td><td>minimax-portal/MiniMax-M2.5</td><td>0.30</td></tr>
          <tr><td>mcp-integrations</td><td>openai/gpt-4o-mini</td><td>0.15</td></tr>
          <tr><td>docs-narrator</td><td>zhipu/glm-4</td><td>0.20</td></tr>
          <tr><td>ux-creative</td><td>google/gemini-1.5-pro</td><td>0.40</td></tr>
          <tr><td colspan="2" style="text-align: right"><strong>Total:</strong></td><td class="total">$3.60</td></tr>
        </table>
      </body>
    </html>
  `);
});

app.listen(PORT, () => console.log(`📊 Cost Dashboard listening on ${PORT}`));
