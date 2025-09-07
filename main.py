import os
from telethon import TelegramClient, events

# Load environment variables
API_ID = int(os.getenv("TG_API_ID"))
API_HASH = os.getenv("TG_API_HASH")
PHONE = os.getenv("TG_BOT_PHONE")
CHANNEL = os.getenv("TG_CHANNEL_USERNAME")

# Create Telegram client
client = TelegramClient("session_name", API_ID, API_HASH)

@client.on(events.NewMessage(chats=CHANNEL))
async def handler(event):
    print("📩 New signal received:")
    print(event.raw_text)  # prints the full signal text

async def main():
    print("🚀 Bot started... Listening for signals in", CHANNEL)
    await client.start(PHONE)
    await client.run_until_disconnected()

if __name__ == "__main__":
    import asyncio
    asyncio.run(main())
