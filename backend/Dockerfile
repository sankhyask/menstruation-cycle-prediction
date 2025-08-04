# Use Python 3.9 slim image for maximum package compatibility
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=api/app.py
ENV FLASK_ENV=production

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        g++ \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
# Corrected path to account for new build context
COPY backend/api/requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy application code
# Corrected path to account for new build context
COPY backend/api/ ./api/
# Corrected path for the models directory
COPY backend/models/ ./models/

# Create non-root user
RUN useradd --create-home --shell /bin/bash app \
    && chown -R app:app /app
USER app

# Expose port
# This is now dynamic based on the PORT environment variable from Cloud Run
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/api/health || exit 1

# Run the application using the app factory
# Updated CMD to use the $PORT variable provided by Cloud Run and added debug logging
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "--log-level", "debug", "api.app:create_app()"]
