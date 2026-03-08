# Your OpenClaw — Onboard Configuration Demo
# Run: vhs demos/onboard.tape

Output demos/onboard.gif

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

Type "openclaw onboard"
Sleep 300ms
Enter

Hide
Type "printf '\\n\\033[1;36m🔧 OpenClaw Setup Wizard\\033[0m\\n'"
Enter
Type "printf '\\033[36m────────────────────────────────────\\033[0m\\n\\n'"
Enter
Type "printf '\\033[33m?\\033[0m Select AI provider: '"
Enter
Show
Sleep 1s

Type "zhipu"
Sleep 200ms
Enter

Hide
Type "printf '\\033[32m✓\\033[0m Provider: zhipu\\n\\n'"
Enter
Type "printf '\\033[33m?\\033[0m API key: '"
Enter
Show
Sleep 600ms

Type "glm-sk-xxxxxxxxxxxxxxxxxxxx"
Sleep 200ms
Enter

Hide
Type "printf '\\033[32m✓\\033[0m API key saved\\n\\n'"
Enter
Type "printf '\\033[33m?\\033[0m Model: '"
Enter
Show
Sleep 600ms

Type "glm-4-plus"
Sleep 200ms
Enter

Hide
Type "printf '\\033[32m✓\\033[0m Model: glm-4-plus\\n'"
Enter
Type "printf '\\033[32m✓\\033[0m Sandbox: enabled\\n\\n'"
Enter
Type "printf '\\033[1;32m✅ Setup complete! Run: openclaw gateway --verbose\\033[0m\\n'"
Enter
Show
Sleep 3s
