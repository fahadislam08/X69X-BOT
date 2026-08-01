FROM node:20-bullseye

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    pkg-config \
    build-essential \
    libcairo2-dev \
    libpango1.0-dev \
    libpng-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHON=/usr/bin/python3

COPY package*.json ./
COPY patch-fca.js ./

RUN npm install --legacy-peer-deps && npm cache clean --force

COPY . .

ENV PORT=5000
EXPOSE ${PORT}

CMD ["node", "index.js"]
