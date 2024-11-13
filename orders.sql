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

INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (1, 3, '2024-11-13 20:58:24', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
INSERT INTO ds_database.orders (order_id, user_id, order_date, shipping_address, payment_method) VALUES (2, 3, '2024-11-13 20:58:49', '4961 Woodbridge Lane,Southfield,Michigan', 'credit-card');
