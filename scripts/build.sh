#!/bin/zsh
set -euo pipefail
cd "${0:A:h}/.."
mkdir -p .build/release .build/module-cache
swiftc -O Sources/ExamBuddy/main.swift -o .build/release/ExamBuddy -module-cache-path .build/module-cache -target "$(uname -m)-apple-macosx13.0"
APP="dist/Exam Buddy.app"
mkdir -p "$APP/Contents/MacOS"
cp .build/release/ExamBuddy "$APP/Contents/MacOS/ExamBuddy"
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>ExamBuddy</string>
<key>CFBundleIdentifier</key><string>local.exambuddy.desktop</string>
<key>CFBundleName</key><string>Exam Buddy</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.1.0</string>
<key>CFBundleVersion</key><string>1</string>
<key>LSMinimumSystemVersion</key><string>13.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
codesign --force --sign - "$APP"
print "Built $APP"
