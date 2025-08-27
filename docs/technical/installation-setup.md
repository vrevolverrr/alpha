# 📱 Installation & Setup

## Prerequisites

- **macOS**: Required for iOS development
- **Xcode**: Latest version for iOS compilation
- **Flutter**: Version compatible with Dart SDK >=3.3.1 <4.0.0
- **iOS Simulator or Device**: For testing and gameplay

## Installation Steps

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd alpha
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **iOS Setup**:
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the application**:
   ```bash
   flutter run
   ```

## Development Setup

**Recommended IDE**: VS Code or Android Studio with Flutter extensions

**Key Commands**:
- `flutter analyze`: Code analysis and linting
- `flutter test`: Run unit tests
- `flutter build ios`: Build for iOS distribution

---

*Part of the [IIC Cashflow Game 2025](../../README.md) documentation*