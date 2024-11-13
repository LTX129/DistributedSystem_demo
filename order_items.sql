create table order_items
(
    order_item_id int auto_increment
        primary key,
    order_id      int null,
    product_id    int null,
    quantity      int null,
    constraint order_items_ibfk_1
        foreign key (order_id) references orders (order_id),
    constraint order_items_ibfk_2
        foreign key (product_id) references products (id)
);

create index order_id
    on order_items (order_id);

create index product_id
    on order_items (product_id);

INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (1, 1, 100, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (2, 2, 33, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (3, 2, 163, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (4, 2, 88, 3);
