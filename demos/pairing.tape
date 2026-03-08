# Your OpenClaw — Channel & Device Pairing Demo
# Run: vhs demos/pairing.tape

Output demos/pairing.gif

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

Type@50ms "openclaw channel add telegram --botToken 7012345678:AAHxxxxxxxxxx"
Sleep 300ms
Enter

Hide
Type "printf '\\033[32m✓\\033[0m Channel added: telegram\\n'"
Enter
Type "printf '\\033[2mRestart gateway to activate.\\033[0m\\n'"
Enter
Show
Sleep 1.5s

Type "openclaw devices list"
Sleep 300ms
Enter

Hide
Type "printf '\\n\\033[1mPending Devices\\033[0m\\n'"
Enter
Type "printf '\\033[36m────────────────────────────────────\\033[0m\\n'"
Enter
Type "printf '  ID       Channel    User\\n'"
Enter
Type "printf '  abc123   telegram   @congzhang\\n'"
Enter
Type "echo ''"
Enter
Show
Sleep 2s

Type "openclaw devices approve abc123"
Sleep 300ms
Enter

Hide
Type "printf '\\033[32m✓\\033[0m Device abc123 approved (@congzhang via telegram)\\n'"
Enter
Show
Sleep 1.5s

Type "openclaw devices list"
Sleep 300ms
Enter

Hide
Type "printf '\\n\\033[1mApproved Devices\\033[0m\\n'"
Enter
Type "printf '\\033[36m────────────────────────────────────\\033[0m\\n'"
Enter
Type "printf '  ID       Channel    User         Status\\n'"
Enter
Type "printf '  abc123   telegram   @congzhang   \\033[32m● active\\033[0m\\n'"
Enter
Show
Sleep 3s
