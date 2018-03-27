USE [master];

DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('HotelReservationDB')

EXEC(@kill);

if exists (select * from sysdatabases where name='HotelReservationDB')
		drop database HotelReservationDB
GO

CREATE DATABASE HotelReservationDB
GO

USE HotelReservationDB
GO

CREATE TABLE RoomTypes (
	TypeID NVARCHAR(5) PRIMARY KEY,
	TypeName NVARCHAR(50) NOT NULL
)

CREATE TABLE Rooms (
	RoomNum INT PRIMARY KEY, --All room numbers should be unique and represent the floor they are on 233 (Floor 2 Room 33)
	FloorNum INT NOT NULL,
	TypeID NVARCHAR(5) FOREIGN KEY REFERENCES RoomTypes(TypeID) NOT NULL,
	Occupancy INT NOT NULL 
)

CREATE TABLE Amenities (
	AmenityID INT PRIMARY KEY IDENTITY(1,1),
	Description NVARCHAR(30) NOT NULL
)


CREATE TABLE RoomAmenities ( --Bridge--
	RoomNum INT FOREIGN KEY REFERENCES Rooms(RoomNum) NOT NULL,
	AmenityID INT FOREIGN KEY REFERENCES Amenities(AmenityID) NOT NULL
)

CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(35) NOT NULL,
	LastName NVARCHAR(35) NOT NULL,
	Email NVARCHAR(60), --Don't require an email because it could be fake
	Phone NVARCHAR(50) NOT NULL, --Must provide phone number 
	Phone2 NVARCHAR(50) -- For second contact point 
)

CREATE TABLE Promotions (
	PromotionCode NCHAR(6) PRIMARY KEY, --ex. FL1830(fall 2018 30% off), SB1999(Spring Break 2019 $99 off)
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	Discount DECIMAL(4,2), --Discounts up to 0.00 - 9999.99, ex.TSTW20(Two Suites Two Weeks $2000 Off ) <--Sweet Deal
	DiscountType NVARCHAR(100) NOT NULL --Could be % or $ based OR perks like Free Gym Access/Water Park Passes/Bike Rental/etc.
)

CREATE TABLE Reservations(
	ReservationID INT PRIMARY KEY IDENTITY(1,1),
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID) NOT NULL,
	CheckIn DATETIME2 NOT NULL, --Want both date and time of day 
	CheckOut DATETIME2 NOT NULL,
	PromotionCode NCHAR(6) FOREIGN KEY REFERENCES Promotions(PromotionCode)
)

CREATE TABLE ReservationRooms ( --Bridge--
	ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID),
	RoomNum INT FOREIGN KEY REFERENCES Rooms(RoomNum)
)

CREATE TABLE Guests (
	GuestID INT PRIMARY KEY IDENTITY(1,1),
	ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID) NOT NULL, --Guest data should not be collected and stored for multiple reservations because of minor and privacy concerns.
	FirstName NVARCHAR(35) NOT NULL,
	LastName NVARCHAR(35) NOT NULL,
	Age TINYINT NOT NULL
)

CREATE TABLE Rates (
	RateID INT PRIMARY KEY IDENTITY(1,1),
	TypeID NVARCHAR(5) FOREIGN KEY REFERENCES RoomTypes(TypeID) NOT NULL,
	StartDate DATETIME2 NOT NULL, -- DATETIME2 because there could be special rates depending on the hour of the day 
	EndDate DATETIME2 NOT NULL,
	PriceDescription NVARCHAR(50) NOT NULL
)


CREATE TABLE AddOns (
	AddOnID INT PRIMARY KEY IDENTITY(1,1),
	TypeOf NVARCHAR(50) NOT NULL, -- Could be a lengthy description for a name
	StartDate DATETIME2 NOT NULL, --Time sensitive for things like Happy-Hour at the bar charged to the room
	EndDate DATETIME2 NOT NULL,
	Price DECIMAL(7,2) NOT NULL -- $0.00 - $9,999,999.99 because some people party! OR trash a room and cause major damage
)

CREATE TABLE ReservationAddOns ( --Bridge--
	AddOnID INT FOREIGN KEY REFERENCES AddOns(AddOnID) NOT NULL,
	ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID) NOT NULL
)

CREATE TABLE Billing (
	BillID INT PRIMARY KEY IDENTITY(1,1),
	ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID) NOT NULL,
	Total DECIMAL (10,2) NOT NULL DEFAULT 0, -- $0.00 - $9,999,999,999.99 For some money is but an object.
	Tax DECIMAL (9,2) NOT NULL DEFAULT 0 --Default 0 for total and tax for if the room is comp'd by mgmt
)

CREATE TABLE BillingDetails (
	BillID INT FOREIGN KEY REFERENCES Billing(BillID) NOT NULL,
	ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID) NOT NULL,
	AddOnID INT FOREIGN KEY REFERENCES AddOns(AddOnID),
	Price DECIMAL(7,2)
)