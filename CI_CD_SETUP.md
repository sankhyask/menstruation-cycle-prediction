# CI/CD Pipeline Setup Guide

## 🚀 Overview

This project includes a comprehensive CI/CD pipeline that automates testing, building, and deployment for both the Flutter frontend and Python backend using Google Cloud Platform.

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
- ✅ **Google Cloud Run deployment** (Serverless containers)
- ✅ **Google Container Registry** (Docker image storage)

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

#### **Google Cloud Platform Secrets**
```
GCP_PROJECT_ID=your_gcp_project_id
GCP_SA_KEY=your_service_account_key_json
GCP_REGION=us-central1
```

#### **Optional Secrets**
```
CODECOV_TOKEN=your_codecov_token
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

### **Step 3: Google Cloud Platform Setup**

1. **Create a GCP Project:**
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project or select existing one
   - Note your Project ID

2. **Enable Required APIs:**
   ```bash
   gcloud services enable cloudbuild.googleapis.com
   gcloud services enable run.googleapis.com
   gcloud services enable containerregistry.googleapis.com
   ```

3. **Create Service Account:**
   ```bash
   # Create service account
   gcloud iam service-accounts create github-actions \
     --display-name="GitHub Actions Service Account"

   # Grant necessary roles
   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/run.admin"

   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/storage.admin"

   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="serviceAccount:github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
     --role="roles/cloudbuild.builds.builder"

   # Create and download key
   gcloud iam service-accounts keys create key.json \
     --iam-account=github-actions@YOUR_PROJECT_ID.iam.gserviceaccount.com
   ```

4. **Set up Cloud Run:**
   ```bash
   # Enable Cloud Run API
   gcloud services enable run.googleapis.com

   # Set default region
   gcloud config set run/region us-central1
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
| `deploy-backend` | Cloud Run deployment | Ubuntu |
| `docker-build` | GCR image build | Ubuntu |

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

#### **GCP Issues**
```bash
# Test GCP authentication
gcloud auth list

# Test Cloud Run locally
gcloud run services list

# Check service account permissions
gcloud projects get-iam-policy YOUR_PROJECT_ID
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
   - Builds Python backend Docker image
   - Pushes to Google Container Registry
   - Deploys to Google Cloud Run
   - Creates GitHub Release
   - Sends notifications

## 📈 Performance Monitoring

### **Build Times**
- Flutter web: ~3-5 minutes
- Python backend: ~2-3 minutes
- Full pipeline: ~8-10 minutes

### **GCP Costs** (Estimated)
- Cloud Run: ~$5-10/month (low traffic)
- Container Registry: ~$1-2/month
- Cloud Build: ~$2-5/month

### **Optimization Tips**
- Use dependency caching
- Parallel job execution
- Selective path triggers
- Build artifact sharing
- GCP resource optimization

## 🔒 Security Features

### **Automated Security Checks**
- ✅ **Trivy vulnerability scanning**
- ✅ **Bandit security analysis**
- ✅ **Safety dependency checks**
- ✅ **Code quality enforcement**

### **GCP Security**
- ✅ **Service account authentication**
- ✅ **IAM role-based access**
- ✅ **Container security scanning**
- ✅ **Network security policies**

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

### **GCP Best Practices**
- ✅ Use service accounts for CI/CD
- ✅ Implement proper IAM roles
- ✅ Monitor Cloud Run metrics
- ✅ Set up cost alerts

### **Security**
- ✅ Never commit secrets
- ✅ Use environment variables
- ✅ Regular dependency updates
- ✅ Security scanning in pipeline

## 🆘 Troubleshooting

### **Pipeline Fails**
1. Check GitHub Actions logs
2. Verify GCP secrets are set correctly
3. Test locally with same environment
4. Check for dependency issues

### **GCP Deployment Fails**
1. Check service account permissions
2. Verify GCP project configuration
3. Test deployment locally
4. Check Cloud Run quotas/limits

### **Common GCP Issues**
```bash
# Check service account
gcloud iam service-accounts list

# Verify permissions
gcloud projects get-iam-policy YOUR_PROJECT_ID

# Test Cloud Run
gcloud run services list

# Check logs
gcloud logging read "resource.type=cloud_run_revision"
```

## 📞 Support

For pipeline issues:
1. Check GitHub Actions logs
2. Review this documentation
3. Test locally first
4. Create GitHub issue with logs

For GCP issues:
1. Check Google Cloud Console
2. Review Cloud Run logs
3. Verify IAM permissions
4. Contact Google Cloud Support

---

**Your CI/CD pipeline is now ready for professional development with Google Cloud Platform! 🚀** 