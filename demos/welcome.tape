# Your OpenClaw — Full Welcome Experience
# Real ./shell + real openclaw onboard (overview, then Ctrl+C) + gateway
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

# Step 1: Launch ./shell
Type "./shell"
Sleep 500ms
Enter
Sleep 15s

# Step 2: Run real openclaw onboard — just show a quick overview
Type "openclaw onboard"
Sleep 300ms
Enter
Sleep 5s

# "I understand this is powerful..." → Yes
Enter
Sleep 4s

# QuickStart mode → Enter (default)
Enter
Sleep 4s

# Model/auth provider → navigate down to MiniMax
Down 5
Sleep 1s
Enter
Sleep 4s

# Show the auth method menu briefly, then cancel
# We've shown enough of the flow — Ctrl+C to exit
Sleep 2s
Ctrl+C
Sleep 2s

# Step 3: Start gateway
Type "openclaw gateway --verbose"
Sleep 300ms
Enter
Sleep 5s

# Step 4: Ctrl+P, Ctrl+Q to detach
Ctrl+P
Ctrl+Q
Sleep 2s
