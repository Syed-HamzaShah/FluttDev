# CECOS Hub

A Flutter-based social media application for CECOS University students to share posts, interact with content, and stay connected with their peers.

## 📱 Features

- **User Authentication**: Firebase-based authentication with email/password
- **Real-time Posts**: Supabase-powered real-time post sharing and updates
- **Push Notifications**: FCM notifications for new posts and interactions
- **User Profiles**: Customizable user profiles with department and semester information
- **Media Support**: Image sharing capabilities
- **Real-time Updates**: Live updates when new posts are created

## 🏗️ Architecture & Flow

### Application Flow

```
1. App Launch
   ├── Initialize Firebase & Supabase
   ├── Initialize Notification Service
   ├── Check Authentication State
   └── Navigate to Login/Home Screen

2. Authentication Flow
   ├── Login Screen
   │   ├── Email/Password Validation
   │   ├── Firebase Authentication
   │   └── Load User Data from Firestore
   └── Sign Up Screen
       ├── User Registration
       ├── Profile Creation
       └── Firestore Document Creation

3. Main Application Flow
   ├── Home Screen
   │   ├── Load Posts (Supabase)
   │   ├── Real-time Post Updates
   │   ├── Create New Posts
   │   └── User Interactions
   └── Profile Management
       ├── Update Profile Information
       └── View User Statistics
```

### Data Flow

```
User Action → Service Layer → Database → Real-time Updates → UI Refresh
     ↓              ↓            ↓            ↓              ↓
  Create Post → SupabasePosts → Supabase → Real-time → Notification
  Service      Service         Database   Channel     Service
```

### Key Components

- **AuthService**: Handles Firebase authentication and user management
- **SupabasePostsService**: Manages posts CRUD operations and real-time subscriptions
- **NotificationService**: Handles FCM and local notifications
- **Models**: UserModel, PostModel for data structure

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Firebase project
- Supabase project

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/cecos_hub.git
cd cecos_hub
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### 3.1 Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Authentication (Email/Password)
4. Create Firestore database
5. Enable Cloud Messaging

#### 3.2 Configure Firebase for Flutter
1. Download `google-services.json` for Android
2. Download `GoogleService-Info.plist` for iOS
3. Place files in appropriate directories:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

#### 3.3 Generate Firebase Options
```bash
flutter packages pub run build_runner build
```

### 4. Supabase Setup

#### 4.1 Create Supabase Project
1. Go to [Supabase](https://supabase.com/)
2. Create a new project
3. Note down your project URL and anon key

#### 4.2 Database Schema
Create the following table in Supabase:

```sql
-- Posts table
CREATE TABLE posts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  description TEXT NOT NULL,
  mediaurl TEXT,
  createdby UUID NOT NULL,
  createdbyname TEXT NOT NULL,
  createdbyavatar TEXT,
  createdat TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  likes TEXT[] DEFAULT '{}',
  comments JSONB DEFAULT '[]'::jsonb
);

-- Enable Row Level Security
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Posts are viewable by everyone" ON posts
  FOR SELECT USING (true);

-- Create policy for authenticated users to insert
CREATE POLICY "Authenticated users can insert posts" ON posts
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- Enable real-time for posts table
ALTER PUBLICATION supabase_realtime ADD TABLE posts;
```

#### 4.3 Update Supabase Configuration
Update the Supabase URL and key in `lib/main.dart`:

```dart
const supabaseUrl = 'YOUR_SUPABASE_URL';
const supabaseKey = 'YOUR_SUPABASE_ANON_KEY';
```

### 5. FCM Configuration (Optional)

#### 5.1 Get FCM Server Key
1. Go to Firebase Console → Project Settings → Cloud Messaging
2. Copy the Server Key

#### 5.2 Update FCM Configuration
Update the FCM server key in `lib/services/notification_service.dart`:

```dart
const String FCM_SERVER_KEY = 'YOUR_FCM_SERVER_KEY';
```

**⚠️ Security Note**: For production, never embed the FCM server key in the client. Use a backend service or Supabase Edge Function instead.

### 6. Platform-Specific Setup

#### Android Setup
1. Ensure `minSdkVersion` is at least 21 in `android/app/build.gradle`
2. Add internet permission in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.VIBRATE" />
```

#### iOS Setup
1. Ensure iOS deployment target is 11.0 or higher
2. Add notification permissions in `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

### 7. Run the Application

```bash
# For development
flutter run

# For release build
flutter build apk --release
```

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── post_model.dart      # Post data structure
│   └── user_model.dart      # User data structure
├── screens/                  # UI screens
│   ├── auth/                # Authentication screens
│   └── home/                # Main app screens
├── services/                 # Business logic
│   ├── auth_service.dart    # Authentication service
│   ├── supabase_posts_service.dart # Posts management
│   └── notification_service.dart   # Notifications
└── utils/                    # Utilities
    └── app_colors.dart      # App color scheme
```

## 🔧 Configuration Files

- `pubspec.yaml` - Flutter dependencies
- `firebase.json` - Firebase configuration
- `android/app/google-services.json` - Android Firebase config
- `ios/Runner/GoogleService-Info.plist` - iOS Firebase config

## 🚨 Troubleshooting

### Common Issues

1. **Firebase not initialized**
   - Ensure `google-services.json` and `GoogleService-Info.plist` are in correct locations
   - Run `flutter clean && flutter pub get`

2. **Supabase connection issues**
   - Verify URL and key in `main.dart`
   - Check RLS policies in Supabase dashboard

3. **Notifications not working**
   - Ensure FCM is properly configured
   - Check device notification permissions
   - Verify FCM server key (if using direct FCM)

4. **Build errors**
   - Run `flutter clean`
   - Delete `pubspec.lock` and run `flutter pub get`
   - Check Flutter and Dart SDK versions

### Debug Mode

The app includes debug logging that can be enabled by setting `kDebugMode` to true in the notification service.

## 📝 Environment Variables

For production deployment, consider using environment variables for:

- Supabase URL and Key
- FCM Server Key
- Firebase configuration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact the development team
- Check the troubleshooting section above

---

**Note**: This application is designed specifically for CECOS University students and includes department and semester-specific features.