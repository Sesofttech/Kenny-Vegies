--Drop database if it exists and recreate it--
--drop database if exists kenny_db;
--create database kenny_db;

--Drop tables if they exist and recreate them--
drop table if exists customers cascade;
drop table if exists cust_addresses cascade;
drop table if exists shipping_adds cascade;
drop table if exists products cascade;
drop table if exists suppliers cascade;
drop table if exists supplier_prices cascade;
drop table if exists stock cascade;
drop table if exists supplies cascade;
drop table if exists orders cascade;
drop table if exists billings cascade;
drop table if exists prices cascade;

--Table for customer details and registration--
create table customers(
	cust_id int not null, --customer's unique id--
	first_name varchar(100) not null,
	last_name varchar(100) not null,
	dob date not null, --date of birth--
	username varchar(50) not null unique, --customer's username--
	reg_date timestamp default clock_timestamp(), --Date customer registered--
	password varchar(30) not null,
	primary key (cust_id)	
);

--Table fo customer addresses--
create table cust_addresses(
	add_id serial, -- unique address identifier--
	cust_id int not null,  --customer associated with the address--
	phone bigint not null unique, --phone number for the customer--
	email varchar(255) not null unique, --customer's email address--
	postal_address varchar(255) default null,--customer's postal/physical address--
	postal_code int not null, --customer's postal/zip code--
	town varchar(100) not null, --customer's town location--
	city varchar(100) not null, --customer's city location--
	country varchar(100) not null, --customer's country location--
	add_date timestamp default clock_timestamp(), --Date customer registered the address--
	primary key (add_id),
	foreign key (cust_id) references customers (cust_id)
);

--Table for shipping addresses  for customers--
create table shipping_adds(
	ship_id int not null, --shipping unique identifier--
	cust_id int not null, --customer the order is shipped to--
	add_id serial, --customer's address as registered--
	phy_add varchar(255) not null, --customer's physial address--
	hse_number varchar(30), --residential address--
	ship_add_date timestamp default clock_timestamp(), --date the customer updated the shipping address--
	primary key (ship_id),
	foreign key (cust_id) references customers(cust_id),
	foreign key (add_id) references cust_addresses(add_id)	
);

--Table for products--
create table products(
	product_id varchar(50) not null, --product unique identifier--
	prod_name varchar(200) not null unique,
	prod_type varchar(100) not null, -- can be fresh, frozen, dried
	prod_desc text not null, --Description of the product--
	prod_date timestamp default clock_timestamp(), --the date when the product was registered--
	primary key (product_id)	
);

--Tables for registered suppliers for Kenny Vegies--
create table suppliers(
	sup_id varchar(50), --supplier id--
	prod_id varchar(50), --poduct id, registered product supplier supplies--
	sup_name varchar(255) not null,--supplier name--
	sup_phone bigint unique not null,--supplier phone number--
	sup_email varchar(255) unique not null,--supplier email address--
	postal_add varchar(255) not null,--supplier postal or physical address--
	postal_code int not null, --supplier postal/zip code--
	reg_date timestamp not null default clock_timestamp(), --date supplier registered with Kenny Vegies--
	primary key (sup_id),
	foreign key (prod_id) references products (product_id)
);

--Table for tracking what suppliers have supplied to Kenny Vegies--
create table supplies(
	supplies_id serial, --supplies id unique identification--
	sup_id varchar(50) not null, --the supplier who supplied--
	prod_id varchar(50) not null, --product supplied--
	supply_qty int not null, --quantity supplied--
	supply_date timestamp not null default clock_timestamp(), --date of supply--
	primary key (supplies_id),
	foreign key (sup_id) references suppliers (sup_id),
	foreign key (prod_id) references products (product_id)
);

--Table for wholesale prices for goods and products supplied to Kenny Vegies--
create table supplier_prices(
	prod_id varchar(50), --as registered product, PK, FK--
	supplier_id varchar(50) not null, --supplier id one supplying a product--
	unit_price numeric(13, 2) not null, --wholesale price--
	price_date date not null default clock_timestamp(), --date of the wholesale price update--
	primary key (prod_id),
	foreign key (prod_id) references products (product_id),
	foreign key (supplier_id) references suppliers (sup_id)
);

--Table for selling prices of goods and products at Kenny Vegies--
create table prices(
	product_id varchar(50) not null, --product id as registered in the products table--
	unit_price numeric(13,2) not null, --selling price for 1 unit--
	price_date timestamp not null default clock_timestamp(), --date the price was updated--
	primary key (product_id),
	foreign key (product_id) references products(product_id)
);

--Table for tracking stock levels of goods and products--
create table stock(
	stock_id serial, --stock unique identifier, auto incremented, PK--
	prod_id varchar(50) not null, --product id must be a registered product FK--
	stock_date timestamp not null default clock_timestamp(), --date when stock was updated--
	prod_qty int not null, --quantity remaining in stock --
	primary key (stock_id),
	foreign key (prod_id) references products(product_id)	
);

--Table for tracking customer orders--
create table orders(
	order_id bigserial, --order unique identifier, PK--
	cust_id int not null, --one who made the order, FK--
	prod_id varchar(50) not null, --id for the product purchased--
	prod_qty int not null, -- quantity of the product ordered--
	purchase_date timestamp not null default clock_timestamp(), --order date--
	primary key (order_id),
	foreign key (cust_id) references customers (cust_id),
	foreign key (prod_id) references products (product_id)
);

--Table for recording bill amounts for particular customers and orders--
create table billings(
	bill_id varchar(100), --bill id unique identifier, PK--
	cust_id int not null, --customer id associated with the bill--
	total_amt numeric(14,4) not null, --bill amount--
	bill_date timestamp not null default clock_timestamp(), --date when the bill was generated--
	primary key (bill_id),
	foreign key (cust_id) references customers (cust_id)
);

--Stored Procedures--
--Data validations and insertions--

create or replace procedure insert_customers(
	p_cust_id int,
	p_first_name varchar(100),
	p_last_name varchar(100),
	p_dob timestamp,
	p_username varchar(50),
	p_password varchar(30)
)
as $$
begin
	if p_cust_id is null then
		raise exception 'cust_id must have a value';
	end if;
	if p_first_name is null then
		raise exception 'first_name must have a value';
	end if;
	if p_last_name is null then
		raise exception 'last_name must have a value';
	end if;
	if p_dob is null then
		raise exception 'dob must have a value';
	end if;
	if p_username is null then
		raise exception 'username must have a value';
	end if;
	if p_password is null then
		raise exception 'password must have a value';
	end if;
	
	insert into customers(cust_id, first_name, last_name, dob, username, password)
	values(p_cust_id, p_first_name, p_last_name, p_dob, p_username, p_password);
end;
$$ language plpgsql;

create or replace procedure insert_cust_adds(
	a_cust_id int,
	a_phone bigint,
	a_email varchar(255),
	a_postal_address varchar(255),
	a_postal_code int,
	a_town varchar(100),
	a_city varchar(100),
	a_country varchar(100),
	out a_add_id integer
)
as $$
begin
	if a_cust_id is null then
		raise exception 'cust_id must have a value';
	end if;
	if a_phone is null then
		raise exception 'The phone number must have a value';
	end if;
	if a_email is null then
		raise exception 'email must have a value';
	end if;	
	if a_postal_code is null then
		raise exception 'postal_code must have value';
	end if;
	if a_town is null then
		raise exception 'town must have a value';
	end if;
	if a_city is null then
		raise exception 'city must have a value';
	end if;
	if a_country is null then
		raise exception 'country must have value';
	end if;
	
	insert into cust_addresses(cust_id, phone, email,postal_address, postal_code, town, city, country)
	values(a_cust_id, a_phone, a_email,a_postal_address, a_postal_code, a_town,a_city, a_country)
	returning add_id into a_add_id;
	
end;
$$ language plpgsql;

call insert_customers(300, 'Andrew', 'Makori', '2001-10-28', 'Makori', 'Makori');

do
$$
declare
	adds_id integer;
begin
	call insert_cust_adds(300, 0717234938, 'andre@kenny.co.ke',null,40300, 'Kj', 'Same', 'Kenya',adds_id);
	raise notice 'Address ID = %', adds_id;
end;
$$;

create or replace procedure insert_into_products(
	prod1_id varchar(50),
	prod1_name varchar(200),
	prod1_type varchar(100),
	prod1_desc text,
	prod1_date timestamp default clock_timestamp()
)
as $$
begin
	if prod1_id is null then
		raise exception 'product id must have a value';
	end if;
	if prod1_name is null then
		raise exception 'product name must have a value';
	if prod1_type is null then
		raise exception 'product type must have a value';
	if prod1_desc is null then
		raise exception 'product description must have a value';
	insert into products(product_id, prod_name, prod_type, prod_desc, prod_date) 
	values(prod1_id, prod1_name, prod1_type, prod1_desc,prod1_date);
end;
$$ language plpgsql;
	
select * from cust_addresses;

---call insert_customers(300, 'Andrew', 'Makori', '2001-10-28', 'Makori', 'Makori');
--select * from customers;