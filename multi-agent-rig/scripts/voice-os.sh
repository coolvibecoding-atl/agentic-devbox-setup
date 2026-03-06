#!/usr/bin/env bash
# Voice OS J.A.R.V.I.S. Loop (Phase 20)
# Uses Sox to capture audio, Groq Whisper for instant transcription, OpenClaw to process, and ElevenLabs to speak back.

set -e

echo "🎙️ [Voice OS] Initializing J.A.R.V.I.S. Loop..."

if ! command -v sox &> /dev/null; then
    echo "Sox not installed. Run 'brew install sox'"
    exit 1
fi

TEMP_AUDIO="/tmp/voice_command.wav"
echo "🔴 Listening... (Press Ctrl+C to stop recording)"
# Records from default mic until silence is detected
rec -q $TEMP_AUDIO silence 1 0.1 3% 1 2.0 3%

echo "🟢 Transcribing via Whisper..."
# In a real setup, this curls to Groq or local Whisper.cpp endpoint
# STUB: Mock transcription curl
TRANSCRIPTION="Build me a 3D spline wrapper component for the homepage."
echo "[You said]: $TRANSCRIPTION"

echo "🧠 Agent Engine Processing..."
# Sending the command to the Rig manager via OpenClaw
# RESPONSE=$(openclaw message send --agent mcp-integrations --message "$TRANSCRIPTION" --raw)
RESPONSE="Yes sir. Wiring up the Spline MCP and generating the React component now."
echo "[Rig Reply]: $RESPONSE"

echo "🔊 Synthesizing Response (ElevenLabs)..."
# In a real setup, hits the ElevenLabs TTS API and pipes to `play`
# STUB: Using macOS 'say' command as fallback if ElevenLabs is not connected
if command -v say &> /dev/null; then
    say "$RESPONSE"
fi

echo "✅ Cycle Complete."
