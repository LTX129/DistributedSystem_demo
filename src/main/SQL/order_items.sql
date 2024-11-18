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

INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (8, 6, 93, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (9, 6, 81, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (10, 6, 104, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (11, 7, 90, 2);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (12, 7, 38, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (13, 7, 40, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (14, 7, 66, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (15, 8, 143, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (16, 9, 59, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (17, 9, 119, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (18, 9, 18, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (19, 9, 120, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (20, 10, 19, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (21, 10, 50, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (22, 10, 168, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (23, 11, 158, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (24, 11, 40, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (25, 12, 158, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (26, 12, 40, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (27, 13, 59, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (28, 13, 29, 1);
INSERT INTO ds_database.order_items (order_item_id, order_id, product_id, quantity) VALUES (29, 14, 139, 1);
