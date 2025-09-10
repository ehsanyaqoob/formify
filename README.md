# README — How to install & run the app on macOS (for running on iPhone)
---

## Summary (what this guide does)

* Install the required tools (Homebrew, Flutter SDK, Xcode, CocoaPods).
* Prepare the Flutter project for iOS (dependencies, pods, signing).
* Connect and enable an iPhone for testing (Developer Mode, trust computer).
* Build & run the app from terminal (`flutter run`) or Xcode.

---

## Quick checklist (at-a-glance)

* [ ] macOS machine with Internet access
* [ ] Apple ID (for signing; a personal Apple ID works for development)
* [ ] Xcode installed from the App Store
* [ ] USB cable (for device) or wireless debugging configured

---

## 1. Prepare the Mac (prerequisites)

1. **Install Homebrew** (optional but recommended):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **Install Git** (if not already installed):

```bash
brew install git
```

3. **Install Xcode** from the App Store.

   * After install, run these commands in Terminal to accept license and ensure command-line tools are available:

```bash
sudo xcodebuild -license accept
xcode-select --install
```

4. **Install CocoaPods** (dependency manager for iOS native pods).

   * Recommended (Apple Silicon friendly):

```bash
brew install cocoapods
```

* If you prefer Ruby gem (older guides use this):

```bash
sudo gem install cocoapods
```

---

## 2. Install Flutter SDK

Follow the Flutter official install steps or use the commands below to get the stable channel copy (recommended):

```bash
# create a directory for development tools
mkdir -p ~/development
cd ~/development
# clone the stable channel of flutter
git clone https://github.com/flutter/flutter.git -b stable
# add flutter to PATH for current session
export PATH="$PATH:~/development/flutter/bin"
# to make PATH permanent for zsh (default on modern macOS)
echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

**Verify installation**:

```bash
flutter doctor
```

`flutter doctor` lists missing dependencies and provides next steps. Fix anything it reports before continuing.

---

## 3. Clone this repo and fetch dependencies

1. Clone the project (or use the project folder you already have):

```bash
git https://github.com/ehsanyaqoob/formify/tree/event
```

2. Fetch Dart/Flutter packages:

```bash
flutter pub get
```

3. Install iOS pods:

```bash
cd ios
pod install
cd ..
```

If `pod install` fails on Apple Silicon, make sure CocoaPods was installed with Homebrew. You can also try `arch -x86_64 pod install` as a fallback for problematic environments, but prefer the Homebrew-installed CocoaPods.

---

## 4. Configure iOS signing (required to run on a physical iPhone)

1. Open the iOS workspace in Xcode (always use `xcworkspace` when CocoaPods are used):

```bash
open ios/Runner.xcworkspace
```

2. In Xcode:

   * Select the **Runner** project in the navigator, then the **Runner** target.
   * Under **Signing & Capabilities**:

     * Set a unique **Bundle Identifier** (e.g. `com.yourcompany.appname`).
     * Choose a **Team** (use your manager’s/company Apple Developer account or a personal Apple ID for development).
     * Xcode can manage signing automatically — click **Automatically manage signing** if not already enabled.

> Notes:
>
> * A personal Apple ID allows installing apps on a device for testing, but has limitations compared to a paid Apple Developer Program account.
> * If you have a corporate/team Apple Developer account, use it to avoid provisioning limits.

---

## 5. Prepare the iPhone (connect & enable Developer Mode)

1. Connect the iPhone with USB and **trust** the computer when prompted on the device.
2. If the device is running iOS 16 or later, you might need to **enable Developer Mode** on the device. Usually when you run the app from Xcode or attempt to use the device, iOS will prompt to enable Developer Mode — agree and restart the device when asked.

---

## 6. Run the app

### Option A — From terminal (recommended for quick tests)

1. List available devices:

```bash
flutter devices
```

2. Run the app on the connected iPhone:

```bash
flutter run -d <device-id>
# or just: flutter run (it will pick the connected device if only one is attached)
```

### Option B — From Xcode (useful to fix signing issues)

1. In Xcode, choose the connected device as the run destination (top toolbar selector).
2. Click the Run (▶) button.

> If Xcode prompts to enable Developer Mode or to allow the account to be used on the device, follow the prompts.

---

## 7. Common issues & fixes

* **`flutter doctor` shows missing Xcode or iOS toolchain**: Open Xcode once and accept the license, then re-run `flutter doctor`.
* **`pod install` failing / native build errors on Apple Silicon**:

  * Ensure CocoaPods was installed via Homebrew: `brew install cocoapods`.
  * Try `pod repo update` then `pod install`.
* **Code signing errors (no provisioning profile / no development team)**:

  * Open `ios/Runner.xcworkspace` in Xcode and set the Team in Signing & Capabilities.
  * If automatic signing fails, try cleaning the build folder: `Product > Clean Build Folder` in Xcode.
* **Device not detected**:

  * Make sure the phone is unlocked and you tapped **Trust** on the device.
  * Run `flutter devices` to confirm it’s visible.
* **App builds but crashes on startup**:

  * Check Xcode’s console for stack traces. Use `flutter run -v` to get verbose logs.

---

## 8. Helpful commands (cheat sheet)

```bash
# check flutter environment
flutter doctor -v
# fetch packages
flutter pub get
# install pods
cd ios && pod install && cd ..
# run on a device
flutter run
# build an iOS archive (for distribution via Xcode)
flutter build ipa
```
---

## 9. If something goes wrong

Please copy the **exact** terminal output of the failing command and paste it into a bug report comment or send it to me. Common useful outputs:

* `flutter doctor -v`
* Output of `pod install` (the error block)
* The Xcode build log / console output

---

## 10. Appendix: Recommended environment info to share with support

When asking for help, include these outputs:

```bash
flutter --version
xcodebuild -version
flutter doctor -v
```

Feel free to reach me out on email ehsanyaqoob07@gmail.com.

