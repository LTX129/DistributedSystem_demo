create table encryption_keys
(
    id         int auto_increment
        primary key,
    key_name   varchar(50)                         not null,
    key_value  text                                not null,
    created_at timestamp default CURRENT_TIMESTAMP null
);

create table products
(
    id          int auto_increment
        primary key,
    name        varchar(100)   not null,
    description text           null,
    price       decimal(10, 2) not null,
    stock       int default 0  null,
    category    varchar(50)    not null
);

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

create index user_id
    on orders (user_id);

