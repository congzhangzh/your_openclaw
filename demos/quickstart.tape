# Your OpenClaw — Quickstart Demo
# Records the real ./shell experience + Ctrl+P,Q detach
# Run: vhs demos/quickstart.tape

Output demos/quickstart.gif

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

Type "./shell"
Sleep 500ms
Enter

# Wait for container to build and attach
Sleep 15s

# Show the detach workflow
Type "openclaw gateway --verbose"
Sleep 500ms
Enter
Sleep 3s

# Detach with Ctrl+P, Ctrl+Q — gateway keeps running
Ctrl+P
Ctrl+Q
Sleep 2s
