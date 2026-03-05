# 🦞 OpenClaw v2026.3.2: Features & Integration Guide

OpenClaw has just released multiple massive updates in early 2026, making it the premier gateway for autonomous local agents. Below is everything you need to know about the new features and exactly how to hook up your Telegram bot to the MiniMax AI model.

---

## ✨ New Features as of March 2026

1.  **Native PDF Analysis (v2026.3.2):** OpenClaw now includes a native OCR/PDF extraction tool to process huge document sets locally before feeding summaries to the LLM.
2.  **External Secrets Management:** The new `SecretRef` system completely eliminates plaintext API keys from your config. Keys are now injected dynamically at runtime via the `openclaw secrets` command.
3.  **New STT (Speech-to-Text) API:** Agents can now transcribe audio files directly through the gateway.
4.  **Telegram Message Streaming:** Telegram integration now supports "partial" mode for real-time typing previews (like ChatGPT) directly in your chat.
5.  **MiniMax-M2.5-highspeed Support:** The provider directory now officially supports the blazing fast MiniMax M2.5 models, perfect for rapid reasoning and tool use.
6.  **Ollama Embeddings:** You can now use local embeddings (like `nomic-embed-text`) for your agent's long-term memory, completely privacy-preserving.

---

## 🚀 Setting up MiniMax + Telegram Integration

Since API keys and Bot Tokens are highly sensitive, you should run these configuration commands yourself inside your terminal.

### Step 1: Set your AI Provider to MiniMax M2.5
We will configure OpenClaw to default to the MiniMax provider.
```bash
# 1. Run the interactive config to set your API Key securely
openclaw configure

# (When prompted, select "minimax" as your provider and paste your MiniMax API Key)
```

### Step 2: Create a Telegram Bot
1.  Open the **Telegram** app and search for `@BotFather`.
2.  Send the command `/newbot` and follow the prompts to name your agent.
3.  BotFather will give you a **HTTP API Token** (e.g., `123456789:ABCdefGHIjklMNOpqrSTUvwxYZ`). Copy this token.

### Step 3: Link Telegram to OpenClaw
OpenClaw makes channel integration incredibly easy. Just run:
```bash
openclaw channels login --channel telegram
```
*It will prompt you for the Bot Token you just copied from BotFather.*

### Step 4: Start the Gateway
Once configured, simply start the OpenClaw gateway daemon in the background:
```bash
openclaw gateway
```
*Your Telegram bot is now alive! Send it a message from your phone, and the MiniMax AI model will respond and execute local terminal commands on your Mac.*

---

## 🤝 Sharing the Bot with Partners

You can share your bot with business partners while keeping your personal accounts and credentials completely private.

### 1. Share the Handle
Send your partner your bot's username (e.g., `@YourBotName`).

### 2. Partner Initiation
When your partner starts a chat with the bot, the bot will detect they are unauthorized and reply with a **Pairing Code**. They should copy this code and send it to you.

### 3. Owner Approval
On **your** machine (where the gateway is running), run the following command to grant them access:
```bash
openclaw pairing approve telegram <CODE_THEY_SENT_YOU>
```

Your partner will now be able to use the agentic power of your dev box directly from their own Telegram account! You can see all active users anytime by running `openclaw status`.
