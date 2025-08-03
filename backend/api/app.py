from flask import Flask, request, jsonify
from flasgger import Swagger
from flask_cors import CORS
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
import joblib
import os
import logging
from datetime import datetime
from marshmallow import ValidationError

# Import configuration and schemas
from config import Config
from schemas import prediction_schema

# --- App Initialization ---
def create_app(config_class=Config):
    """Creates and configures the Flask application."""
    app = Flask(__name__)
    app.config.from_object(config_class)

    # --- Extensions ---
    CORS(app, resources={r"/api/*": {"origins": app.config['CORS_ORIGINS']}})
    
    limiter = Limiter(
        app=app,
        key_func=get_remote_address,
        default_limits=[app.config['RATELIMIT_DEFAULT']]
    )

    # Initialize Swagger for API documentation
    swagger_template = {
        "swagger": "2.0",
        "info": {
            "title": "Foresee Cycles ML API",
            "description": "API for the Foresee Cycles ML model.",
            "version": "1.0.0"
        }
    }
    Swagger(app, template=swagger_template)

    # --- Logging ---
    logging.basicConfig(level=logging.INFO)
    app.logger.setLevel(logging.INFO)

    # --- Load ML Model ---
    try:
        # Use the path from the config file
        model_path = os.path.join(os.path.dirname(__file__), app.config['MODEL_PATH'])
        app.classifier = joblib.load(model_path)
        app.logger.info("✅ ML model loaded successfully")
    except Exception as e:
        app.logger.error(f"❌ Failed to load ML model: {e}")
        app.classifier = None

    # --- Routes ---
    @app.route('/api/health', methods=['GET'])
    def health_check():
        """
        Health Check
        Confirms that the API is running and the model is loaded.
        ---
        responses:
          200:
            description: API is healthy.
            schema:
              type: object
              properties:
                status:
                  type: string
                  example: healthy
                model_loaded:
                  type: boolean
      """
        return jsonify({
            'status': 'healthy',
            'timestamp': datetime.utcnow().isoformat(),
            'model_loaded': app.classifier is not None
        })

    @app.route('/api/predict', methods=['POST'])
    @limiter.limit("10 per minute")
    def predict():
        """
        Get a prediction from the ML model.
        ---
        parameters:
          - in: body
            name: body
            required: true
            schema:
              id: PredictionInput
              required:
                - age
                - weight
                - height
                - bmi
              properties:
                age:
                  type: integer
                  description: User's age.
                  example: 25
                weight:
                  type: number
                  description: User's weight in kg.
                  example: 65.5
                height:
                  type: number
                  description: User's height in cm.
                  example: 175.0
                bmi:
                  type: number
                  description: User's Body Mass Index.
                  example: 21.3
        responses:
          200:
            description: Prediction successful.
          400:
            description: Invalid input data.
          503:
            description: Model not available.
        """
        if app.classifier is None:
            return jsonify({'error': 'ML model not available'}), 503

        try:
            # Validate input using the Marshmallow schema
            data = prediction_schema.load(request.get_json())
        except ValidationError as err:
            return jsonify({'errors': err.messages}), 400
        
        try:
            # IMPORTANT: The hardcoded features are a placeholder.
            # In a real-world scenario, you would generate or look up these
            # other features based on the user or other context.
            # For now, we use the four inputs and keep the rest static.
            features = [
                data['age'], data['weight'], data['height'], data['bmi'],
                11, 72, 22, 12.0, 2, 4, 15.0, 0, 0, 10.00, 10.00, 5.01, 
                6.48, 0.773148, 40, 37, 0.925000, 4.21, 1.89, 12.71, 
                32.45, 0.27, 85.0, 1, 1, 1, 1, 1, 1.0, 0, 110, 80, 5, 
                10, 14.0, 13.0, 6.0
            ]

            prediction = app.classifier.predict([features])[0]
            
            app.logger.info(f"Prediction successful for input: {data}")
            
            return jsonify({
                'prediction': int(prediction),
                'confidence': 0.85,  # Placeholder
            })
        except Exception as e:
            app.logger.error(f"Prediction error: {e}")
            return jsonify({'error': 'An internal server error occurred'}), 500

    # --- Error Handlers ---
    @app.errorhandler(429)
    def ratelimit_handler(e):
        return jsonify(error=f"Rate limit exceeded: {e.description}"), 429

    @app.errorhandler(404)
    def not_found(e):
        return jsonify(error="Endpoint not found"), 404

    return app

# --- Run Application ---
if __name__ == '__main__':
    app = create_app()
    app.run(host=app.config['HOST'], port=app.config['PORT'], debug=app.config['DEBUG'])
