create table orders
(
    order_id         int auto_increment
        primary key,
    user_id          int                                null,
    order_date       datetime default CURRENT_TIMESTAMP null,
    shipping_address varchar(255)                       null,
    payment_method   varchar(50)                        null,
    constraint orders_ibfk_1
        foreign key (user_id) references users (id)
);

create index user_id
    on orders (user_id);

INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (6, 10, '2024-11-14 19:03:43', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (7, 10, '2024-11-15 20:19:53', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (8, 11, '2024-11-15 20:57:22', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (9, 11, '2024-11-17 11:31:56', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (10, 11, '2024-11-18 16:58:13', 'Beijingjiaotong', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (11, 11, '2024-11-18 16:59:14', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (12, 11, '2024-11-18 17:14:29', '1234', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (13, 11, '2024-11-18 19:29:09', 'beijiao', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (14, 11, '2024-11-18 21:13:30', '长沙明德中学', 'credit-card');
