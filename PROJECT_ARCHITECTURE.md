# Foresee Cycles - Project Architecture

## 🏗️ Project Structure

```
foresee-cycles/
├── 📱 Frontend (Flutter)
│   ├── lib/
│   │   ├── main.dart                    # App entry point
│   │   ├── core/                        # Core application logic
│   │   │   ├── models/                  # Data models
│   │   │   │   ├── user_model.dart      # User data model
│   │   │   │   └── prediction_model.dart # Prediction data model
│   │   │   ├── services/                # Business logic services
│   │   │   │   ├── auth_service.dart    # Authentication service
│   │   │   │   └── prediction_service.dart # ML API service
│   │   │   └── providers/               # State management (future)
│   │   ├── features/                    # Feature-based modules
│   │   │   ├── auth/                    # Authentication feature
│   │   │   │   ├── login.dart          # Login screen
│   │   │   │   ├── signup.dart         # Signup screen
│   │   │   │   ├── forgot_password.dart # Password reset
│   │   │   │   ├── splash.dart         # Splash screen
│   │   │   │   └── welcome.dart        # Onboarding
│   │   │   ├── home/                    # Home feature
│   │   │   │   ├── home_page.dart      # Main dashboard
│   │   │   │   ├── appbar.dart         # Custom app bar
│   │   │   │   ├── chat_widget.dart    # Chat interface
│   │   │   │   └── note_widget.dart    # Notes widget
│   │   │   └── prediction/              # Prediction feature (future)
│   │   └── shared/                      # Shared components
│   │       ├── constants/               # App constants
│   │       │   ├── constant_data.dart   # Image paths, etc.
│   │       │   └── styles.dart         # App styling
│   │       └── widgets/                 # Reusable widgets (future)
│   ├── assets/
│   │   └── images/                      # App images
│   │       ├── splashImage.png         # Splash screen image
│   │       ├── onboarding0.png         # Onboarding image 1
│   │       ├── onboarding1.png         # Onboarding image 2
│   │       ├── onboarding2.png         # Onboarding image 3
│   │       └── user_image.jpg          # Default user image
│   ├── android/                         # Android platform code
│   ├── ios/                            # iOS platform code
│   ├── web/                            # Web platform code
│   ├── test/                           # Test files
│   ├── pubspec.yaml                    # Flutter dependencies
│   └── pubspec.lock                    # Locked dependencies
│
├── 🐍 Backend (Python/Flask)
│   ├── api/
│   │   ├── app.py                      # Flask application
│   │   ├── config.py                   # Configuration settings
│   │   └── requirements.txt            # Python dependencies
│   ├── models/
│   │   └── cat_clf.pkl                # Trained ML model
│   └── utils/                          # Backend utilities (future)
│
├── 📚 Documentation
│   ├── docs/
│   │   └── ml.ipynb                   # ML model training notebook
│   ├── README.md                       # Project overview
│   ├── PROJECT_ARCHITECTURE.md         # This file
│   └── .gitignore                      # Git ignore rules
│
└── 🔧 Configuration
    └── .gitignore                      # Git ignore patterns
```

## 🎯 Architecture Principles

### 1. **Feature-Based Organization**
- Each feature is self-contained with its own screens, widgets, and logic
- Features can be developed and tested independently
- Clear separation of concerns

### 2. **Clean Architecture**
- **Core Layer**: Business logic, models, and services
- **Feature Layer**: UI screens and feature-specific logic
- **Shared Layer**: Common components and utilities

### 3. **Service-Oriented Design**
- Authentication service handles all auth operations
- Prediction service manages ML API communication
- Services are injectable and testable

### 4. **Type Safety**
- Strongly typed models for data consistency
- Clear interfaces between layers
- Compile-time error checking

## 🔄 Data Flow

### Authentication Flow
```
User Input → Auth Service → Firebase Auth → User Model → UI Update
```

### Prediction Flow
```
User Input → Prediction Service → Flask API → ML Model → Prediction Model → UI Update
```

## 🛠️ Technology Stack

### Frontend
- **Framework**: Flutter 2.7.0+
- **Language**: Dart
- **State Management**: Provider/Riverpod (planned)
- **Authentication**: Firebase Auth
- **Database**: Firebase Firestore
- **HTTP Client**: http package

### Backend
- **Framework**: Flask
- **Language**: Python 3.7+
- **ML Library**: CatBoost, scikit-learn
- **API**: RESTful endpoints
- **Security**: CORS, rate limiting

### Infrastructure
- **Authentication**: Firebase Authentication
- **Database**: Firebase Firestore
- **Hosting**: Firebase Hosting (planned)
- **ML Deployment**: Flask API

## 📁 Directory Structure Details

### `/lib/core/`
Contains the core business logic of the application:
- **models/**: Data structures and type definitions
- **services/**: Business logic and external API calls
- **providers/**: State management (future implementation)

### `/lib/features/`
Feature-based modules following clean architecture:
- **auth/**: All authentication-related screens and logic
- **home/**: Main dashboard and navigation
- **prediction/**: ML prediction interface (future)

### `/lib/shared/`
Reusable components and utilities:
- **constants/**: App-wide constants and styling
- **widgets/**: Reusable UI components (future)

### `/backend/`
Python backend for ML API:
- **api/**: Flask application and endpoints
- **models/**: Trained ML models
- **utils/**: Backend utilities (future)

## 🚀 Development Workflow

### Frontend Development
1. Create feature in `/lib/features/`
2. Add models in `/lib/core/models/`
3. Implement services in `/lib/core/services/`
4. Add shared components in `/lib/shared/`

### Backend Development
1. Add API endpoints in `/backend/api/app.py`
2. Update configuration in `/backend/api/config.py`
3. Add dependencies to `/backend/api/requirements.txt`

### ML Development
1. Train models using `/docs/ml.ipynb`
2. Save models to `/backend/models/`
3. Update API endpoints to use new models

## 🔧 Configuration

### Environment Variables
```bash
# Backend
SECRET_KEY=your-secret-key
DEBUG=False
HOST=0.0.0.0
PORT=5000
MODEL_PATH=../models/cat_clf.pkl

# Frontend
FIREBASE_API_KEY=your-firebase-api-key
FIREBASE_PROJECT_ID=your-project-id
```

## 📊 Future Enhancements

### Planned Features
- [ ] State management with Provider/Riverpod
- [ ] Comprehensive testing suite
- [ ] Offline support
- [ ] Push notifications
- [ ] Data analytics dashboard
- [ ] User profile management
- [ ] Advanced ML features

### Technical Improvements
- [ ] API documentation with Swagger
- [ ] Automated testing pipeline
- [ ] Performance monitoring
- [ ] Error tracking and logging
- [ ] Security audit and hardening

## 🧪 Testing Strategy

### Frontend Testing
- Unit tests for services and models
- Widget tests for UI components
- Integration tests for features

### Backend Testing
- Unit tests for API endpoints
- Integration tests for ML pipeline
- Load testing for API performance

## 📈 Deployment

### Frontend Deployment
- Android: Google Play Store
- iOS: Apple App Store
- Web: Firebase Hosting

### Backend Deployment
- API: Heroku/AWS/GCP
- ML Models: Containerized deployment
- Database: Firebase Firestore

---

This architecture provides a scalable, maintainable, and testable foundation for the Foresee Cycles application. 