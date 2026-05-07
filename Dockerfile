# 1. Força o uso absoluto do Python 3.11 (A versão de Ouro para IA)
FROM python:3.11-slim

# 2. Instala as dependências de vídeo do Linux na marra (Acaba com o erro libxcb)
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libxcb1 \
    libx11-xcb1 \
    && rm -rf /var/lib/apt/lists/*

# 3. Cria a pasta do projeto dentro do servidor
WORKDIR /app

# 4. Copia os requirements e instala tudo
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o resto do seu código (main, routes, etc)
COPY . .

# 6. Liga o seu Gunicorn
CMD sh -c "gunicorn main:app --bind 0.0.0.0:${PORT:-8000}"