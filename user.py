from dataclasses import dataclass
from datetime import datetime

import aiosqlite

@dataclass
class User:
    id: int
    telegram_id: int
    bot_session_id: int
    created_at: datetime

async def create_user(telegram_id: int) -> None:
    async with aiosqlite.connect("db.sqlite3") as db:
        await db.execute(f"insert into bot_user(telegram_id, bot_session_id) values ({telegram_id}, {telegram_id})")
        await db.commit()
        
async def get_user_by_id(telegram_id: int) -> User:
    user = User
    async with aiosqlite.connect("db.sqlite3") as db:
        db.row_factory = aiosqlite.Row
        async with db.execute(f"select * from bot_user where telegram_id = {telegram_id}") as cursor:
            async for row in cursor:
                user = (User(
                    id=row["id"],
                    telegram_id=row["telegram_id"],
                    bot_session_id=row["bot_session_id"],
                    created_at=row["created_at"]
                ))
    return user
