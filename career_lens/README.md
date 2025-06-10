# JobFinder Pro - Flutter Mobile App

A modern, AI-powered job search mobile application built with Flutter. This app provides advanced job search capabilities with intelligent insights and a beautiful, responsive design.

## Features

### 🔍 Smart Job Search
- Advanced search with multiple filters
- Location-based job discovery
- Real-time job listings from JSearch API
- Pagination and infinite scroll

### 🧠 AI-Powered Insights
- Key responsibilities extraction
- Required qualifications analysis
- Intelligent job matching
- Skills and requirements highlighting

### 📱 Modern Mobile UI
- Material Design 3 components
- Responsive design for all screen sizes
- Smooth animations and transitions
- Dark/Light theme support

### 📊 Analytics Dashboard
- Job market trends
- Popular search terms
- Location-based insights
- Company hiring statistics

### 🎯 Advanced Filtering
- Job type (Full-time, Part-time, Contract, Internship)
- Experience level (Entry, Mid, Senior)
- Date posted filters
- Location-based filtering

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS development tools (for iOS deployment)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd job_finder_pro
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

#### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── job.dart
│   └── search_filters.dart
├── providers/                # State management
│   ├── job_provider.dart
│   └── analytics_provider.dart
├── screens/                  # App screens
│   ├── main_screen.dart
│   ├── search_screen.dart
│   ├── analytics_screen.dart
│   └── job_detail_screen.dart
├── services/                 # API services
│   └── api_service.dart
├── utils/                    # Utilities
│   └── theme.dart
└── widgets/                  # Reusable widgets
    ├── search_header.dart
    ├── search_filters.dart
    ├── job_list.dart
    ├── job_card.dart
    ├── insight_chips.dart
    ├── active_filters.dart
    └── analytics_card.dart
```

## Key Technologies

- **Flutter**: Cross-platform mobile development
- **Provider**: State management
- **HTTP**: API communication
- **URL Launcher**: External link handling
- **Material Design 3**: Modern UI components

## API Integration

The app integrates with the JSearch API (RapidAPI) to fetch real-time job listings. The API provides:
- Job search with advanced filtering
- Detailed job information
- Company data
- Application links

## Features Overview

### Search Screen
- Hero section with search form
- Advanced filters (collapsible)
- Job results with AI insights
- Infinite scroll pagination
- Active filters display

### Job Detail Screen
- Comprehensive job information
- AI-powered insights highlighting
- Direct application links
- Responsive layout
- Share functionality

### Analytics Screen
- Market trends visualization
- Popular search terms
- Location-based statistics
- Company hiring data

## Customization

### Theme
The app uses a custom theme defined in `lib/utils/theme.dart`. You can customize:
- Primary colors
- Typography
- Component styles
- Dark/Light theme variants

### API Configuration
Update the API credentials in `lib/services/api_service.dart`:
```dart
static const String apiKey = 'your-api-key';
static const String apiHost = 'jsearch.p.rapidapi.com';
```

## Performance Optimizations

- Efficient state management with Provider
- Image caching for better performance
- Lazy loading of job listings
- Optimized API calls with pagination
- Memory-efficient list rendering

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the repository or contact the development team.