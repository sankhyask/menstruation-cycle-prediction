# Foresee Cycles - Menstruation Cycle Prediction App

A comprehensive Flutter-based mobile application that predicts menstruation cycles using machine learning. The app combines user-friendly interface with advanced ML algorithms to help users track and predict their menstrual cycles.

## 🌟 Features

### Core Functionality
- **Cycle Prediction**: Advanced ML-based prediction of menstruation cycles
- **User Authentication**: Secure login and signup with Firebase Authentication
- **Data Tracking**: Comprehensive tracking of health metrics
- **Chat Interface**: Interactive chat widget for user assistance
- **Notes Feature**: Personal note-taking functionality
- **Calendar Integration**: Visual calendar for cycle tracking

### Technical Features
- **Cross-Platform**: Works on iOS, Android, and Web
- **Real-time Database**: Firebase Firestore for data synchronization
- **ML Integration**: Flask API serving trained machine learning models
- **Responsive Design**: Modern UI with Material Design principles

## 🏗️ Architecture

### Frontend (Flutter)
- **Framework**: Flutter 2.7.0+
- **Language**: Dart
- **State Management**: Built-in Flutter state management
- **UI Components**: Material Design with custom styling

### Backend (Python/Flask)
- **Framework**: Flask
- **ML Model**: CatBoost Classifier for cycle prediction
- **API Endpoints**: RESTful API for predictions
- **Model Storage**: Pickle files for trained models

### Database & Services
- **Authentication**: Firebase Auth
- **Database**: Firebase Firestore
- **Real-time Updates**: Firebase Realtime Database
- **Hosting**: Firebase hosting support

## 📱 Screenshots

The app includes beautiful onboarding screens and a modern interface with:
- Splash screen with app branding
- Welcome/onboarding flow
- Authentication screens (login/signup)
- Home dashboard with calendar
- Chat interface
- Notes functionality

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (2.7.0 or higher)
- Dart SDK
- Python 3.7+
- Firebase project setup
- Android Studio / Xcode (for mobile development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/menstruation-cycle-prediction.git
   cd menstruation-cycle-prediction
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Install Python dependencies**
   ```bash
   pip install flask joblib pandas numpy scikit-learn catboost
   ```

4. **Setup Firebase**
   - Create a Firebase project
   - Enable Authentication and Firestore
   - Add your `google-services.json` (Android) and Firebase configuration

5. **Run the ML API server**
   ```bash
   python app.py
   ```

6. **Run the Flutter app**
   ```bash
   flutter run
   ```

## 🧠 Machine Learning Model

The app uses a CatBoost Classifier trained on PCOS (Polycystic Ovary Syndrome) dataset with the following features:
- Age, Weight, Height, BMI
- Hormonal levels (FSH, LH, AMH, etc.)
- Clinical parameters
- Lifestyle factors

### Model Training
The model training process is documented in `ml.ipynb` and includes:
- Data preprocessing and feature engineering
- Multiple algorithm comparison (Random Forest, SVM, XGBoost, CatBoost)
- Hyperparameter tuning
- Model evaluation and validation

## 📁 Project Structure

```
menstruation-cycle-prediction/
├── lib/                          # Flutter source code
│   ├── main.dart                 # App entry point
│   ├── pages/                    # UI screens
│   │   ├── auth/                 # Authentication screens
│   │   ├── home/                 # Main app screens
│   │   ├── splash.dart           # Splash screen
│   │   └── welcome.dart          # Welcome/onboarding
│   └── utils/                    # Utilities and constants
├── android/                      # Android-specific code
├── ios/                         # iOS-specific code
├── web/                         # Web platform code
├── assets/                      # Images and resources
├── app.py                       # Flask API server
├── ml.ipynb                     # ML model training notebook
├── cat_clf.pkl                  # Trained CatBoost model
└── pubspec.yaml                 # Flutter dependencies
```

## 🔧 Configuration

### Firebase Setup
1. Create a new Firebase project
2. Enable Authentication (Email/Password)
3. Enable Firestore Database
4. Download `google-services.json` for Android
5. Configure iOS Firebase settings

### Environment Variables
Create a `.env` file for sensitive configuration:
```
FIREBASE_API_KEY=your_api_key
FIREBASE_PROJECT_ID=your_project_id
```

## 📊 API Endpoints

### Prediction Endpoint
- **URL**: `/predict`
- **Method**: POST
- **Input**: JSON with user health metrics
- **Output**: Predicted cycle information

Example request:
```json
{
  "age": 25,
  "weight": 60,
  "height": 165,
  "bmi": 22.0
}
```

## 🧪 Testing

Run Flutter tests:
```bash
flutter test
```

## 📦 Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Kaggle community for the PCOS dataset
- Open source contributors

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Note**: This app is designed for educational and personal use. Always consult healthcare professionals for medical advice related to menstrual health. 