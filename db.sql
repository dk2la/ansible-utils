create table bot_session(
    id integer primary key,
    prev_action varchar(50),
    curr_action varchar(50),
    next_action varchar(50),
    created_at timestamp default current_timestamp not null
);

create table bot_user(
    id integer primary key,
    telegram_id bigint unique default 1,
    bot_session_id bigint not null,
    created_at timestamp default current_timestamp not null,
    foreign key (bot_session_id) references bot_session(id)
);

-- insert into bot_session(prev_action, curr_action, next_action) values ("None", "None", "None");
-- insert into bot_session(prev_action, curr_action, next_action) values ("None", "None", "None");
-- insert into bot_session(prev_action, curr_action, next_action) values ("None", "None", "None");
-- insert into bot_session(prev_action, curr_action, next_action) values ("None", "None", "None");
-- insert into bot_session(prev_action, curr_action, next_action) values ("None", "None", "None");

-- -- insert into bot_user(telegram_id, bot_session_id) values(2, 1);
-- insert into bot_user(telegram_id, bot_session_id) values(1, 2);
-- insert into bot_user(telegram_id, bot_session_id) values(3, 3);
-- insert into bot_user(telegram_id, bot_session_id) values(4, 4);
-- insert into bot_user(telegram_id, bot_session_id) values(5, 5);