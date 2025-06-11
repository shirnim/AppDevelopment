# JobFinder Pro - Architecture Overview

## System Architecture

JobFinder Pro consists of two main applications that can work independently or together:

### 1. Flutter Mobile Application
- **Target Platforms**: iOS, Android, Web
- **Architecture Pattern**: Provider + Repository Pattern
- **State Management**: Provider (with plans to migrate to Riverpod)

### 2. Flask Web Application
- **Target Platform**: Web browsers
- **Architecture Pattern**: MVC (Model-View-Controller)
- **Database**: SQLite (development), PostgreSQL (production recommended)

## Mobile App Architecture

### Layer Structure

```
┌─────────────────────────────────────┐
│           Presentation Layer        │
│  (Screens, Widgets, UI Components)  │
├─────────────────────────────────────┤
│          Business Logic Layer       │
│     (Providers, State Management)   │
├─────────────────────────────────────┤
│            Data Layer               │
│    (Services, Models, Repositories) │
├─────────────────────────────────────┤
│          External APIs              │
│      (JSearch API, Third-party)     │
└─────────────────────────────────────┘
```

### Key Components

#### Models (`lib/models/`)
- **Job**: Core job data structure
- **SearchFilters**: Search parameters and filters
- **JobHighlights**: Structured job requirements and benefits

#### Providers (`lib/providers/`)
- **JobProvider**: Manages job search state and data
- **AnalyticsProvider**: Handles analytics data and insights

#### Services (`lib/services/`)
- **ApiService**: Handles all external API communications
- **JobSearchResponse**: Structured API response handling

#### Screens (`lib/screens/`)
- **MainScreen**: Bottom navigation container
- **SearchScreen**: Job search interface
- **JobDetailScreen**: Detailed job view
- **AnalyticsScreen**: Market insights and trends

#### Widgets (`lib/widgets/`)
- **JobCard**: Individual job display component
- **SearchHeader**: Search input and controls
- **SearchFilters**: Advanced filtering options
- **InsightChips**: AI-generated insights display

## Web Application Architecture

### MVC Structure

```
┌─────────────────────────────────────┐
│              View Layer             │
│    (HTML Templates, Frontend JS)   │
├─────────────────────────────────────┤
│           Controller Layer          │
│        (Flask Routes, Logic)        │
├─────────────────────────────────────┤
│             Model Layer             │
│    (Database Models, Data Logic)    │
├─────────────────────────────────────┤
│          External Services          │
│     (JSearch API, NLTK, Pandas)    │
└─────────────────────────────────────┘
```

### Key Components

#### Flask Application (`app.py`)
- **Route Handlers**: HTTP request processing
- **Business Logic**: Job processing and analytics
- **Database Operations**: SQLite interactions

#### Templates (`templates/`)
- **index.html**: Main search interface
- **job_detail.html**: Detailed job view
- **analytics.html**: Analytics dashboard

#### AI Processing
- **NLTK Integration**: Natural language processing
- **Insight Extraction**: Key skills and requirements analysis
- **Text Analysis**: Job description processing

## Data Flow

### Mobile App Data Flow

```
User Input → Provider → API Service → External API
    ↓
UI Update ← State Change ← Data Processing ← API Response
```

### Web App Data Flow

```
User Request → Flask Route → API Service → External API
     ↓
HTML Response ← Template Render ← Data Processing ← API Response
```

## API Integration

### JSearch API (RapidAPI)
- **Endpoint**: `https://jsearch.p.rapidapi.com/search`
- **Authentication**: API Key in headers
- **Rate Limiting**: Managed by provider
- **Response Caching**: Implemented for performance

### API Request Flow
1. User initiates search
2. Application builds query parameters
3. API request sent with authentication
4. Response processed and cached
5. Data transformed for UI consumption
6. UI updated with new data

## Database Schema (Web App)

### Tables

#### searches
```sql
- id (PRIMARY KEY)
- query (TEXT)
- location (TEXT)
- job_type (TEXT)
- experience_level (TEXT)
- date_posted (TEXT)
- results_count (INTEGER)
- timestamp (DATETIME)
```

#### job_data
```sql
- id (PRIMARY KEY)
- job_id (TEXT UNIQUE)
- title (TEXT)
- company (TEXT)
- location (TEXT)
- employment_type (TEXT)
- posted_date (TEXT)
- responsibilities (TEXT JSON)
- qualifications (TEXT JSON)
- benefits (TEXT JSON)
- salary (TEXT)
- search_id (FOREIGN KEY)
```

## State Management (Mobile)

### Provider Pattern
- **JobProvider**: Manages job search state
- **AnalyticsProvider**: Handles analytics data
- **Reactive Updates**: UI automatically updates on state changes

### State Structure
```dart
class JobProvider extends ChangeNotifier {
  List<Job> _jobs = [];
  bool _isLoading = false;
  String? _error;
  SearchFilters _filters = SearchFilters();
  // ... state management methods
}
```

## Security Considerations

### API Security
- **API Keys**: Stored securely, not in version control
- **Request Validation**: Input sanitization
- **Rate Limiting**: Prevents API abuse

### Data Protection
- **No Sensitive Storage**: No user credentials stored
- **HTTPS Only**: All API communications encrypted
- **Input Validation**: Prevents injection attacks

## Performance Optimizations

### Mobile App
- **Lazy Loading**: Jobs loaded on demand
- **Image Caching**: Company logos cached
- **State Persistence**: Search state maintained
- **Debounced Search**: Prevents excessive API calls

### Web App
- **Database Indexing**: Optimized queries
- **Response Caching**: Reduced API calls
- **Async Processing**: Non-blocking operations
- **Pagination**: Large result sets handled efficiently

## Scalability Considerations

### Horizontal Scaling
- **Stateless Design**: Easy to scale across instances
- **Database Separation**: Can migrate to dedicated DB
- **CDN Integration**: Static assets served efficiently

### Vertical Scaling
- **Efficient Algorithms**: Optimized processing
- **Memory Management**: Proper resource cleanup
- **Connection Pooling**: Database connections managed

## Monitoring and Logging

### Application Monitoring
- **Error Tracking**: Comprehensive error logging
- **Performance Metrics**: Response time monitoring
- **Usage Analytics**: User behavior tracking

### Health Checks
- **API Availability**: External service monitoring
- **Database Health**: Connection and query monitoring
- **Resource Usage**: Memory and CPU tracking

## Deployment Architecture

### Mobile App Deployment
```
Source Code → Build Process → App Stores
     ↓
Flutter Build → Platform Binaries → Distribution
```

### Web App Deployment
```
Source Code → CI/CD Pipeline → Production Server
     ↓
Docker Container → Load Balancer → Application Instances
```

## Future Architecture Improvements

### Microservices Migration
- **API Gateway**: Centralized request routing
- **Service Separation**: Independent scaling
- **Database Per Service**: Data isolation

### Real-time Features
- **WebSocket Integration**: Live updates
- **Push Notifications**: Mobile alerts
- **Event-Driven Architecture**: Reactive updates

### Advanced Analytics
- **Machine Learning Pipeline**: Improved insights
- **Data Warehouse**: Historical analysis
- **Recommendation Engine**: Personalized suggestions