# Study Buddy

A small native macOS study assistant with a resizable window, optional always-on-top pin, concise AI replies, course materials, and manual screenshot attachments.

## Build and run

Requires macOS 13+ and Apple Command Line Tools (`xcode-select --install`). No third-party packages.

```sh
./scripts/build.sh
open 'dist/Exam Buddy.app'
```

1. Open Settings (gear) and enter your own OpenAI API key. It is stored in macOS Keychain. The editable default model is `gpt-4.1-mini`; choose a vision-capable model your account can access.
2. Add text-based PDF slides, TXT or Markdown using the paperclip. Export PowerPoint to PDF first. Scanned/image-only PDFs need OCR. Materials are kept in memory; re-add them after quitting.
3. Ask a question and click the arrow or press Command–Return. Brief replies target 100 words. Study explains; Practice starts with a hint.
4. Click Capture and drag a region of your screen. Escape cancels. Review the preview, then send or remove it. macOS may require Screen Recording permission and an app restart.
5. Use the pin icon to keep the window above ordinary windows. It does not bypass fullscreen apps or protected exam software.
6. For an explicitly AI-permitted exam, select Exam and enter the instructor's rules. Answers are prompted to follow those rules. The app does not independently verify permission or guarantee enforcement.

## Data and limits

- This is a separate API app, not a connection to this chat or your ChatGPT account/history. API usage requires separate billing.
- Sending transmits the current question, up to 12 recent text messages, all imported material text, and any pending screenshot to OpenAI over HTTPS. Screenshots are not included again in later turns. No background screen monitoring or automatic uploads.
- Conversation, materials, exam rules, and screenshots remain in memory until quitting. Model choice is stored locally; the API key is stored in Keychain. Capture uses a temporary PNG which is deleted after loading.
- Requests use `store: false`; this does not imply zero retention by the API provider. See OpenAI's data controls.
- Each imported file must be under 20 MB; total extracted text is limited to 100,000 characters. No silent truncation. Materials are sent on every request, which can increase cost.
- No live web search, microphone/voice conversation, OCR of imported PDFs, persistent library, or remote-phone control in this version. macOS dictation can be used in the text field.
- Capture and generated answers can contain mistakes. Review the selected region and verify answers.

## Development

`Sources/ExamBuddy/main.swift` contains the SwiftUI app, Keychain storage, PDF extraction, screenshot picker, and URLSession Responses API client. `scripts/build.sh` compiles a local, ad-hoc signed app bundle. Distribution to other computers would require signing and notarization.

API reference: https://developers.openai.com/api/docs/guides/images-vision
