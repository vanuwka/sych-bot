# Используем официальный Node.js образ версии 18
FROM node:18-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json (если есть)
COPY package*.json ./

# Устанавливаем зависимости
RUN npm ci --only=production

# Создаем пользователя для безопасности
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Копируем исходный код
COPY --chown=nodejs:nodejs src/ ./src/

# Переключаемся на пользователя nodejs
USER nodejs

# Создаем директорию для данных от имени nodejs
RUN mkdir -p /app/data

# Порт не нужен, так как бот использует polling
# EXPOSE не требуется

# Команда запуска
CMD ["node", "src/index.js"]
