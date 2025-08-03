from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
import joblib
import os
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Define the app
app = Flask(__name__)
CORS(app)

# Configure rate limiting
limiter = Limiter(
    app=app,
    key_func=get_remote_address,
    default_limits=["200 per day", "50 per hour"]
)

# Load ML model
try:
    model_path = os.path.join(os.path.dirname(__file__), '..', 'models', 'cat_clf.pkl')
    classifier = joblib.load(model_path)
    logger.info("✅ ML model loaded successfully")
except Exception as e:
    logger.error(f"❌ Failed to load ML model: {e}")
    classifier = None

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'timestamp': datetime.utcnow().isoformat(),
        'model_loaded': classifier is not None
    })

@app.route('/predict', methods=['POST'])
@limiter.limit("10 per minute")
def predict():
    """Prediction endpoint with proper validation"""
    try:
        # Validate request
        if not request.is_json:
            return jsonify({'error': 'Content-Type must be application/json'}), 400
        
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['age', 'weight', 'height', 'bmi']
        for field in required_fields:
            if field not in data:
                return jsonify({'error': f'Missing required field: {field}'}), 400
        
        # Validate data types and ranges
        try:
            age = int(data['age'])
            weight = float(data['weight'])
            height = float(data['height'])
            bmi = float(data['bmi'])
        except (ValueError, TypeError):
            return jsonify({'error': 'Invalid data types for input fields'}), 400
        
        # Validate ranges
        if not (10 <= age <= 100):
            return jsonify({'error': 'Age must be between 10 and 100'}), 400
        if not (20 <= weight <= 300):
            return jsonify({'error': 'Weight must be between 20 and 300 kg'}), 400
        if not (100 <= height <= 250):
            return jsonify({'error': 'Height must be between 100 and 250 cm'}), 400
        if not (10 <= bmi <= 50):
            return jsonify({'error': 'BMI must be between 10 and 50'}), 400
        
        # Check if model is loaded
        if classifier is None:
            return jsonify({'error': 'ML model not available'}), 503
        
        # Prepare features (using the same structure as original)
        features = [age, weight, height, bmi, 11, 72, 22, 12.0, 2, 4, 15.0, 0, 0, 10.00, 10.00, 5.01, 6.48, 0.773148, 40, 37, 0.925000, 4.21, 1.89, 12.71, 32.45, 0.27, 85.0, 1, 1, 1, 1, 1, 1.0, 0, 110, 80, 5, 10, 14.0, 13.0, 6.0]
        
        # Make prediction
        prediction = classifier.predict([features])[0]
        
        # Log prediction
        logger.info(f"Prediction made for age={age}, weight={weight}, height={height}, bmi={bmi}: {prediction}")
        
        return jsonify({
            'prediction': int(prediction),
            'confidence': 0.85,  # Placeholder confidence score
            'message': 'Prediction successful',
            'timestamp': datetime.utcnow().isoformat()
        })
        
    except Exception as e:
        logger.error(f"Prediction error: {e}")
        return jsonify({'error': 'Internal server error'}), 500

@app.route('/', methods=['GET'])
def root():
    """Root endpoint"""
    return jsonify({
        'message': 'Foresee Cycles ML API',
        'version': '1.0.0',
        'endpoints': {
            'health': '/health',
            'predict': '/predict'
        }
    })

@app.errorhandler(429)
def ratelimit_handler(e):
    """Rate limit error handler"""
    return jsonify({'error': 'Rate limit exceeded. Please try again later.'}), 429

@app.errorhandler(404)
def not_found(e):
    """404 error handler"""
    return jsonify({'error': 'Endpoint not found'}), 404

@app.errorhandler(500)
def internal_error(e):
    """500 error handler"""
    return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)