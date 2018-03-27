USE HotelReservationDB
GO 



INSERT INTO AddOns (TypeOf, StartDate, EndDate, Price)
	VALUES('Raunchy Movie', '3/10/2017', '1/1/2020', 14.35),
		('Room Service', '2/15/2017', '1/1/2020', 148.76),
		('Room Service', '2/15/2017', '1/1/2020', 303.76),
		('Premium Champange', '2/15/2017', '1/1/2020', 2516.66),
		('Bar Purchase', '12/25/2020', '12/26/2020', 103.45)


SELECT * FROM AddOns

--

INSERT INTO Amenities (Description)
	VALUES ('Hot Tub'),
		('Sofa Bed'),
		('Kitchen'),
		('Patio'),
		('Fireplace')
		

SELECT * FROM Amenities

--

INSERT INTO Customers(FirstName,LastName,Email,Phone,Phone2)
	VALUES('Cody','Larson','CLarson@aol.com','7535232', NULL),
		('Aaron','Virkus','virk@hottmill.com','7535547', NULL),
		('Jeremy','Hansom','Bassplayr@bass.org','7531184', NULL),
		('Pete','Cary',NULL,'421-2993', NULL),
		('Bill','Cheney','Billbls@apple.me','7545929','6125576823'),
		('Mike','Drangus','mikeD@d.com','2314965','2934040582')

SELECT * FROM Customers

--

INSERT INTO Promotions(PromotionCode,StartDate,EndDate,Discount,DiscountType)
	VALUES('TC5019', '06/23/2019', '06/24/2019', 50, '$50Off Room Service TechCon weekend'),
		('WINT19', '11/30/2019', '02/28/2019', 15, '15%off Room Rate Winter 2019'),
	('MEAK18', '10/10/2018', '10/14/2018', NULL, 'FREE Kids pool passes MEA Break 2018')

SELECT * FROM Promotions		

--

INSERT INTO Rates(StartDate,EndDate,PriceDescription)
	VALUES('1/1/2018', '12/31/2018','Regular 2018 Rate'),
		('1/1/2018', '12/31/2018','Slow Season 2018 Rate'),  
		('1/1/2018', '12/31/2018','Busy Season 2018 Rate'),
		('8/20/2018', '9/30/2018','Leaf Watching Season Rate')

SELECT * FROM Rates

--

INSERT INTO RoomTypes(TypeID,TypeName)
	VALUES('SM','Small'),
		('MD','Medium'),
		('LG','Large'),
		('S','Suite'),
		('P','Penhouse'),
		('U','UtilityFloor'),
		('PLG','Large Poolside'),
		('H','Honeymoon'),
		('LGB','Large Balcony'),
		('MDB','Medium Balcony'),
		('SMB','Small Balcony')


SELECT * FROM RoomTypes

--

INSERT INTO Rooms(RoomNum,FloorNum,RoomType,Occupancy)
	VALUES(101,1,'MD',6),
		(112,1,'LG',8),
		(103,1,'PLG',10),
		(120,1,'H',6),
		(202,2,'S',15),
		(209,2,'MD',6),
		(224,2,'SM',4),
		(320,3,'LGB',9),
		(304,3,'MDB',6),
		(314,3,'SMB',3),
		(400,4,'P',15),
		(401,4,'P',15),
		(002,0,'U',2)

SELECT * FROM Rooms

--RoomRates
INSERT INTO RoomRates(RateID,RoomNum,Price)
	VALUES(1,202,164.99),(2,202,140),(3,202,178.50),(4,202,184.99),
		(1,101,184.99),(2,101,74.99),(3,101,98.99),(4,101,110.00),
		(1,112,105.00),(2,112,99.99),(3,112,119.99),(4,112,127.50),
		(1,103,105.00),(2,103,99.99),(3,103,125.50),(4,103,129.99),
		(1,120,140.00),(2,120,134.99),(3,120,154.98),(4,120,160.50),
		(1,209,84.99),(2,209,74.99),(3,209,98.99),(4,209,110.00),
		(1,224,48.85),(2,224,40.00),(3,224,55.55),(4,224,58.99),
		(1,320,109.99),(2,320,99.99),(3,320,119.97),(4,320,125.00),
		(1,304,74.99),(2,304,60.00),(3,304,85.00),(4,304,89.99),
		(1,314,64.99),(2,314,40),(3,314,78.50),(4,314,84.99),
		(1,400,200.00),(2,400,185.99),(3,400,240.00),(4,400,250.00),
		(1,401,230.00),(2,401,199.99),(3,401,260.00),(4,401,299.99),
		(1,002,30.00),(2,002,24.99),(3,002,35.00),(4,002,40.00)
	
SELECT * FROM RoomRates

--

INSERT INTO RoomAmenities(RoomNum, AmenityID)
	VALUES(101,4),
		(112,1),
		(103,1),
		(103,2),
		(120,1),
		(120,5),
		(320,1),
		(320,3),
		(320,2),
		(304,2),
		(314,5),
		(400,1),
		(400,2),
		(400,3),
		(400,5),
		(401,1),
		(401,2),
		(401,3),
		(401,5)

SELECT * FROM RoomAmenities

--

SELECT * FROM Customers
SELECT * FROM Promotions
INSERT INTO Reservations(CustomerID,CheckIn,CheckOut,PromotionCode)
	VALUES(1,'4/12/2018','4/15/2018',NULL),
		(2,'12/20/2019','1/03/2019', NULL),
		(3,'06/23/2019','06/24/2019','TC5019'),
		(4,'12/03/2017','12/07/2019','WINT19'),
		(5,'10/11/2018','10/14/2018','MEAK18'),
		(6,'08/07/2018','08/14/2018',NULL),
		(2,'12/20/2020','1/03/2020', NULL)

SELECT * FROM Reservations

--

INSERT INTO ReservationRooms(ReservationID,RoomNum)
	VALUES(1,120),
		(1,400),
		(2,224),
		(3,320),
		(3,304),
		(4,202),
		(5,002),
		(6,314),
		(7,224)

SELECT * FROM ReservationRooms

--

SELECT * FROM AddOns
INSERT INTO ReservationAddOns(ReservationID,AddOnID)
	VALUES(1,2),
		(1,3),
		(2,1),
		(2,1),
		(2,1),
		(3,4),
		(4,5),
		(4,1),
		(5,3),
		(5,5),
		(6,5),
		(7,1),
		(7,1),
		(7,5),
		(7,2)

SELECT * FROM ReservationAddOns

--

INSERT INTO Guests(FirstName,LastName,Age,ReservationID)
	VALUES('Peter','Griffin', 48, 1),
		('Randy','Savage', 56, 1),
		('Mark','Wilson',33,2),
		('Joe','Johnson',29,2),
		('Bill','Willson',27,2),
		('Joe','George',24,2),
		('Katie','Kristy',24,2),
		('Jenny','Jenkins',25,2),
		('Maria','Hanson',25,3),
		('Alex','Cary',22,4),
		('Ronny','Cary',34,4),
		('Jennifer','Cary',51,4),
		('Caren','Blisto',44,5),
		('Jake','Weebs',41,5),
		('Victor','Benson',66,6),
		('Merl','Greeves',79,6),
		('Connie','Wilma',29,7)

SELECT * FROM Guests

--

INSERT INTO Billing(ReservationID,Total,Tax)
	VALUES(1,0.00,0.00),
	(2,0.00,0.00),
	(3,0.00,0.00),
	(4,0.00,0.00),
	(5,0.00,0.00),
	(6,0.00,0.00),
	(7,0.00,0.00)

SELECT * FROM Billing

--

INSERT INTO BillingDetails(BillID, ReservationID, AddOnID)
	VALUES(1,1,2),
		(1,1,3),
		(2,2,1),
		(2,2,1),
		(2,2,1),
		(3,3,4),
		(4,4,5),
		(4,4,1),
		(5,5,3),
		(5,5,5),
		(6,6,5),
		(7,7,1),
		(7,7,1),
		(7,7,5),
		(7,7,2)

SELECT * FROM BillingDetails

