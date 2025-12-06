# Запуск Sych Bot с Docker

Это руководство поможет вам запустить Sych Bot с помощью Docker Compose.

## Предварительные требования

- Docker Engine 20.10+  [sudo curl -fsSL https://get.docker.com | sh]
- Docker Compose 2.0+   [sudo apt-get install docker-compose-plugin]
- Telegram Bot Token от [@BotFather](https://t.me/BotFather)
- Google Gemini API ключ(и) от [Google AI Studio](https://aistudio.google.com)

## Быстрый запуск

### 1. Клонирование и настройка

```bash
# Клонируйте репозиторий
git clone https://github.com/Veta-one/sych-bot.git
cd sych-bot

# Скопируйте пример конфигурации
cp .env.example .env
```

### 2. Настройка переменных окружения

Отредактируйте файл `.env` и добавьте ваши ключи:

```bash
nano .env
```

Заполните следующие переменные:
- `TELEGRAM_BOT_TOKEN` - токен вашего Telegram бота
- `ADMIN_USER_ID` - ваш Telegram User ID
- `GOOGLE_GEMINI_API_KEY` - API ключ Google Gemini
- `GOOGLE_GEMINI_API_KEY_2` и `GOOGLE_GEMINI_API_KEY_3` - дополнительные ключи (опционально)

### 3. Создание директории для данных

```bash
mkdir -p data
```

### 4. Запуск бота

```bash
# Запуск в фоновом режиме
docker-compose up -d

# Или запуск с выводом логов
docker-compose up
```

### 5. Проверка работы

```bash
# Просмотр логов
docker-compose logs -f sych-bot

# Остановка
docker-compose down
```

## Команды Docker Compose

### Основные команды

```bash
# Запуск в фоновом режиме
docker-compose up -d

# Запуск с выводом логов
docker-compose up

# Остановка
docker-compose down

# Перезапуск
docker-compose restart

# Просмотр логов
docker-compose logs -f

# Просмотр статуса
docker-compose ps
```

### Отладка

```bash
# Войти в контейнер
docker-compose exec sych-bot sh

# Просмотр логов бота
docker-compose logs sych-bot

# Пересборка образа
docker-compose build --no-cache

# Удаление контейнера и образа
docker-compose down --rmi all
```

## Структура данных

При запуске с Docker данные сохраняются в папке `data/` на вашем хосте:

```
data/
├── db.json        # Настройки чатов
└── profiles.json  # Профили пользователей
```

Эти файлы автоматически монтируются в контейнер и сохраняются между перезапусками.

## Мониторинг

### Проверка состояния

```bash
# Статус всех сервисов
docker-compose ps

# Использование ресурсов
docker stats sych-bot
```

### Логирование

```bash
# Все логи
docker-compose logs

# Только логи бота
docker-compose logs sych-bot

# Последние 100 строк
docker-compose logs --tail=100 sych-bot

# Следить за логами в реальном времени
docker-compose logs -f sych-bot
```

## Обновление

Для обновления бота:

```bash
# Остановить текущий процесс
docker-compose down

# Обновить код (если используете git)
git pull origin main

# Пересобрать образ
docker-compose build --no-cache

# Запустить обновленную версию
docker-compose up -d
```

## Устранение неполадок

### Бот не отвечает

1. Проверьте токен бота в `.env`
2. Убедитесь, что бот запущен: `docker-compose ps`
3. Проверьте логи: `docker-compose logs sych-bot`

### Ошибки API

1. Проверьте Google Gemini API ключи
2. Убедитесь, что ключи активны в Google AI Studio
3. При необходимости добавьте дополнительные ключи для ротации

### Проблемы с данными

1. Проверьте права доступа к папке `data/`
2. Убедитесь, что файлы не повреждены
3. При необходимости удалите файлы для сброса данных

## Безопасность

- Никогда не коммитьте файл `.env` в git
- Регулярно обновляйте API ключи
- Используйте отдельные ключи для разработки и продакшена
- Мониторьте логи на предмет подозрительной активности

## Поддержка

Если у вас возникли проблемы:

1. Проверьте логи: `docker-compose logs sych-bot`
2. Убедитесь, что все переменные окружения настроены правильно
3. Проверьте документацию проекта в README.md
4. Создайте issue в репозитории проекта
