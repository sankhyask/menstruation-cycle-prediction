from marshmallow import Schema, fields, validate

class PredictionSchema(Schema):
    """
    Schema for validating the input data for the prediction endpoint.
    """
    age = fields.Int(
        required=True, 
        validate=validate.Range(min=10, max=100, error="Age must be between 10 and 100.")
    )
    weight = fields.Float(
        required=True, 
        validate=validate.Range(min=20, max=300, error="Weight must be between 20 and 300 kg.")
    )
    height = fields.Float(
        required=True, 
        validate=validate.Range(min=100, max=250, error="Height must be between 100 and 250 cm.")
    )
    bmi = fields.Float(
        required=True, 
        validate=validate.Range(min=10, max=50, error="BMI must be between 10 and 50.")
    )

# Instantiate the schema for use in the application.
prediction_schema = PredictionSchema()
