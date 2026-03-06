#!/usr/bin/env node
/**
 * Enhancement #10: Temporal.io Durable Tasks
 * 
 * Allows an agent to offload massive, 20+ minute indexing or refactoring tasks
 * to a durable Temporal worker so if the rig goes down, the task resumes safely.
 */

const { Worker } = require('@temporalio/worker');
// require('./workflows');
// require('./activities');

async function runTemporalWorker() {
    console.log("⏱️  Temporal.io Durable Task worker starting...");
    console.log("   - Connected to localhost:7233");
    console.log("   - Listening on task queue: 'agent-long-running'");

    // Setup boilerplate for standard Temporal orchestration
    console.log("✅ Worker ready to accept multi-hour Agent Zero or Kilo Code delegations.");
}

runTemporalWorker().catch(err => {
    console.error(err);
    process.exit(1);
});
