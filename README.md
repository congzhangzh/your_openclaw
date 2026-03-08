<h1 align="center">Your OpenClaw</h1>

<p align="center">
  <b>Self-host OpenClaw in one command. Own your AI.</b><br/>
  <sub>一条命令自托管 OpenClaw。你的 AI，你做主。</sub>
</p>

<p align="center">
  <img src="demos/welcome.gif" alt="Welcome Demo" width="720"/>
</p>

<p align="center">
  <a href="#-quickstart">Quickstart</a> •
  <a href="#-demos">Demos</a> •
  <a href="#-whats-inside">What's Inside</a> •
  <a href="#-philosophy">Philosophy</a>
</p>

---

## ⚡ Quickstart

```bash
git clone https://github.com/congzhangzh/your_openclaw.git && cd your_openclaw
cp .env.example .env    # optional: tweak port / data path
./shell                 # builds, starts, attaches — done.
```

That's it. You're inside an OpenClaw container with everything pre-installed.\
The welcome screen tells you what to do next:

```bash
openclaw onboard              # first time: guided setup (API keys, model, channels)
openclaw gateway --verbose    # start the AI gateway
# Ctrl+P, Ctrl+Q             # detach — gateway keeps running in background
```

> **Come back anytime** — `docker attach openclaw` to re-attach.\
> **Data lives on your disk** — `~/.openclaw` is bind-mounted from the host.
> `ls`, `cp`, `rsync` — no black-box volumes.

---

## 🎬 Demos

> **Generate these GIFs:** run `vhs demos/<name>.tape` on a machine with Docker.

| Demo                                | What it shows                                 |
| ----------------------------------- | --------------------------------------------- |
| ![Quickstart](demos/quickstart.gif) | `./shell` → gateway → `Ctrl+P, Ctrl+Q` detach |
| ![Onboard](demos/onboard.gif)       | `openclaw onboard` guided configuration       |
| ![Config](demos/config.gif)         | `openclaw config get` / `set`                 |
| ![Pairing](demos/pairing.gif)       | Add Telegram channel → approve device         |

---

## 📦 What's Inside

```
your_openclaw/
├── shell               ← one-command entry point (build + start + attach)
├── Dockerfile          ← Debian Trixie · Tini · Node 24 · OpenClaw
├── docker-compose.yml  ← ports, volumes, health check
├── .env.example        ← Docker-level config only (no secrets)
└── demos/              ← VHS tape files + generated GIFs
```

| Layer       | Detail                                                                                      |
| ----------- | ------------------------------------------------------------------------------------------- |
| **Base**    | `debian:trixie` — stable, full toolchain                                                    |
| **Init**    | [Tini](https://github.com/krallin/tini) as PID 1 — proper signal forwarding, zombie reaping |
| **Runtime** | Node 24 via NVM, `openclaw@latest`                                                          |
| **Tools**   | `btop` `nload` `iftop` `screen` `git` `curl` `iproute2` — monitor everything                |
| **Data**    | `~/.openclaw` on host ↔ `/root/.openclaw` in container                                      |

---

## 🔧 Inside the Container

`./shell` prints a cheat sheet on start. Here's the full reference:

### Setup

```bash
openclaw onboard                              # interactive guided setup
openclaw gateway --port 18789 --verbose       # start gateway (24/7)
```

### Channels & Devices

```bash
openclaw channel add telegram --botToken <token>
openclaw devices list
openclaw devices approve <request-id>
```

### Day-to-day

```bash
openclaw config get                # full config dump
openclaw config set <key> <value>  # change any setting
openclaw status                    # gateway health
openclaw logs                     # tail logs
openclaw version                  # current version
openclaw help                     # all commands
```

### Container management

```bash
docker attach openclaw             # attach to running gateway
# Ctrl+P, Ctrl+Q                  # detach (container keeps running)
docker exec -it openclaw bash      # open a second shell
docker logs -f openclaw            # stream logs from outside
```

### Update OpenClaw

```bash
docker exec -it openclaw npm install -g openclaw@latest
docker compose restart openclaw
```

---

## 🧠 Philosophy

1. **One command to start.** `./shell` does everything. No 7-step guides.
2. **Transparent, not minimal.** Every Dockerfile line is there because you'll
   need it. We don't strip tools to save 50 MB on a 40 GB disk.
3. **Your data, your disk.** `~/.openclaw` is a plain directory on the host. No
   black-box volumes.
4. **Security in layers.** Docker isolation → Tini signals → OpenClaw sandbox →
   Token auth → Device approval.
5. **Open source & China-friendly.** GLM · MiniMax · Lark — first-class support.

---

## 🔗 References

- [OpenClaw](https://github.com/nicepkg/openclaw) — the AI gateway
- [ZAI Models (HuggingFace)](https://huggingface.co/zai-org)
- [MiniMax (HuggingFace)](https://huggingface.co/MiniMaxAI)
- [Lark / 飞书](https://www.larksuite.com/)

---

## 📄 License

MIT

---

<p align="center"><sub>Built with care. Deploy with confidence. <b>Your AI, your rules.</b></sub></p>
