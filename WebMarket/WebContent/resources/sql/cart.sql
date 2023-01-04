USE WebMarketDB;

create table cart ( 
	cartId varchar(100) not null,
	userId varchar(10) not null,
	productId varchar(100) not null,
    productName varchar(100) not null,
    price INTEGER
) default CHARSET=utf8;
