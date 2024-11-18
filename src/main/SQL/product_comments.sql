create table product_comments
(
    id         int auto_increment
        primary key,
    product_id int                                 not null,
    user_id    int                                 not null,
    comment    text                                not null,
    rating     int                                 not null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint product_comments_ibfk_1
        foreign key (product_id) references products (id),
    constraint product_comments_ibfk_2
        foreign key (user_id) references users (id)
);

create index product_id
    on product_comments (product_id);

create index user_id
    on product_comments (user_id);

INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (7, 93, 10, 'good', 5, '2024-11-14 19:03:55');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (8, 93, 10, 'I love it', 5, '2024-11-15 16:37:02');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (9, 66, 10, 'bad, terrible', 1, '2024-11-15 20:20:22');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (10, 143, 11, 'good', 5, '2024-11-15 20:57:42');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (11, 143, 11, 'I like this one', 5, '2024-11-16 16:18:56');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (12, 143, 11, 'test', 1, '2024-11-16 16:21:19');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (13, 143, 11, 'good', 4, '2024-11-17 11:43:05');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (14, 120, 11, 'terrible', 1, '2024-11-17 11:44:32');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (15, 143, 11, '66666', 5, '2024-11-18 16:52:32');
INSERT INTO ds_database.product_comments (id, product_id, user_id, comment, rating, created_at) VALUES (16, 139, 11, 'Very Useful', 5, '2024-11-18 21:17:47');
