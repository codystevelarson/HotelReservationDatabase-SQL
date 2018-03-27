--QUERIES--


--Get count of guests by reservationID
SELECT COUNT(g.ReservationID) AS GuestCount
FROM Reservations r
	INNER JOIN Guests g ON g.ReservationID = r.ReservationID
WHERE r.ReservationID = 6
GROUP BY r.ReservationID


--Get sum of all addon charges by reservationID 
SELECT SUM(a.Price) AS AddOnTotal
FROM Reservations r
	INNER JOIN ReservationAddOns ra ON r.ReservationID = ra.ReservationID
	INNER JOIN AddOns a ON a.AddOnID = ra.AddOnID
WHERE r.ReservationID = 1
GROUP BY ra.ReservationID


--Get sum of all room prices by rate and by reservations ID an
SELECT SUM(rr.Price) as RoomTotal
FROM Reservations r
	INNER JOIN ReservationRooms rrm ON rrm.ReservationID = r.ReservationID
	INNER JOIN Rooms rm ON rm.RoomNum = rrm.RoomNum
	INNER JOIN RoomRates rr ON rr.RoomNum = rm.RoomNum
	INNER JOIN Rates ra ON ra.RateID = rr.RateID
WHERE r.ReservationID = 1 
		AND ra.RateID = 4 --Could use a between with the reservation dates and rate dates
GROUP BY r.ReservationID


--Get all rates for all rooms
SELECT r.RoomNum, Price, ra.PriceDescription, ra.RateID
FROM Rooms r
	INNER JOIN RoomRates rr ON rr.RoomNum = r.RoomNum
	INNER JOIN Rates ra ON ra.RateID = rr.RateID
ORDER BY r.RoomNum 


--Get List of all currently valid promotion codes for a certain date
SELECT *
FROM Promotions
WHERE StartDate <= '06/23/2019' AND EndDate >= '06/23/2019'


--Get all reseration details for all current reservations
SELECT r.ReservationID, r.CustomerID, c.FirstName + ' ' + c.LastName AS CustomerName, r.CheckIn, r.CheckOut, rr.RoomNum, rra.Price, r.PromotionCode
FROM Reservations r 
	INNER JOIN Customers c ON c.CustomerID = r.CustomerID
	INNER JOIN ReservationRooms rr ON rr.ReservationID = r.ReservationID
	INNER JOIN Rooms rm ON rr.RoomNum = rm.RoomNum
	INNER JOIN RoomRates rra ON rra.RoomNum = rm.RoomNum
	INNER JOIN RoomTypes rt ON rt.TypeID = rm.RoomType
WHERE rra.RateID = 1
ORDER BY r.ReservationID,RoomNum