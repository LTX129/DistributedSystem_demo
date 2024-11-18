create table cart_items
(
    id         int auto_increment
        primary key,
    user_id    int                                 not null,
    product_id int                                 not null,
    quantity   int       default 1                 null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint cart_items_ibfk_1
        foreign key (user_id) references users (id),
    constraint cart_items_ibfk_2
        foreign key (product_id) references products (id)
);

create index product_id
    on cart_items (product_id);

create index user_id
    on cart_items (user_id);

INSERT INTO ds_database.cart_items (id, user_id, product_id, quantity, created_at) VALUES (4, 10, 66, 1, '2024-11-16 15:16:50');
INSERT INTO ds_database.cart_items (id, user_id, product_id, quantity, created_at) VALUES (5, 10, 137, 1, '2024-11-16 15:16:54');
INSERT INTO ds_database.cart_items (id, user_id, product_id, quantity, created_at) VALUES (28, 11, 139, 1, '2024-11-18 21:13:03');
