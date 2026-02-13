# Your OpenClaw

**你的 AI。你的服务器。你说了算。**

---

## 哲学

1. **简单就是美。** 电脑是用来用的，不是用来供的。

2. **透明胜过精简。** Dockerfile 里的每一步都是因为你将来会用到。我们不会为了省 50 MB 把工具砍掉——你的 VPS 有 40 GB 硬盘，省这点没意义。

3. **做对，而不只是做完。** Tini 做 PID 1、UTF-8 显示二维码、BuildKit 加速构建。这些不是锦上添花——它们是「能跑」和「跑得漂亮」的区别。

4. **你的数据，你的磁盘。** `~/.openclaw` 就在宿主机上。你可以 `ls`、`cp`、`rsync` 到另一台服务器。没有黑箱，没有只能 Docker 访问的魔法卷。

5. **安全是分层的。** Docker 隔离 → Tini 信号转发 → OpenClaw 沙箱 → Token 认证 → 设备审批 → 磁盘加密。每一层独立可验证。

6. **开源&中国优先。** GLM-5, MiniMax M2.5(Waiting), Lark

---

## 从零到跑起来 — 8 步搞定

| # | 目标 | 命令 | 发生了什么 |
|---|------|------|-----------|
| 1 | **拿到代码** | `git clone https://github.com/congzhangzh/your_openclaw.git && cd your_openclaw` | 部署文件到位 |
| 2 | **配置 Docker** | `cp .env.example .env` | 端口和数据路径已配置（这里不涉及密钥） |
| 3 | **配置 OpenClaw** | `docker compose run --rm openclaw bash setup.sh` | 命令行引导式配置：模型、Telegram、沙箱。每步可验证。 |
| 4 | **选择模型** | `openclaw config set agents.defaults.model "anthropic/claude-opus-4-5-20250514"` | 也可以选 MiniMax、GLM、Claude Code、Antigravity Opus 4.6——你决定。 |
| 5 | **连接渠道** | `openclaw config set channels.telegram.enabled true` | Telegram、WhatsApp、Slack、Discord、Signal……先选一个。 |
| 6 | **启动** | `docker compose up -d` | 网关 24/7 运行，Tini 做 PID 1。 |
| 7 | **验证** | 打开 `http://localhost:18789` | 面板上线。审批你的设备。开始聊天。 |

**就这么多。** 现在你有了一个自托管的 AI 助手，运行在你自己的基础设施上，数据在你的磁盘上，沙箱执行保安全，信号处理保稳定。

继续往下读了解细节，或者直接跑完 8 步，好奇的时候再回来看。

---

## 快速开始（详细版）

上面的 8 步表是概览。这里是展开版本。

### 1. 获取

```bash
git clone https://github.com/congzhangzh/your_openclaw.git
cd your_openclaw
cp .env.example .env        # 需要的话编辑一下（端口、数据路径）
```

### 2. 配置

```bash
docker compose run --rm openclaw bash setup.sh
```

也可以手动配置——下面记录了每条 `openclaw config set` 命令。

**确认：**
```bash
openclaw config get
```

### 3. 启动

```bash
# 先退出配置容器，然后：
docker compose up -d
```

**确认：**
```bash
docker compose logs -f          # 观察启动过程
docker attach openclaw          # 挂载到实时输出
# Ctrl+P, Ctrl+Q 分离（容器继续运行）
```

你的 AI 现在在 **http://localhost:18789** 上线了。

---

## 为什么要用 Tini？

每个容器都需要一个合格的 PID 1。大多数 Dockerfile 跳过了这一步。我们没有。

**问题一：** Docker 发送 `SIGTERM`（通过 `docker stop`）时，PID 1 必须将信号转发给子进程。裸 `bash` 或 `node` 做 PID 1 不会这样做——Docker 等 10 秒，放弃，发送 `SIGKILL`。你的网关没有机会保存状态或关闭连接。

**问题二：** 长时间运行的进程可能产生子进程。子进程退出后变成僵尸进程。没有 init 系统，僵尸进程会累积。在 24/7 容器中，这很重要。

**Tini 两个都解决了：**
- 将 `SIGTERM`/`SIGINT` 转发给所有子进程 → `docker stop` 在 1 秒内完成
- 自动回收僵尸进程 → 运行数周也不会累积
- 镜像仅增加 ~30 KB。零配置。零开销。

```
ENTRYPOINT ["tini", "--", "/entrypoint.sh"]
```

这才是生产容器应有的样子。如果别人的 Dockerfile 没有 init，问他们为什么。

---

## 容器管理

网关作为容器主进程直接运行。没有包装层，没有多路复用器。用 Docker 原生工具即可：

| 操作 | 命令 |
|------|------|
| 查看日志 | `docker logs -f openclaw` |
| 挂载到输出 | `docker attach openclaw` |
| 分离 | `Ctrl+P, Ctrl+Q` |
| 打开 Shell | `docker exec -it openclaw bash` |
| 重启网关 | `docker compose restart openclaw` |

---

## 模型推荐 (我还在学习)

OpenClaw 不绑定模型。选适合你场景的：

### 旗舰推理
| 模型 | 提供商 | 优势 |
|------|--------|------|
| `anthropic/claude-opus-4.6` | Anthropic | 深度推理，细致分析 |
| `google-antigravity/opus-4.6` | Google | 多模态 + 推理强者 |

### 代码专家
| 模型 | 提供商 | 优势 |
|------|--------|------|
| `anthropic/claude-code` | Anthropic | 天生写代码。读、写、调试。 |

### 性价比 / 中文优化
| 模型 | 提供商 | 优势 |
|------|--------|------|
| `minimax/latest` | MiniMax | 高性价比，中文优秀 |
| `zhipu/glm-4-plus` | 智谱 AI | 长上下文，工具调用能力强 |

**设置默认模型：**
```bash
openclaw config set agents.defaults.model "anthropic/claude-opus-4.6"
```

**验证：**
```bash
openclaw config get agents.defaults.model
```

**进阶技巧：** 不同 agent 可以用不同模型。个人助手用 Opus，家人机器人用 MiniMax：
```bash
# 在 config 的 agents.list 中：
# { "id": "family", "model": "minimax/latest" }
```

---

## 渠道配置

### Telegram

**目标：** 通过 Telegram 和你的 AI 聊天。

**第一步 — 创建机器人：**
1. 打开 Telegram，搜索 `@BotFather`
2. 发送 `/start`，然后 `/newbot`
3. 按提示操作，复制 bot token

**第二步 — 配置：**
```bash
openclaw config set channels.telegram.enabled true
openclaw config set channels.telegram.botToken "YOUR_BOT_TOKEN"
```

**第三步 — 重启网关：**
```bash
docker compose restart openclaw
```

**第四步 — 配对：**
1. 在 Telegram 打开你的机器人，点击 **Start**
2. 出现配对码
3. 审批：
```bash
openclaw pairing approve telegram <PAIRING_CODE>
```

**确认：**
```bash
openclaw devices list   # 应该能看到你的 Telegram 机器人已审批
```


### 飞书 / Lark（即将支持）

> OpenClaw 目前还没有原生的飞书/Lark 支持。我们在跟进，会在可用时添加 webhook 桥接方案。欢迎贡献！

---

## Canvas 与浏览器

OpenClaw 可以帮你浏览网页。实时观看：

**Canvas UI：** `http://localhost:18789/__openclaw__/canvas/`


## 远程访问（SSH 隧道）

在 VPS 上运行？安全访问你的网关：

```bash
# 从你的本地机器：
ssh -N -L 18789:127.0.0.1:18789 user@your-vps-ip
```
然后在本地打开 `http://localhost:18789`。

---

## 常用操作

```bash
# 更新 OpenClaw 到最新版
docker compose exec openclaw bash -c 'source $HOME/.nvm/nvm.sh && npm install -g openclaw@latest'
docker compose restart openclaw

# 查看网关日志
docker compose logs -f

# 审批待处理的设备
docker exec -it openclaw bash -c 'source $HOME/.nvm/nvm.sh && openclaw devices list'
docker exec -it openclaw bash -c 'source $HOME/.nvm/nvm.sh && openclaw devices approve <request-id>'

# 发送测试消息
docker exec -it openclaw bash -c 'source $HOME/.nvm/nvm.sh && openclaw message send --to +1234567890 --message "Hello from OpenClaw"'

# 直接和助手对话
docker exec -it openclaw bash -c 'source $HOME/.nvm/nvm.sh && openclaw agent --message "Ship checklist" --thinking high'

# 完整配置导出
docker exec -it openclaw bash -c 'source $HOME/.nvm/nvm.sh && openclaw config get'

# 从头重建
docker compose down
docker compose build --no-cache
docker compose up -d
```

---

## VPS 磁盘加密+压缩文件系统

你的 AI 数据值得保护。我们推荐在 VPS 部署中使用加密 + 压缩的文件系统。

### 方案 A：LVM (LUKS) + btrfs with 压缩（推荐）
### 方案 B：ZFS on Root(原生加密，但是慎用)

---

## 推荐 VPS 提供商

用入门的已经绰绰有余，这就是我觉得他们不错的原因；特别是Hetzner, 10GB网络(1G没问题，10GB只能突发)，可以随时取消。

### Hetzner Cloud

坚如磐石的欧洲基础设施。出色的性价比。他们的 ARM 实例对于持续运行的工作负载便宜得令人发指。

- **推荐：** CX22（2 vCPU，4 GB RAM，40 GB）——OpenClaw 绰绰有余
- **地点：** Falkenstein 或 Helsinki，欧洲低延迟
- **我们喜欢它的原因：** 性能稳定，账单没有惊喜，API 好用

[**开始使用 Hetzner Cloud**](https://hetzner.cloud/?ref=QuqTJEEjeiIf)

### Servarica

加拿大提供商，在大容量 VPS 上性价比出乎意料地高。适合需要更多磁盘空间存放 AI 工作空间和日志的用户。

- **推荐：** 任何 4 GB RAM 方案
- **我们喜欢它的原因：** 存储给力，网络稳定，适合北美

[**开始使用 Servarica**](https://clients.servarica.com/aff.php?aff=1238)

---

## 项目结构

```
your_openclaw/
├── Dockerfile          # 每一步都可见。每个工具都有意。
├── docker-compose.yml  # 精确控制。没有魔法。
├── entrypoint.sh       # 网关启动器。简单直接。
├── setup.sh            # 命令行驱动配置。目标 → 命令 → 验证。
├── .env.example        # 仅 Docker 配置。没有密钥。
├── README.md           # 英文版。
└── README.zh-CN.md     # 你在这里。
```

---

## 参考:
1. https://huggingface.co/zai-org
2. https://huggingface.co/MiniMaxAI
3. https://www.larksuite.com/

---

## 许可证

MIT

---

*用心构建，放心部署。你的 AI，你做主。*
