# Your OpenClaw — Welcome Experience
# Real ./shell → banner → onboard peek → gateway → detach
# Run: vhs demos/welcome.tape

Output demos/welcome.gif

Set Shell "bash"
Set FontSize 16
Set Width 1000
Set Height 600
Set Theme "Catppuccin Mocha"
Set WindowBar Colorful
Set WindowBarSize 40
Set TypingSpeed 40ms
Set Padding 20
Set BorderRadius 8
Set PlaybackSpeed 0.75

# Launch
Type "./shell"
Sleep 500ms
Enter
Sleep 6s

# Onboard — wait 50s for security warning to fully render
Type "openclaw onboard"
Sleep 300ms
Enter
Sleep 50s

# Agree to security warning
Type "y"
Enter
Sleep 1s

# Cancel — we've shown the flow
Ctrl+C
Sleep 4s

# Start gateway
Type "openclaw gateway --verbose"
Sleep 300ms
Enter
Sleep 5s

# Detach — gateway keeps running
Ctrl+P
Ctrl+Q
Sleep 2s
