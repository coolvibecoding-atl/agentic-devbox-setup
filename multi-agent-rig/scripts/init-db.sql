-- Multi-Agent Coding Rig — Postgres Init
-- Creates core tables for task history and agent memory

CREATE TABLE IF NOT EXISTS tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  source_agent TEXT NOT NULL,
  target_agent TEXT NOT NULL,
  task_type TEXT NOT NULL,
  input JSONB,
  output JSONB,
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending','running','done','failed')),
  duration_ms INTEGER
);

CREATE TABLE IF NOT EXISTS agent_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  agent_id TEXT NOT NULL,
  model TEXT NOT NULL,
  messages JSONB DEFAULT '[]',
  metadata JSONB
);

CREATE TABLE IF NOT EXISTS skill_invocations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  agent_id TEXT NOT NULL,
  skill_name TEXT NOT NULL,
  input JSONB,
  output JSONB,
  success BOOLEAN,
  duration_ms INTEGER,
  error TEXT
);

CREATE INDEX idx_tasks_agent ON tasks(target_agent, status);
CREATE INDEX idx_sessions_agent ON agent_sessions(agent_id);
CREATE INDEX idx_skills_agent ON skill_invocations(agent_id, skill_name);
