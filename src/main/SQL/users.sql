create table users
(
    id             int auto_increment
        primary key,
    username       varchar(50)                    not null,
    password       varchar(100)                   null,
    email          varchar(100)                   null,
    role           varchar(10) default 'customer' null,
    encrypted_data text                           null
);

INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (10, 'litongxuan', '$2a$10$NBYdd/zLYDsthz5zTgFksegjbCpUeacrh.due86dM3U0x1kVTprhO', '21722052@bjtu.edu.cn', 'customer', 'eQw1YG5OuCj04nOlPbsg5DactpvINDvHyYMDJD0HkeEMfiBVgBP4we0bkBtqIO1xtdWeTBwyu0JaaUp4G89yzOvNhP0OraftVQMu05L2nWa6uo1FHwjWs1yjq8YzUKqyX79sNfFcQm6rzr94oE/QNZj0OksFWFq4PTPHYiNGBIpRE4GIkRG4eBtRaoYzshBJijKirIoUrPs26iAMmEiMATbZ0Df5wlgW5sQwQTLxK6H/qSvCAKoeVz9N6rHJwCS92p5AZ7Vj4HwrWDKyYZeUgeO9RFphOeRPzVNMHZugF4Y5stlgRhwTEbwzmd6VG6rbnfiy9h+8VHycjFKlKuaIpA==');
INSERT INTO ds_database.users (id, username, password, email, role, encrypted_data) VALUES (11, 'litongxuan2', '$2a$10$b8LX5g7sD3qfHedpHRebw.RgkjxHglfp3pgmp3t3bvQpoyW0roFGu', '3028053662@qq.com', 'customer', 'Sensitive data like payment details');
