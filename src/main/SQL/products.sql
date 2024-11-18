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

INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (1, 'iPhone 16', 'The latest iPhone 16 with advanced features and improved performance.', 1199.99, 50, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (2, 'Samsung Galaxy S24', 'Samsung Galaxy S24 with excellent camera and battery life.', 999.99, 40, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (3, 'Dell XPS 13', 'A powerful ultrabook laptop with 16GB RAM and 512GB SSD.', 1399.99, 30, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (4, 'Sony 4K Ultra HD TV', 'Sony 65-inch 4K Ultra HD Smart LED TV with HDR support.', 799.99, 20, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (5, 'Bose Noise Cancelling Headphones', 'Premium over-ear headphones with noise cancelling technology.', 299.99, 100, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (6, 'Nike Air Max Shoes', 'Comfortable and stylish Nike Air Max shoes for running and casual wear.', 149.99, 75, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (7, 'Adidas Sports Jacket', 'Adidas lightweight sports jacket for outdoor activities.', 79.99, 60, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (8, 'Philips Air Fryer', 'Philips 4.5L Air Fryer for healthy and quick cooking.', 129.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (9, 'Apple Watch Series 9', 'Apple Watch Series 9 with fitness tracking and heart rate monitoring.', 399.99, 45, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (10, 'Lenovo IdeaPad 3', 'Lenovo IdeaPad 3 laptop with 8GB RAM and 256GB SSD.', 549.99, 35, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (11, 'Dyson V12 Vacuum Cleaner', 'Dyson cordless vacuum cleaner with powerful suction and easy maneuverability.', 499.99, 15, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (12, 'Canon EOS R10 Camera', 'Canon mirrorless camera with 24.2 MP and 4K video recording.', 1199.99, 10, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (13, 'LG Smart Refrigerator', 'LG double-door smart refrigerator with WiFi connectivity.', 1499.99, 8, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (14, 'Sony PlayStation 5', 'Sony PlayStation 5 gaming console with a 1TB SSD.', 499.99, 20, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (15, 'Samsung Galaxy Tab S8', 'Samsung Galaxy Tab S8 with 128GB storage and 11-inch display.', 649.99, 25, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (16, 'iPhone 16', 'The latest iPhone 16 with advanced features and improved performance.', 1199.99, 50, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (17, 'Samsung Galaxy S24', 'Samsung Galaxy S24 with excellent camera and battery life.', 999.99, 40, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (18, 'Dell XPS 13', 'A powerful ultrabook laptop with 16GB RAM and 512GB SSD.', 1399.99, 30, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (19, 'Sony 4K Ultra HD TV', 'Sony 65-inch 4K Ultra HD Smart LED TV with HDR support.', 799.99, 20, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (20, 'Bose Noise Cancelling Headphones', 'Premium over-ear headphones with noise cancelling technology.', 299.99, 100, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (21, 'Nike Air Max Shoes', 'Comfortable and stylish Nike Air Max shoes for running and casual wear.', 149.99, 75, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (22, 'Adidas Sports Jacket', 'Adidas lightweight sports jacket for outdoor activities.', 79.99, 60, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (23, 'Philips Air Fryer', 'Philips 4.5L Air Fryer for healthy and quick cooking.', 129.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (24, 'Apple Watch Series 9', 'Apple Watch Series 9 with fitness tracking and heart rate monitoring.', 399.99, 45, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (25, 'Lenovo IdeaPad 3', 'Lenovo IdeaPad 3 laptop with 8GB RAM and 256GB SSD.', 549.99, 35, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (26, 'Dyson V12 Vacuum Cleaner', 'Dyson cordless vacuum cleaner with powerful suction and easy maneuverability.', 499.99, 15, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (27, 'Canon EOS R10 Camera', 'Canon mirrorless camera with 24.2 MP and 4K video recording.', 1199.99, 10, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (28, 'LG Smart Refrigerator', 'LG double-door smart refrigerator with WiFi connectivity.', 1499.99, 8, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (29, 'Sony PlayStation 5', 'Sony PlayStation 5 gaming console with a 1TB SSD.', 499.99, 20, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (30, 'Samsung Galaxy Tab S8', 'Samsung Galaxy Tab S8 with 128GB storage and 11-inch display.', 649.99, 25, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (31, 'Smartphone X', 'The latest model with all the modern features.', 699.99, 50, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (32, 'Laptop Pro', 'Powerful laptop for professionals with high performance needs.', 1299.99, 30, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (33, 'Bluetooth Headphones', 'Noise-cancelling over-ear headphones with great sound quality.', 149.99, 100, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (34, '4K TV', 'High-definition smart TV with vibrant colors and streaming support.', 899.99, 20, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (35, 'Air Conditioner', 'Efficient air conditioning system for cooling during summer.', 499.99, 15, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (36, 'Microwave Oven', 'Stainless steel microwave with various cooking options.', 199.99, 35, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (37, 'Refrigerator', 'Large capacity refrigerator with energy-efficient design.', 699.99, 10, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (38, 'T-Shirt', 'Comfortable cotton T-shirt available in multiple colors.', 19.99, 200, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (39, 'Jeans', 'Classic denim jeans with a regular fit.', 39.99, 150, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (40, 'Sneakers', 'Stylish and comfortable sneakers for everyday wear.', 59.99, 100, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (41, 'Dress', 'Elegant evening dress suitable for special occasions.', 89.99, 50, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (42, 'Fiction Book', 'Bestselling novel by a popular author.', 14.99, 80, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (43, 'Science Book', 'Informative book about the wonders of science.', 24.99, 40, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (44, 'Cooking Guide', 'Learn how to cook amazing dishes with this cookbook.', 29.99, 60, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (45, 'Electric Kettle', 'Fast-boiling electric kettle with auto shut-off.', 34.99, 80, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (46, 'Gaming Console', 'The latest gaming console with powerful performance.', 499.99, 25, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (47, 'Office Chair', 'Ergonomic office chair for maximum comfort during work.', 149.99, 40, 'Furniture');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (48, 'Coffee Table', 'Stylish wooden coffee table with a modern look.', 99.99, 30, 'Furniture');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (49, 'Yoga Mat', 'Non-slip yoga mat ideal for workouts.', 25.99, 100, 'Fitness');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (50, 'Dumbbells Set', 'Adjustable dumbbells for your home workout needs.', 89.99, 60, 'Fitness');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (51, 'Running Shoes', 'Lightweight running shoes for jogging and exercise.', 79.99, 70, 'Fitness');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (52, 'Electric Guitar', 'Beginner-friendly electric guitar with a classic look.', 199.99, 10, 'Musical Instruments');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (53, 'Drum Set', 'Full-size drum set for beginners and professionals alike.', 599.99, 5, 'Musical Instruments');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (54, 'Violin', 'Acoustic violin with case, perfect for learning to play.', 149.99, 15, 'Musical Instruments');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (55, 'Action Camera', 'Compact action camera for capturing adventures.', 149.99, 20, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (56, 'Digital Camera', 'DSLR camera with professional-grade photo quality.', 799.99, 12, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (57, 'Winter Jacket', 'Warm and comfortable jacket for cold weather.', 99.99, 40, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (58, 'Sneakers', 'High-performance sneakers for running.', 69.99, 80, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (59, 'Electric Heater', 'Portable electric heater with adjustable settings.', 45.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (60, 'Fan', 'Quiet and efficient table fan for hot days.', 29.99, 50, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (61, 'Vacuum Cleaner', 'Cordless vacuum cleaner for home cleaning.', 149.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (62, 'Novel Set', 'Set of popular fiction novels.', 39.99, 20, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (63, 'Science Fiction Book', 'A thrilling journey through space and time.', 19.99, 35, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (64, 'Fantasy Book', 'An epic adventure in a magical world.', 24.99, 20, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (65, 'Men\'s Watch', 'Classic analog watch for men.', 119.99, 30, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (66, 'Women\'s Handbag', 'Stylish handbag for everyday use.', 59.99, 40, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (67, 'Table Lamp', 'Elegant table lamp for reading.', 29.99, 50, 'Home Decor');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (68, 'Wall Clock', 'Decorative wall clock with a classic design.', 49.99, 25, 'Home Decor');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (69, 'Camping Tent', '4-person tent for outdoor adventures.', 89.99, 10, 'Outdoor');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (70, 'Sleeping Bag', 'Warm sleeping bag for camping.', 59.99, 20, 'Outdoor');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (71, 'Backpack', 'Durable backpack for travel and school.', 39.99, 70, 'Outdoor');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (72, 'Mountain Bike', 'High-quality mountain bike for outdoor trails.', 399.99, 5, 'Fitness');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (73, 'Soccer Ball', 'Standard size soccer ball for matches and practice.', 19.99, 60, 'Sports');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (74, 'Tennis Racket', 'Lightweight racket for playing tennis.', 59.99, 30, 'Sports');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (75, 'Laptop A1', 'High performance laptop for work and entertainment.', 899.99, 50, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (76, 'Smartphone B2', 'Latest model with advanced features.', 499.99, 100, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (77, 'Headphones C3', 'Noise-cancelling headphones for immersive sound.', 149.99, 75, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (78, 'Smartwatch D4', 'Fitness and health monitoring smartwatch.', 199.99, 120, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (79, 'Camera E5', 'Digital camera with 4K video recording.', 299.99, 30, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (80, 'Microwave Oven F1', 'Efficient microwave oven for fast cooking.', 79.99, 40, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (81, 'Refrigerator G2', 'Double door refrigerator with ample storage.', 699.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (82, 'Blender H3', 'Multi-purpose blender for smoothies and juices.', 39.99, 60, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (83, 'Air Conditioner I4', 'Split AC for effective cooling.', 349.99, 20, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (84, 'Vacuum Cleaner J5', 'Handheld vacuum cleaner for home cleaning.', 89.99, 50, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (85, 'Jeans K1', 'Comfortable denim jeans for everyday wear.', 29.99, 100, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (86, 'T-shirt L2', 'Cotton T-shirt available in multiple colors.', 14.99, 150, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (87, 'Sneakers M3', 'Stylish sneakers for casual outings.', 59.99, 80, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (88, 'Dress N4', 'Elegant dress suitable for parties.', 49.99, 60, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (89, 'Jacket O5', 'Warm winter jacket for cold weather.', 79.99, 40, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (90, 'Novel P1', 'Bestselling fiction novel.', 9.99, 200, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (91, 'Cookbook Q2', 'Delicious recipes for everyday cooking.', 19.99, 90, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (92, 'Textbook R3', 'Science textbook for advanced learners.', 59.99, 30, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (93, 'Biography S4', 'Inspiring life story of a famous personality.', 14.99, 80, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (94, 'Children\'s Book T5', 'Illustrated book for young readers.', 12.99, 100, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (95, 'Bluetooth Speaker U1', 'Portable speaker with powerful sound.', 34.99, 70, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (96, 'Smart Thermostat V2', 'Smart thermostat for home temperature control.', 139.99, 40, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (97, 'Tablet W3', 'High-resolution tablet for multimedia.', 299.99, 35, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (98, 'Washing Machine X4', 'Front-loading washing machine.', 499.99, 15, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (99, 'Coffee Maker Y5', 'Automatic coffee maker for quick brewing.', 59.99, 45, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (100, 'Formal Shirt Z1', 'Long sleeve formal shirt for office wear.', 24.99, 80, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (101, 'Sunglasses A6', 'UV protection sunglasses.', 19.99, 120, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (102, 'Fitness Tracker B7', 'Track your steps, calories, and sleep.', 49.99, 90, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (103, 'Electric Kettle C8', 'Fast boiling electric kettle.', 24.99, 60, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (104, 'Gaming Mouse D9', 'Precision gaming mouse with RGB lights.', 29.99, 70, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (105, 'Office Chair E10', 'Ergonomic office chair for comfort.', 129.99, 20, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (106, 'Backpack F11', 'Spacious backpack for school or travel.', 39.99, 100, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (107, 'Wrist Watch G12', 'Luxury wristwatch for men.', 199.99, 15, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (108, 'Toaster H13', 'Two-slice toaster with browning control.', 19.99, 50, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (109, 'Sofa Set I14', 'Comfortable 3-seater sofa.', 499.99, 10, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (110, 'Kitchen Knife Set J15', 'Stainless steel kitchen knife set.', 39.99, 50, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (111, 'Board Game K16', 'Classic family board game.', 24.99, 40, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (112, 'Wireless Charger L17', 'Fast wireless charging pad.', 19.99, 80, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (113, 'Yoga Mat M18', 'Non-slip yoga mat for exercise.', 14.99, 100, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (114, 'Electric Drill N19', 'Cordless electric drill for home repairs.', 49.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (115, 'Cookware Set O20', 'Non-stick cookware set for the kitchen.', 69.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (116, 'LED Lamp P21', 'Desk lamp with adjustable brightness.', 14.99, 80, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (117, 'Printer Q22', 'All-in-one printer for home office.', 129.99, 25, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (118, 'Bicycle Helmet R23', 'Safety helmet for cycling.', 29.99, 50, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (119, 'Running Shoes S24', 'Comfortable running shoes for jogging.', 79.99, 60, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (120, 'Handbag T25', 'Elegant handbag for women.', 49.99, 40, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (121, 'E-reader U26', 'E-book reader with glare-free screen.', 89.99, 25, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (122, 'Table Fan V27', 'Portable table fan for cooling.', 19.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (123, 'Wireless Earbuds W28', 'True wireless earbuds with charging case.', 59.99, 70, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (124, 'Camping Tent X29', '2-person camping tent for outdoor adventures.', 79.99, 20, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (125, 'Garden Hose Y30', 'Flexible garden hose for watering.', 24.99, 60, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (126, 'Floor Lamp Z31', 'Modern floor lamp for living room.', 39.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (127, 'Espresso Machine A32', 'Home espresso coffee machine.', 149.99, 15, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (128, 'Digital Thermometer B33', 'Digital thermometer for accurate readings.', 9.99, 100, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (129, 'Wireless Keyboard C34', 'Compact wireless keyboard.', 29.99, 45, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (130, 'Photo Album D35', 'Classic photo album for storing memories.', 12.99, 50, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (131, 'Suitcase E36', 'Lightweight suitcase for travel.', 59.99, 30, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (132, 'Hair Dryer F37', 'Compact hair dryer for quick drying.', 24.99, 40, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (133, 'Perfume G38', 'Luxury perfume for women.', 79.99, 25, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (134, 'Electric Toothbrush H39', 'Rechargeable electric toothbrush.', 39.99, 50, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (135, 'Dog Bed I40', 'Comfortable bed for pets.', 29.99, 35, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (136, 'Book Light J41', 'Clip-on book light for reading at night.', 9.99, 60, 'Books');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (137, 'Garden Chair K42', 'Outdoor garden chair for relaxation.', 24.99, 40, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (138, 'Winter Gloves L43', 'Warm gloves for winter.', 14.99, 70, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (139, 'Wireless Router M44', 'High-speed wireless internet router.', 59.99, 30, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (140, 'Smart Light Bulb N45', 'Dimmable smart LED bulb.', 14.99, 100, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (141, 'Ironing Board O46', 'Folding ironing board for clothes.', 29.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (142, 'Leather Wallet P47', 'Genuine leather wallet for men.', 19.99, 80, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (143, 'Food Processor Q48', 'Multi-function food processor for kitchen.', 89.99, 20, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (144, 'Electric Scooter R49', 'Electric scooter for adults.', 299.99, 10, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (145, 'Pressure Cooker S50', 'Stainless steel pressure cooker.', 49.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (146, 'Wireless Mouse T51', 'Ergonomic wireless mouse for laptop.', 14.99, 70, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (147, 'Lunch Box U52', 'Insulated lunch box for kids.', 12.99, 60, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (148, 'Electric Blanket V53', 'Warm electric blanket for winter.', 39.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (149, 'Bath Towel W54', 'Soft and absorbent bath towel.', 9.99, 100, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (150, 'Laptop Stand X55', 'Adjustable laptop stand for desk.', 19.99, 50, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (151, 'Shower Curtain Y56', 'Waterproof shower curtain.', 14.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (152, 'Car Vacuum Z57', 'Portable car vacuum cleaner.', 29.99, 40, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (153, 'Fishing Rod A58', 'Telescopic fishing rod for outdoor fishing.', 49.99, 20, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (154, 'Kitchen Timer B59', 'Digital timer for cooking.', 9.99, 70, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (155, 'Massage Gun C60', 'Percussion massage gun for muscle relief.', 99.99, 15, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (156, 'Baby Stroller D61', 'Lightweight stroller for infants.', 149.99, 10, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (157, 'Egg Boiler E62', 'Electric egg boiler for quick breakfasts.', 19.99, 35, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (158, 'Mosquito Net F63', 'Portable mosquito net for beds.', 12.99, 60, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (159, 'Fridge Magnet G64', 'Decorative fridge magnet.', 4.99, 120, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (160, 'Ice Cream Maker H65', 'Home ice cream maker.', 59.99, 15, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (161, 'Home Theater System I66', '5.1 channel home theater system.', 199.99, 10, 'Electronics');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (162, 'Frying Pan J67', 'Non-stick frying pan for cooking.', 19.99, 50, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (163, 'Sleeping Bag K68', 'Sleeping bag for camping.', 29.99, 20, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (164, 'Wine Glass Set L69', 'Set of 6 wine glasses.', 24.99, 30, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (165, 'Travel Pillow M70', 'Comfortable travel neck pillow.', 9.99, 60, 'Fashion');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (166, 'Electric Griddle N71', 'Non-stick electric griddle for cooking.', 34.99, 25, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (167, 'Cocktail Shaker O72', 'Stainless steel cocktail shaker.', 14.99, 45, 'Appliances');
INSERT INTO ds_database.products (id, name, description, price, stock, category) VALUES (168, 'Pet Carrier P73', 'Portable pet carrier for small animals.', 39.99, 20, 'Fashion');
