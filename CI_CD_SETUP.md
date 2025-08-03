# CI/CD Pipeline Setup Guide

## 🚀 Overview

This project includes a comprehensive CI/CD pipeline that automates testing, building, and deployment for both the Flutter frontend and Python backend.

## 📋 Pipeline Components

### 1. **Flutter CI/CD Pipeline** (`.github/workflows/flutter-ci.yml`)
- ✅ **Multi-platform builds** (Web, Android, iOS)
- ✅ **Code quality checks** (linting, formatting, tests)
- ✅ **Security scanning** (Trivy vulnerability scanner)
- ✅ **Coverage reporting** (Codecov integration)
- ✅ **Firebase deployment** (Web hosting)

### 2. **Python Backend Pipeline** (`.github/workflows/python-backend.yml`)
- ✅ **Python testing** (pytest, coverage)
- ✅ **Code quality** (flake8, black formatting)
- ✅ **Security scanning** (safety, bandit)
- ✅ **ML model testing** (model loading, API endpoints)
- ✅ **Heroku deployment** (Container deployment)
- ✅ **Docker builds** (Docker Hub integration)

### 3. **Production Deployment** (`.github/workflows/deploy.yml`)
- ✅ **Tag-based releases** (v1.0.0, v1.1.0, etc.)
- ✅ **Automated releases** (GitHub Releases)
- ✅ **Multi-service deployment** (Frontend + Backend)
- ✅ **Deployment notifications**

## 🔧 Setup Instructions

### **Step 1: GitHub Secrets Configuration**

Add these secrets to your GitHub repository (`Settings > Secrets and variables > Actions`):

#### **Firebase Secrets**
```
FIREBASE_TOKEN=your_firebase_token
```

#### **Heroku Secrets**
```
HEROKU_API_KEY=your_heroku_api_key
HEROKU_APP_NAME=your_heroku_app_name
```

#### **Docker Secrets** (Optional)
```
DOCKER_USERNAME=your_docker_username
DOCKER_PASSWORD=your_docker_password
```

### **Step 2: Firebase Setup**

1. **Install Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase:**
   ```bash
   firebase login
   ```

3. **Initialize Firebase in your project:**
   ```bash
   firebase init hosting
   ```

4. **Get Firebase token:**
   ```bash
   firebase login:ci
   ```

### **Step 3: Heroku Setup**

1. **Create Heroku app:**
   ```bash
   heroku create your-app-name
   ```

2. **Get Heroku API key:**
   - Go to Heroku Dashboard > Account Settings > API Key

3. **Set up container registry:**
   ```bash
   heroku container:login
   ```

### **Step 4: Codecov Setup** (Optional)

1. **Sign up at [Codecov](https://codecov.io)**
2. **Connect your GitHub repository**
3. **Add Codecov token to secrets** (if required)

## 🏃‍♂️ Running the Pipeline

### **Automatic Triggers**
- ✅ **Push to main/develop** - Runs all tests and builds
- ✅ **Pull requests** - Runs tests and quality checks
- ✅ **Tag pushes** (v*) - Triggers production deployment

### **Manual Triggers**
You can manually trigger workflows from the GitHub Actions tab.

## 📊 Pipeline Jobs

### **Flutter Pipeline Jobs**

| Job | Purpose | Runs On |
|-----|---------|---------|
| `flutter-web` | Web build & test | Ubuntu |
| `flutter-android` | Android APK build | Ubuntu |
| `flutter-ios` | iOS build | macOS |
| `code-quality` | Linting & coverage | Ubuntu |
| `security-scan` | Vulnerability scan | Ubuntu |
| `deploy-web` | Firebase deployment | Ubuntu |

### **Python Pipeline Jobs**

| Job | Purpose | Runs On |
|-----|---------|---------|
| `test-backend` | Python tests & linting | Ubuntu |
| `security-scan-python` | Security scanning | Ubuntu |
| `ml-model-test` | ML model validation | Ubuntu |
| `deploy-backend` | Heroku deployment | Ubuntu |
| `docker-build` | Docker image build | Ubuntu |

## 🔍 Monitoring & Debugging

### **View Pipeline Status**
- Go to your GitHub repository
- Click on "Actions" tab
- View workflow runs and job status

### **Common Issues & Solutions**

#### **Flutter Issues**
```bash
# If Flutter version issues
flutter upgrade
flutter doctor

# If dependency issues
flutter clean
flutter pub get
```

#### **Python Issues**
```bash
# If dependency issues
pip install -r requirements.txt

# If model loading fails
python -c "import joblib; joblib.load('models/cat_clf.pkl')"
```

#### **Deployment Issues**
```bash
# Test Firebase locally
firebase serve

# Test Heroku locally
heroku local web
```

## 🚀 Deployment Process

### **Development Deployment**
1. Push to `develop` branch
2. Pipeline runs tests and builds
3. No automatic deployment

### **Production Deployment**
1. Create and push a tag: `git tag v1.0.0 && git push origin v1.0.0`
2. Pipeline automatically:
   - Builds Flutter web app
   - Deploys to Firebase Hosting
   - Builds Python backend
   - Deploys to Heroku
   - Creates GitHub Release
   - Sends notifications

## 📈 Performance Monitoring

### **Build Times**
- Flutter web: ~3-5 minutes
- Python backend: ~2-3 minutes
- Full pipeline: ~8-10 minutes

### **Optimization Tips**
- Use dependency caching
- Parallel job execution
- Selective path triggers
- Build artifact sharing

## 🔒 Security Features

### **Automated Security Checks**
- ✅ **Trivy vulnerability scanning**
- ✅ **Bandit security analysis**
- ✅ **Safety dependency checks**
- ✅ **Code quality enforcement**

### **Rate Limiting**
- API endpoints: 10 requests/minute
- Health checks: 200 requests/day
- Error handling for rate limits

## 📝 Best Practices

### **Code Quality**
- ✅ Run `flutter analyze` before commits
- ✅ Use `dart format` for consistent formatting
- ✅ Write tests for new features
- ✅ Add type safety with models

### **Deployment**
- ✅ Test locally before pushing
- ✅ Use semantic versioning (v1.0.0)
- ✅ Monitor deployment logs
- ✅ Set up rollback procedures

### **Security**
- ✅ Never commit secrets
- ✅ Use environment variables
- ✅ Regular dependency updates
- ✅ Security scanning in pipeline

## 🆘 Troubleshooting

### **Pipeline Fails**
1. Check GitHub Actions logs
2. Verify secrets are set correctly
3. Test locally with same environment
4. Check for dependency issues

### **Deployment Fails**
1. Check service credentials
2. Verify service configurations
3. Test deployment locally
4. Check service quotas/limits

## 📞 Support

For pipeline issues:
1. Check GitHub Actions logs
2. Review this documentation
3. Test locally first
4. Create GitHub issue with logs

---

**Your CI/CD pipeline is now ready for professional development! 🚀** 