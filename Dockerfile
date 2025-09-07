FROM python:3.10-slim

# Install system dependencies (Chrome, Tesseract, fonts)
RUN apt-get update && apt-get install -y \
    wget gnupg unzip fonts-liberation libx11-6 libxcomposite1 \
    libasound2 libatk1.0-0 libcups2 libdbus-1-3 libgdk-pixbuf2.0-0 \
    libnspr4 libnss3 libxss1 libxtst6 xdg-utils tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Set display for headless chrome
ENV DISPLAY=:99

# Copy bot code
WORKDIR /app
COPY . .

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Run the bot
CMD ["python", "main.py"]
