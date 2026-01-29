# CH Centre Thennala

A Flutter mobile application for CH Centre Thennala - a charitable organization platform enabling donations, contributions, volunteer management, and community engagement.

## Features

- Donations & Contributions - Support the organization through various payment methods
- Challenge Participation - Engage in fundraising challenges and campaigns
- Volunteer Management - Track volunteers, leaders, and their contributions
- Reports & Analytics - View donation history, reports, and top contributors
- Quick Order - Order contribution packets directly from the app
- Multiple Payment Options - Support for GPay, PhonePe, Razorpay, and UPI
- Cross-Platform - Available on both iOS and Android

## Tech Stack

- Framework: Flutter
- State Management: GetX
- Payment Integration: Razorpay, GPay, PhonePe, UPI
- Storage: GetStorage, SharedPreferences, Flutter Secure Storage
- Networking: HTTP

## Getting Started

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- CocoaPods (for iOS)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/chcenterthennala.git
cd chcenterthennala
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```


## Project Structure

```
lib/
├── ApiLists/          # API endpoints and app data
├── controller/        # GetX controllers for state management
├── modles/           # Data models
├── screens/          # UI screens
├── Utils/            # Utility functions and constants
└── widgets/          # Reusable widgets
```


## Version

Current version: 1.14.2+18

## License

This project is private and proprietary.
