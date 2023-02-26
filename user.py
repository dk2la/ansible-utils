from dataclasses import dataclass
from datetime import datetime

import aiosqlite

@dataclass
class User:
    id: int
    telegram_id: int
    bot_session_id: int
    created_at: datetime

@dataclass
class Session:
    id: int
    bot_session_id: int
    prev_action: str
    curr_action: str
    next_action: str
    """bot_session_id bigint unique default 1,
    prev_action varchar(50),
    curr_action varchar(50),
    next_action varchar(50),
    created_at timestamp default current_timestamp not null"""

async def create_user(telegram_id: int) -> None:
    test_str = "None"
    async with aiosqlite.connect("db.sqlite3") as db:
        await db.execute(f"insert into bot_session(bot_session_id) values({telegram_id})")
        await db.execute(f"insert into bot_user(telegram_id, bot_session_id) values ({telegram_id}, {telegram_id})")
        await db.commit()
        
async def get_user_by_id(telegram_id: int) -> User:
    user = User
    async with aiosqlite.connect("db.sqlite3") as db:
        db.row_factory = aiosqlite.Row
        async with db.execute(f"select * from bot_user where telegram_id = {telegram_id}") as cursor:
            async for row in cursor:
                user = User(
                    id=row["id"],
                    telegram_id=row["telegram_id"],
                    bot_session_id=row["bot_session_id"],
                    created_at=row["created_at"]
                )
    return user

async def get_user_session_by_id(telegram_id: int) -> Session:
    session = Session
    async with aiosqlite.connect("db.sqlite3") as db:
        db.row_factory = aiosqlite.Row
        async with db.execute(f"select * from bot_session where bot_session_id = {telegram_id}") as cursor:
            async for row in cursor:
                session = Session(
                    id=row["id"],
                    bot_session_id=row["bot_session_id"],
                    prev_action=row["prev_action"],
                    curr_action=row["curr_action"],
                    next_action=row["next_action"],
                )
    return session