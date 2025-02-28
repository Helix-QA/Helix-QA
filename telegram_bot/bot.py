import requests
import logging
from logging.handlers import RotatingFileHandler
from telegram import ReplyKeyboardMarkup, Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, filters, CallbackContext, CallbackQueryHandler
from config import TOKEN, JENKINS_URL, JENKINS_USER, JENKINS_API_TOKEN

# Настройка логирования (оставляем без изменений)
log_handler = RotatingFileHandler(
    "C:\\logs\\bot_logs.txt",
    maxBytes=5*1024*1024,  # 5 MB
    backupCount=1,         # Хранить 1 старых файлов
    encoding='utf-8'
)
log_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))

logging.basicConfig(level=logging.INFO, handlers=[
    log_handler,
    logging.StreamHandler()
])

def get_jenkins_views():
    """Получение списка всех доступных Jenkins Views."""
    url = f'{JENKINS_URL}/api/json?tree=views[name,url]'
    auth = (JENKINS_USER, JENKINS_API_TOKEN)
    try:
        response = requests.get(url, auth=auth)
        response.raise_for_status()
        data = response.json()
        logging.info(f"Response from Jenkins API: {data}")
        
        # Фильтрация, чтобы исключить view с именем 'all'
        views = [view for view in data.get('views', []) if view['name'] != 'all']
        return views
        
    except requests.RequestException as e:
        logging.error(f"Error fetching Jenkins views: {e}")
        return []

def get_jenkins_jobs(view_name: str):
    """Получение списка всех доступных Jenkins Jobs в определенном представлении."""
    url = f'{JENKINS_URL}/view/{view_name}/api/json?tree=jobs[name]'
    auth = (JENKINS_USER, JENKINS_API_TOKEN)
    try:
        response = requests.get(url, auth=auth)
        response.raise_for_status()
        return response.json().get('jobs', [])
    except requests.RequestException as e:
        logging.error(f"Error fetching Jenkins jobs: {e}")
        return []

async def send_inline_keyboard(update: Update, context: CallbackContext, message: str, job_url: str):
    """Отправка сообщения с инлайн-клавиатурой для управления пайплайном."""
    keyboard = [
        [InlineKeyboardButton("Proceed", callback_data=f"proceed_{job_url}"),
         InlineKeyboardButton("Abort", callback_data=f"abort_{job_url}")]
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    await context.bot.send_message(chat_id=update.effective_chat.id, text=message, reply_markup=reply_markup)

async def handle_button(update: Update, context: CallbackContext):
    query = update.callback_query
    await query.answer()

    action_data = query.data.split('_', 1)
    if len(action_data) < 2:
        await query.edit_message_text("Некорректные данные кнопки. Пожалуйста, попробуйте снова.")
        logging.error(f"Invalid callback_data format: {query.data}")
        return

    action = action_data[0]  # "proceed" или "abort"
    job_path = action_data[1]  # "RELEASES/job/release_pack/140"

    # Формируем базовый URL сборки
    job_url = f"{JENKINS_URL}/job/{job_path}".strip()
    logging.info(f"Processing action: {action}, job_url: {job_url}")

    if action == "proceed":
        await query.edit_message_text("Продолжаем выполнение пайплайна...")
        try:
            # Получаем информацию о сборке
            api_url = f"{job_url}/api/json"
            response = requests.get(api_url, auth=(JENKINS_USER, JENKINS_API_TOKEN), timeout=10)
            response.raise_for_status()
            build_data = response.json()

            # Ищем inputId
            input_id = None
            for executor in build_data.get("executors", []):
                current_executable = executor.get("currentExecutable", {})
                if current_executable.get("_class") == "org.jenkinsci.plugins.workflow.support.steps.input.InputStepExecution":
                    input_id = current_executable.get("id")
                    break

            if not input_id:
                raise Exception("Не удалось найти inputId в данных сборки")

            # Формируем URL для продолжения
            proceed_url = f"{job_url}/input/{input_id}/proceedEmpty"
            response = requests.post(
                proceed_url,
                auth=(JENKINS_USER, JENKINS_API_TOKEN),
                timeout=10
            )
            response.raise_for_status()
            logging.info(f"Jenkins proceed response for {proceed_url}: {response.status_code}")
        except Exception as e:
            await query.edit_message_text(f"Ошибка при продолжении пайплайна: {str(e)}")
            logging.error(f"Error proceeding pipeline for {job_url}: {e}")
    elif action == "abort":
        await query.edit_message_text("Пайплайн прерван.")
        try:
            response = requests.post(
                f"{job_url}/stop",
                auth=(JENKINS_USER, JENKINS_API_TOKEN),
                timeout=10
            )
            logging.info(f"Jenkins abort response for {job_url}: {response.status_code}")
        except Exception as e:
            await query.edit_message_text(f"Ошибка при прерывании пайплайна: {str(e)}")
            logging.error(f"Error aborting pipeline for {job_url}: {e}")

async def start(update: Update, context: CallbackContext):
    """Отправка списка Jenkins Views как кнопок в Telegram."""
    if update.message.chat_id < 0:
        return  # Игнорируем сообщения из групповых чатов

    user_id = update.message.from_user.id
    username = update.message.from_user.username

    try:
        views = get_jenkins_views()
        if not views:
            await update.message.reply_text('Не удалось получить список представлений Jenkins.')
            return

        # Формируем клавиатуру с именами Views
        keyboard = [[view['name']] for view in views]
        reply_markup = ReplyKeyboardMarkup(keyboard, one_time_keyboard=True, resize_keyboard=True)
        await update.message.reply_text('Выберите раздел:', reply_markup=reply_markup)
        context.user_data['current_menu'] = 'views'  # Сохраняем текущее меню

        logging.info(f"Пользователь {username} (ID: {user_id}) запустил бота и получил список представлений.")

    except Exception as e:
        logging.error(f"Исключение в обработчике start: {e}")
        await update.message.reply_text('Произошла ошибка. Пожалуйста, попробуйте позже.')

async def handle_message(update: Update, context: CallbackContext):
    """Обработка сообщений и запуск Job."""
    if update.message.chat_id < 0:
        return  # Игнорируем сообщения из групповых чатов

    user_id = update.message.from_user.id
    username = update.message.from_user.username

    user_choice = update.message.text
    current_menu = context.user_data.get('current_menu')

    # Если сообщение не в 'views' и 'jobs', возвращаем в главное меню
    if current_menu not in ['views', 'jobs']:
        await start(update, context)
        return
    
    try:
        if current_menu == 'views':
            # Обработка выбора view
            jobs = get_jenkins_jobs(user_choice)
            if not jobs:
                await update.message.reply_text(f'В представлении {user_choice} не найдено заданий.')
                logging.info(f"Пользователь {username} (ID: {user_id}) выбрал представление {user_choice}, но задания не найдены.")
                return

            # Формируем клавиатуру с именами Jobs и кнопкой "Назад"
            keyboard = [[job['name']] for job in jobs]
            keyboard.append(['Back'])  # Добавляем кнопку "Назад" только в меню Jobs

            reply_markup = ReplyKeyboardMarkup(keyboard, one_time_keyboard=True, resize_keyboard=True)
            await update.message.reply_text(f'Раздел {user_choice}:', reply_markup=reply_markup)
            context.user_data['current_menu'] = 'jobs'
            context.user_data['selected_view'] = user_choice

            logging.info(f"Пользователь {username} (ID: {user_id}) выбрал представление {user_choice} и получил список заданий.")

        elif current_menu == 'jobs':
            if user_choice == 'Back':
                # Возвращаемся в главное меню
                await start(update, context)
                logging.info(f"Пользователь {username} (ID: {user_id}) выбрал вернуться в главное меню.")
                return

            job_name = user_choice
            chat_id = update.message.chat_id

            # Определяем URL для запуска Job
            job_url = f'{JENKINS_URL}/job/{job_name}'
            url_with_chat_id = f'{job_url}/buildWithParameters?chat_id={chat_id}'
            url_without_chat_id = f'{job_url}/build'

            auth = (JENKINS_USER, JENKINS_API_TOKEN)
            try:
                # Попытка запуска Job с параметром chat_id
                response = requests.post(url_with_chat_id, auth=auth)
                response.raise_for_status()
                await update.message.reply_text(f'{job_name} запущена успешно!')
                logging.info(f"Пользователь {username} (ID: {user_id}) запустил задание {job_name} с chat_id {chat_id}.")

                # Отправляем сообщение с кнопками для управления пайплайном
                await send_inline_keyboard(update, context, 
                    "Сборка приостановлена. Необходимо создать внешнюю обработку, удалить Helix и fresh, выгрузить идентификатор", 
                    job_url)

            except requests.HTTPError as e:
                if response.status_code == 404:
                    # Ошибка 404 - возвращаемся в главное меню
                    await start(update, context)
                    logging.error(f"Ошибка 404 при запуске задания {job_name}. Возвращаемся в главное меню.")
                elif response.status_code == 500:
                    # Ошибка 500 - пробуем запустить Job без параметра chat_id
                    try:
                        response = requests.post(url_without_chat_id, auth=auth)
                        response.raise_for_status()
                        await update.message.reply_text(f'{job_name} запущена успешно без параметра chat_id!')
                        logging.info(f"Пользователь {username} (ID: {user_id}) запустил задание {job_name} без chat_id.")

                        # Отправляем сообщение с кнопками для управления пайплайном
                        await send_inline_keyboard(update, context, 
                            "Сборка приостановлена. Необходимо создать внешнюю обработку, удалить Helix и fresh, выгрузить идентификатор", 
                            job_url)
                    except requests.RequestException as e:
                        logging.error(f"Ошибка запуска задания {job_name} без chat_id: {e}")
                        await update.message.reply_text(f'Ошибка при запуске {job_name}. Ошибка: {e}')
                else:
                    logging.error(f"Ошибка запуска задания {job_name}: {e}")
                    await update.message.reply_text(f'Ошибка при запуске {job_name}. Ошибка: {e}')
                return
            
    except Exception as e:
        logging.error(f"Исключение в обработчике handle_message: {e}")
        await update.message.reply_text('Произошла ошибка. Пожалуйста, попробуйте позже.')

def main():
    """Основная функция для запуска бота."""
    application = Application.builder().token(TOKEN).build()

    # Обработчики команд, сообщений и callback'ов
    application.add_handler(CommandHandler('start', start))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_message))
    application.add_handler(CallbackQueryHandler(handle_button))

    # Запуск бота
    logging.info('Бот запущен...')
    application.run_polling()

if __name__ == '__main__':
    main()