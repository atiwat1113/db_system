-- drop table ridetransaction;
-- drop table subscriptiontransaction;
-- drop table topuptransaction;
-- drop table cardinfo;
-- drop table savedaddress;
-- drop table transactionrecord;
-- drop table ride;
-- drop table ridervehicle;
-- drop table vehicle;
-- drop table customersubscription;
-- drop table rider;
-- drop table customer;
-- drop table user;
-- drop table station;
-- drop table location;
-- drop table manager;
-- drop table subscriptioninfo;

create table if not exists User(
	user_ID char(8) primary key,
	username varchar(50) not null,
	password text not null,
	email varchar(100) not null unique,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	phone_num char(10) not null,
	user_type enum('customer','rider') not null
);

create table if not exists Location(
	location_ID char(8) primary key
);

create table if not exists Manager(
	manager_ID char(8) primary key,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    working_area varchar(64) not null,
    number_of_riders int unsigned not null default 0
);

create table if not exists Station(
	station_ID char(8) primary key,
    location_ID char(8) not null unique,
    manager_ID char(8) not null,
    name varchar(50) not null unique,
    number_of_riders int unsigned not null default 0,
    foreign key (location_ID) references Location(location_ID) on update cascade on delete restrict,
    foreign key (manager_ID) references Manager(manager_ID) on update cascade on delete restrict
);

create table if not exists Rider(
	user_ID char(8) primary key,
    station_ID char(8) not null,
    ref_no char(16) not null unique,
    citizen_ID char(13) not null unique,
    is_available boolean not null default true,
    rating float,
    cash_credit float not null default 0,
    foreign key (user_ID) references User(user_ID) on update cascade on delete cascade,
    foreign key (station_ID) references Station(station_ID) on update cascade on delete restrict,
    check(rating >= 1 and rating <= 5 ),
    check(cash_credit >= 0)
);

create table if not exists Customer(
	user_ID char(8) primary key,
    default_payment enum('cash','bank_transfer','credit_card') not null,
    foreign key (user_ID) references User(user_ID) on update cascade on delete cascade
);

create table if not exists CardInfo(
	card_number char(16) primary key,
    customer_ID char(8) not null,
    card_holder_name varchar(16) not null,
    expire_date char(4) not null,
    foreign key (customer_ID) references Customer(user_ID) on update cascade on delete cascade
);

create table if not exists SavedAddress(
	customer_ID char(8) not null,
    location_ID char(8) not null,
    name varchar(50) not null,
    foreign key (customer_ID) references Customer(user_ID) on update cascade on delete cascade,
    foreign key (location_ID) references Location(location_ID) on update cascade on delete restrict,
    constraint pk_SavedAddressID primary key (customer_ID, location_ID)
);

create table if not exists SubscriptionInfo(
	subscription_type char(8) primary key,
    name varchar(30) not null,
    price float not null,
    trips int unsigned not null,
    duration int unsigned not null,
    check (price >= 0)
);

create table if not exists CustomerSubscription(
	subscription_type char(8) not null,
    customer_ID char(8) not null,
    start_date date not null default(now()),
    end_date date not null,
    trips_left int unsigned not null,
    foreign key (subscription_type) references SubscriptionInfo(subscription_type) on update cascade on delete restrict,
    foreign key (customer_ID) references Customer(user_ID) on update cascade on delete cascade,
    constraint pk_CustomerSub primary key (subscription_type, customer_ID)
);

create table if not exists Vehicle(
	plate_number varchar(16) primary key,
    model varchar(50) not null,
    color varchar(16) not null
);

create table if not exists RiderVehicle(
	vehicle_ID char(8) primary key,
    rider_ID char(8) not null,
    plate_number varchar(16) not null unique,
    foreign key (rider_ID) references Rider(user_ID) on update cascade on delete cascade,
    foreign key (plate_number) references Vehicle(plate_number) on update cascade on delete cascade
);

create table if not exists Ride(
	ride_ID char(8) primary key,
    customer_ID char(8),
    rider_ID char(8),
    status enum('matching','matched','cancelled','in_transit','arrived','paid','reviewing','completed') not null,
    start_latitude float not null,
    start_longitude float not null,
    stop_latitude float not null,
    stop_longitude float not null,
    distance float not null,
    start_time datetime not null default(now()),
    stop_time datetime,
    review_rating smallint,
    review_comment text,
    foreign key (rider_ID) references Rider(user_ID) on update cascade on delete set null,
    foreign key (customer_ID) references Customer(user_ID) on update cascade on delete set null,
    check(distance >= 0),
    check(review_rating >= 1 and review_rating <= 5),
    check(start_latitude >= -90 and start_latitude <= 90),
    check(start_longitude >= -180 and start_longitude <= 180),
    check(stop_latitude >= -90 and stop_latitude <= 90),
    check(stop_longitude >= -180 and stop_longitude <= 180)
);

create table if not exists TransactionRecord(
	transaction_ID char(8) primary key,
    type enum('top-up','subscription','ride') not null,
    timestamp timestamp not null default(now()),
    status enum('pending','success','declined') not null,
    amount float not null default 0,
    payment_method enum('cash','bank_transfer','credit_card') not null,
    check(amount >=0)
);

create table if not exists TopUpTransaction(
	transaction_ID char(8) primary key,
    rider_ID char(8) not null,
    foreign key (transaction_ID) references TransactionRecord(transaction_ID) on update cascade on delete cascade,
    foreign key (rider_ID) references Rider(user_ID) on update cascade on delete cascade
);

create table if not exists SubscriptionTransaction(
	transaction_ID char(8) primary key,
    customer_ID char(8) not null,
    foreign key (transaction_ID) references TransactionRecord(transaction_ID) on update cascade on delete cascade,
    foreign key (customer_ID) references Customer(user_ID) on update cascade on delete cascade
    
);

create table if not exists RideTransaction(
	transaction_ID char(8) primary key,
    ride_ID char(8) not null,
    foreign key (transaction_ID) references TransactionRecord(transaction_ID) on update cascade on delete cascade,
    foreign key (ride_ID) references Ride(ride_ID) on update cascade on delete cascade
);