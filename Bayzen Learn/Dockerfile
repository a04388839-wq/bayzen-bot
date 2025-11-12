FROM python:3.11-slim

WORKDIR /app

# Копируем файлы проекта
COPY requirements.txt .
COPY bot.py .
COPY images/ ./images/

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Запускаем бота напрямую
CMD ["python", "bot.py"]

