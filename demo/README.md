# ANIMOOO - Interactive React Showcase Demo

This folder contains a standalone, fully interactive React + TypeScript + Vite demo of the **AnimoApp** Flutter mobile application.

The demo reconstructs the Flutter application's UI, design system, data models, and user flows with pixel-level fidelity inside an **iPhone 16 Pro shell** with a side simulator panel.

## Features
- **Phone Shell:** Dynamic Island, iOS 17 status bar, hardware buttons, home indicator, color variants (Midnight, Titanium, Starlight, Deep Purple), and scaling controls.
- **Push Notification Simulator:** Test realistic push notifications derived from app logic ("New Animal Listed", "OTP Code", "Category Updated", "Password Changed") and custom notifications.
- **Interactive Deep Links & Routes:**
  - `HomeFeed` (`/`): Horizontal categories with badge counts, rich animal cards, like/share actions.
  - `Categories` (`/SeeAll`): Grid view of all pet categories with live search filtering.
  - `CategoryScreen` (Tab 2): Create & edit categories with character validation (>12, >100) and photo upload.
  - `AnimalScreen` (Tab 3): Create & edit animal listings with category choice chips and pricing.
  - `Login` (`/Login`): Credential validation, show/hide password toggle, remember me.
  - `Sign Up` (`/register`): Complete registration with live 5-rule password security checklist and photo upload.
  - `Forgot Password` (`/forgetpassword`): Email recovery flow triggering verification code.
  - `OTP Verification` (`/optverivication`): 4-digit auto-advancing boxes with 60-second resend countdown.
  - `Create New Password` (`/ConfirmPassword`): Password criteria and matching confirmation.
- **Simulated Hardware:** Native photo picker (Camera/Gallery modal bottom sheet), QuickAlert dialogs, and bottom docked snackbars.
- **Zero Backend / Offline:** Pure in-memory reactive store; no external server or Flutter Web runtime required.

## Quick Start

### Development Mode
```bash
npm install
npm run dev
```

### Production Build & Preview
```bash
npm run build
npm run preview
# or run the helper script:
bash serve.sh
```

### Hosting Options
The output in `dist/` is 100% static HTML, CSS, and JavaScript. You can deploy it to:
- **Firebase Hosting:** `firebase deploy --only hosting`
- **GitHub Pages:** Deploy `demo/dist/` branch or GitHub Actions
- **Vercel / Netlify:** Build command: `npm run build`, Publish directory: `dist`
- **Any static web server:** e.g., `npx serve dist` or `python -m http.server 8080`
