import logging
from telegram import Update
from telegram.ext import filters, MessageHandler, ApplicationBuilder, CommandHandler, ContextTypes
from user import *

BOT_TOKEN = "5936849864:AAF0tdOeiLoueLDcGiJCNzHT0h61nyxYljo"

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)

def logging_func(update: Update):
    logging.info("Message %s, \n--------------\n%s\n--------------\n", update.message.from_user.id, update)

async def help(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logging_func(update)
    await context.bot.send_message(chat_id=update.effective_chat.id, text="HELP command")
    await context.bot.deleteMessage(message_id=update.message.message_id, chat_id=update.effective_chat.id)

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logging_func(update)
    # await create_user(update.message.from_user.id)
    # user = await get_user_by_id(update.message.from_user.id)
    await context.bot.send_message(chat_id=update.effective_chat.id, text="START command")
    await context.bot.deleteMessage(message_id=update.message.message_id, chat_id=update.effective_chat.id)

async def description(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logging_func(update)
    await context.bot.send_message(chat_id=update.effective_chat.id, text="DESCRIPTION command")
    await context.bot.deleteMessage(message_id=update.message.message_id, chat_id=update.effective_chat.id)

async def payment(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logging_func(update)
    await context.bot.send_message(chat_id=update.effective_chat.id, text="PAYMENT command")
    await context.bot.deleteMessage(message_id=update.message.message_id, chat_id=update.effective_chat.id)

async def other_text(update: Update, context: ContextTypes.DEFAULT_TYPE):
    logging_func(update)
    await context.bot.send_message(chat_id=update.effective_chat.id, text="OTHER TEXT")
    await context.bot.deleteMessage(message_id=update.message.message_id, chat_id=update.effective_chat.id)

if __name__ == '__main__':
    application = ApplicationBuilder().token(BOT_TOKEN).build()

    start_handler = CommandHandler('start', start)
    application.add_handler(start_handler)

    help_handler = CommandHandler('help', help)
    application.add_handler(help_handler)

    description_handler = CommandHandler('description', description)
    application.add_handler(description_handler)

    payment_handler = CommandHandler('payment', payment)
    application.add_handler(payment_handler)

    other_text_handler = MessageHandler(filters.TEXT & (~filters.COMMAND), other_text)
    application.add_handler(other_text_handler)
    
    application.run_polling()