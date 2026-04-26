-- ============================================================
--  SWIGGY DATASET — AWS Data Engineering Course | Day 1 SQL
--  Keystone Edtech Pvt Ltd
--  Narrative: Arjun's first day analyzing Swiggy order data
-- ============================================================

-- TABLE 1: Customers
CREATE TABLE customers (
  customer_id   INT PRIMARY KEY,
  name          VARCHAR(100),
  city          VARCHAR(50),
  joined_date   DATE
);

INSERT INTO customers VALUES
  (1,  'Arjun Sharma',    'Bangalore', '2022-01-15'),
  (2,  'Priya Nair',      'Mumbai',    '2022-03-10'),
  (3,  'Rahul Verma',     'Delhi',     '2021-11-22'),
  (4,  'Sneha Reddy',     'Hyderabad', '2023-02-01'),
  (5,  'Kiran Mehta',     'Pune',      '2022-07-18'),
  (6,  'Ananya Das',      'Kolkata',   '2021-09-05'),
  (7,  'Vikram Iyer',     'Chennai',   '2023-04-12'),
  (8,  'Divya Pillai',    'Bangalore', '2022-12-30'),
  (9,  'Rohan Joshi',     'Mumbai',    '2021-06-14'),
  (10, 'Meera Krishnan',  'Hyderabad', '2023-01-08');

-- TABLE 2: Restaurants
CREATE TABLE restaurants (
  restaurant_id   INT PRIMARY KEY,
  name            VARCHAR(100),
  city            VARCHAR(50),
  cuisine         VARCHAR(50),
  rating          NUMERIC(2,1)
);

INSERT INTO restaurants VALUES
  (101, 'Biryani Blues',     'Bangalore', 'North Indian', 4.5),
  (102, 'Pizza Palace',      'Mumbai',    'Italian',      4.2),
  (103, 'Dosa Express',      'Hyderabad', 'South Indian', 4.7),
  (104, 'Burger Barn',       'Delhi',     'American',     3.9),
  (105, 'Sushi Station',     'Bangalore', 'Japanese',     4.3),
  (106, 'Chole Bhature Hub', 'Delhi',     'North Indian', 4.1),
  (107, 'Pav Bhaji King',    'Mumbai',    'Street Food',  4.6),
  (108, 'Idli House',        'Chennai',   'South Indian', 4.4),
  (109, 'Rolls & Wraps',     'Pune',      'Mughlai',      3.8),
  (110, 'Noodle Nook',       'Kolkata',   'Chinese',      4.0);

-- TABLE 3: Orders
CREATE TABLE orders (
  order_id      INT PRIMARY KEY,
  customer_id   INT,
  restaurant_id INT,
  order_date    DATE,
  total_amount  NUMERIC(8,2),
  status        VARCHAR(20),
  delivery_time INT   -- minutes
);

INSERT INTO orders VALUES
  (1001, 1,  101, '2024-01-05', 450.00,  'Delivered',  32),
  (1002, 2,  102, '2024-01-06', 620.00,  'Delivered',  45),
  (1003, 3,  104, '2024-01-06', 310.00,  'Cancelled',  NULL),
  (1004, 4,  103, '2024-01-07', 280.00,  'Delivered',  28),
  (1005, 1,  105, '2024-01-08', 890.00,  'Delivered',  50),
  (1006, 5,  109, '2024-01-08', 175.00,  'Delivered',  38),
  (1007, 6,  110, '2024-01-09', 230.00,  'Delivered',  42),
  (1008, 2,  107, '2024-01-10', 540.00,  'Delivered',  25),
  (1009, 7,  108, '2024-01-10', 190.00,  'Pending',    NULL),
  (1010, 8,  101, '2024-01-11', 670.00,  'Delivered',  35),
  (1011, 3,  106, '2024-01-11', 420.00,  'Delivered',  55),
  (1012, 9,  102, '2024-01-12', 760.00,  'Delivered',  40),
  (1013, 4,  103, '2024-01-12', 310.00,  'Delivered',  30),
  (1014, 10, 103, '2024-01-13', 395.00,  'Delivered',  27),
  (1015, 1,  101, '2024-01-14', 520.00,  'Delivered',  33),
  (1016, 5,  102, '2024-01-15', 480.00,  'Cancelled',  NULL),
  (1017, 6,  110, '2024-01-15', 215.00,  'Delivered',  44),
  (1018, 8,  105, '2024-01-16', 950.00,  'Delivered',  52),
  (1019, 9,  107, '2024-01-17', 330.00,  'Delivered',  29),
  (1020, 10, 103, '2024-01-18', 410.00,  'Delivered',  26);

-- TABLE 4: Order Items
CREATE TABLE order_items (
  item_id       INT PRIMARY KEY,
  order_id      INT,
  item_name     VARCHAR(100),
  quantity      INT,
  unit_price    NUMERIC(8,2)
);

INSERT INTO order_items VALUES
  (1, 1001, 'Chicken Biryani',     2, 180.00),
  (2, 1001, 'Raita',               1,  90.00),
  (3, 1002, 'Margherita Pizza',    1, 350.00),
  (4, 1002, 'Garlic Bread',        2, 135.00),
  (5, 1004, 'Hyderabadi Biryani',  1, 280.00),
  (6, 1005, 'Sushi Platter',       1, 650.00),
  (7, 1005, 'Miso Soup',           2, 120.00),
  (8, 1008, 'Pav Bhaji',           3, 140.00),
  (9, 1008, 'Butter',              1,  80.00),
  (10,1010, 'Chicken Biryani',     3, 180.00),
  (11,1010, 'Lassi',               2,  80.00),
  (12,1012, 'Veg Pizza',           2, 320.00),
  (13,1013, 'Mutton Biryani',      1, 310.00),
  (14,1014, 'Biryani Bowl',        1, 250.00),
  (15,1014, 'Cold Drink',          2,  72.50),
  (16,1015, 'Chicken Biryani',     2, 180.00),
  (17,1015, 'Butter Naan',         3,  53.33),
  (18,1018, 'Dragon Roll',         2, 380.00),
  (19,1018, 'Green Tea',           2,  95.00),
  (20,1020, 'Biryani Bowl',        2, 205.00);
