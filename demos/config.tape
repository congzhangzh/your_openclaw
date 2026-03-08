# Your OpenClaw — Config Management Demo
# Run: vhs demos/config.tape

Output demos/config.gif

Set Shell "bash"
Set FontSize 16
Set Width 1000
Set Height 520
Set Theme "Catppuccin Mocha"
Set WindowBar Colorful
Set WindowBarSize 40
Set TypingSpeed 40ms
Set Padding 20
Set BorderRadius 8

Hide
Type "PS1='openclaw:/$ '"
Enter
Show
Sleep 300ms

Type "openclaw config get"
Sleep 300ms
Enter

Hide
Type "printf '\\033[1magents:\\033[0m\\n'"
Enter
Type "printf '  defaults:\\n'"
Enter
Type "printf '    model: \\033[32mzhipu/glm-4-plus\\033[0m\\n'"
Enter
Type "printf '  sandbox: \\033[32mtrue\\033[0m\\n'"
Enter
Type "printf '\\033[1mchannels:\\033[0m\\n'"
Enter
Type "printf '  telegram:\\n'"
Enter
Type "printf '    enabled: \\033[32mtrue\\033[0m\\n'"
Enter
Type "printf '    botToken: \\033[2m7012****xxxx\\033[0m\\n'"
Enter
Type "printf '\\033[1mgateway:\\033[0m\\n'"
Enter
Type "printf '  port: \\033[33m18789\\033[0m\\n'"
Enter
Show
Sleep 2s

Type@50ms "openclaw config set agents.defaults.model 'anthropic/claude-sonnet-4'"
Sleep 300ms
Enter

Hide
Type "printf '\\033[32m✓\\033[0m agents.defaults.model → anthropic/claude-sonnet-4\\n'"
Enter
Show
Sleep 2s

Type "openclaw status"
Sleep 300ms
Enter

Hide
Type "printf '\\n\\033[1;32m⚡ Gateway:\\033[0m running on :18789\\n'"
Enter
Type "printf '\\033[1m   Model:\\033[0m   anthropic/claude-sonnet-4\\n'"
Enter
Type "printf '\\033[1m   Uptime:\\033[0m  2h 14m\\n'"
Enter
Type "printf '\\033[1m   Memory:\\033[0m  127 MB\\n'"
Enter
Show
Sleep 3s
