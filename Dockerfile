FROM python:3.10-slim

WORKDIR /app

# nginx
RUN apt-get update && apt-get install -y nginx

# dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Copy custom Nginx conf to container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80 8000

# Start FastAPI with Uvicorn
CMD service nginx start && uvicorn main:app --host 0.0.0.0 --port 8000 --workers 1