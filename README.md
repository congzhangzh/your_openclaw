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

## 🧠 Philosophy

1. **🔒 Safety first.** Docker isolation → Tini signals → OpenClaw sandbox →
   Token auth → Device approval. Layers you can verify.
2. **🎉 Have fun, iterate fast, get your hands dirty.** `./shell` and you're in.
   Break things, fix things, learn things.
3. **✨ Keep it simple.** One command to start. Plain files on disk. No magic.

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

| Demo                          | What it shows                                           |
| ----------------------------- | ------------------------------------------------------- |
| ![Welcome](demos/welcome.gif) | `./shell` → onboard → gateway → `Ctrl+P, Ctrl+Q` detach |

<!-- | ![Quickstart](demos/quickstart.gif) | `./shell` → gateway → `Ctrl+P, Ctrl+Q` detach |
| ![Onboard Ongoing](demos/onboard.gif) | `openclaw onboard` guided configuration       |
| ![Config Ongoing](demos/config.gif)   | `openclaw config get` / `set`                 |
| ![Pairing Ongoing](demos/pairing.gif) | Add Telegram channel → approve device         | -->

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

## 🔐 VPS Disk Encryption + Compression

Your AI data deserves protection. We recommend encrypted + compressed
filesystems for VPS deployments.

### Option A: LVM (LUKS) + Btrfs with Compression (Recommended)

Battle-tested, widely supported. Transparent compression saves disk space on
logs and workspaces.

### Option B: ZFS on Root (Native Encryption — Use with Care)

Powerful but opinionated. See our guide:
[**ZFS on Debian**](https://github.com/congzhangzh/zfs-on-debian)

---

## 🌍 Recommended VPS Providers

Entry-level plans are more than enough for OpenClaw. Here's what we like:

> **Disclosure:** Links below are affiliate links. They help support this
> project at no extra cost to you.

### Hetzner Cloud

Rock-solid European infrastructure. Outstanding price-to-performance.

- **Pick:** CX22 (2 vCPU, 4 GB RAM, 40 GB) — plenty for OpenClaw
- **Location:** Helsinki (Finland) — clean energy, sustainable pricing long-term
- **Why we like it:** Stable performance, no billing surprises, 10 Gbps burst
  networking, cancel anytime

[**→ Get Started with Hetzner Cloud**](https://hetzner.cloud/?ref=QuqTJEEjeiIf)

### Servarica

Canadian provider with surprisingly good value on high-storage VPS plans.

- **Pick:** Any 4 GB RAM plan
- **Why we like it:** Clean IPs, 10 Gbps, generous storage, stable networking,
  Canadian hydroelectric energy = sustainable pricing

[**→ Get Started with Servarica**](https://clients.servarica.com/aff.php?aff=1238)

### Kuroit ⚠️

UK-based provider. Clean IPs. _We haven't used them long — proceed with your own
judgement._

- **Why it's here:** Clean IP reputation, 10 Gbps,competitive pricing
- **Caveat:** Relatively new to us — do your own due diligence

[**→ Get Started with Kuroit**](https://my.kuroit.com/aff.php?aff=447)

---

## 🤖 Recommended AI API Providers

OpenClaw supports multiple AI backends. Here are two we recommend:

> **Disclosure:** Links below are referral links. They help support this project
> at no extra cost to you. **These are ads — just for fun.** 🎉

> **Personal note:** MiniMax has been a great experience for us. We haven't
> tried GLM / 智谱 yet — we'd genuinely love to hear real-world feedback!
>
> 🗳️ **We're also collecting real-world usage reports on Chinese AI models**
> (MiniMax, GLM / 智谱, DeepSeek, Qwen, etc.) — how they perform for coding,
> chat, and daily use. If you have first-hand experience, please share it in the
> [**Discussions**](https://github.com/congzhangzh/your_openclaw/discussions)
> board! Your feedback helps the whole community make better choices. 🙏
>
> 🗳️ **我们也在收集中国 AI 模型的真实使用体验**（MiniMax、智谱 GLM、DeepSeek、
> 通义千问等）—— 编程、对话、日常使用效果如何？欢迎到
> [**讨论区**](https://github.com/congzhangzh/your_openclaw/discussions)
> 分享你的实际感受，帮助社区做出更好的选择！🙏

### MiniMax

High-quality AI models with excellent coding support.

🌍 **International:**

🎁 MiniMax Coding Plan New Year Mega Offer! Invite friends and earn rewards for
both! Exclusive **10% OFF** for friends. Ready-to-use API vouchers for you!

[**→ Get Started with MiniMax (International)**](https://platform.minimax.io/subscribe/coding-plan?code=IYLFo6qc8r&source=link)

🇨🇳 **中国大陆：**

🎁 MiniMax 跨年福利来袭！邀好友享 Coding Plan 双重好礼，助力开发体验！ 好友立享
**9折** 专属优惠 + Builder 权益，你赢返利 + 社区特权！

[**→ 立即参与 MiniMax (中国)**](https://platform.minimaxi.com/subscribe/coding-plan?code=8ySx8SRNns&source=link)

### GLM / 智谱

Full support for Claude Code, Cline, and 20+ top coding tools — starting at just
$10/month.

🌍 **International:**

🚀 You've been invited to join the GLM Coding Plan! Enjoy full support for
Claude Code, Cline, and 20+ top coding tools. Subscribe now and grab the
limited-time deal!

[**→ Get Started with GLM (International)**](https://z.ai/subscribe?ic=OPZVLGQQTH)

🇨🇳 **中国大陆：**

🚀 速来拼好模，智谱 GLM Coding 超值订阅，邀你一起薅羊毛！Claude Code、Cline 等
20+ 大编程工具无缝支持，"码力"全开，越拼越爽！立即开拼，享限时惊喜价！

[**→ 立即参与智谱 GLM (中国)**](https://www.bigmodel.cn/glm-coding?ic=2YBOSDW8RP)

---

## 🔗 References

- [OpenClaw](https://github.com/nicepkg/openclaw) — the AI gateway
- [MiniMax × OpenClaw](https://platform.minimax.io/docs/coding-plan/openclaw) —
  MiniMax integration guide
- [ZAI Models (HuggingFace)](https://huggingface.co/zai-org)
- [MiniMax (HuggingFace)](https://huggingface.co/MiniMaxAI)
- [Lark / 飞书](https://www.larksuite.com/)

---

## 📄 License

MIT

---

<p align="center"><sub>Built with care. Deploy with confidence. <b>Your AI, your rules.</b></sub></p>
