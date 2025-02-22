# SmartTask

## Overview
## Happy Day TEAM :: Welcome To Mugisha Jean Claude practical assessment ** enjoy my super codebase hhh :):)

**SmartTask** is a cross-platform productivity app designed for **Inkomoko**, enabling users to
efficiently create, manage, and collaborate on tasks. The app functions seamlessly both online and
offline, supports real-time updates, push notifications, and adheres to security best practices. It
is built using **Flutter** to ensure a high-performance, native-like experience across Android and
iOS.

## Features

### Core Features

- **Modern & Responsive UI**: Adheres to Material Design (Android) and Human Interface Guidelines (
  iOS), with smooth animations and transitions.
- **Offline Capabilities**: Users can create, edit, and delete tasks offline, with automatic
  synchronization when back online (Powered by Hive/Sqllite for local storage).
- **Real-Time Sync & Collaboration**: Supports WebSockets / Firebase Firestore for live updates and
  collaborative task management.
- **Search Functionality**: Enables filtering by name, date, priority, and tags, with optimized
  performance using indexing techniques.
- **Push Notifications**: Uses Firebase Cloud Messaging (FCM) and Apple Push Notification Service (
  APNS) for task reminders and real-time alerts.
- **Authentication & Security**: Implements OAuth 2.0, JWT-based authentication, and AES encryption
  for local data protection.
- **Automated Testing & CI/CD**: Utilizes Flutter Test Framework, GitHub Actions, and SonarQube for
  code quality enforcement.
- **Google Authenticator & SSO**: Supports 2FA via Google Authenticator and Single Sign-On (SSO)
  with Google, Apple, and Microsoft.

### Bonus Features

- **Dark Mode & Accessibility**: Fully supports system-wide dark mode and screen readers for
  visually impaired users.
- **Task Reminders & Calendar Sync**: Allows due dates with notifications and integration with
  Google/Apple Calendar.
- **Drag & Drop Task Management**: Implements a Kanban-style task organization interface.
- **Background Syncing**: Ensures automatic data synchronization without user intervention.

## Tech Stack

- **Framework**: Flutter &  Dart language
- **State Management**: Riverpod
- **Backend Services**: Firebase (Auth, Firestore, Crashlytics, Messaging)
- **Local Storage**: Hive (for offline task management)
- **Networking**: Dio (API calls & data synchronization)
- **Authentication**: Firebase Auth, OAuth 2.0, Google Sign-In
- **Push Notifications**: Firebase Cloud Messaging (FCM), Apple Push Notification Service (APNS)
- **Security**: AES Encryption, JWT Authentication
- **app support multiple languages**
- **Testing**: Flutter Test, Integration Testing, SonarQube for static code analysis
- **CI/CD**: GitHub Actions for automated build, test, and deployment

## Installation & Setup

### Prerequisites

- Flutter SDK (latest version) installed
- Firebase CLI configured (`flutterfire configure`)
- Git installed

### Steps to Run Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/mugishajc/smarttask.git
   cd smarttask
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure Firebase:
   ```bash
   flutterfire configure
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Testing

- **Unit Tests**:
  ```bash
  flutter test
  ```
- **Integration Tests**:
  ```bash
  flutter test integration_test/
  ```

## Contribution Guidelines

1. Fork the repository and create a feature branch.
2. Follow clean architecture principles.
3. Submit pull requests with detailed commit messages.

## License

This project is licensed under the **MIT License**.

## Author

Developed by **Mugisha Jean Claude** for **Inkomoko Software Team [Practical Challenge]**.

- GitHub: [mugishajc](https://github.com/mugishajc)
- Email: [jcmugisha1@gmail.com]
- Linkedin Profile: [https://www.linkedin.com/in/mugisha-jean-claude]

---
🚀 **Inkomoko Smart Task** is designed to enhance productivity with a seamless, secure, and real-time
collaborative experience.

