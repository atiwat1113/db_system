SELECT U.first_name AS 'First Name', U.last_name AS 'Last Name', SUM(T.amount) as Expense
FROM User U, Customer C, Ride R, ridetransaction RT, transactionrecord T
WHERE U.user_ID = C.user_ID AND  C.user_ID = R.customer_ID AND 
	R.ride_ID = RT.ride_ID AND RT.transaction_ID = T.transaction_ID AND 
    T.status = 'success' AND T.timestamp BETWEEN DATE("2021-11-01") AND DATE("2021-11-30")
GROUP BY U.user_ID
HAVING Expense >= any(SELECT Expense5 from topSpenderView)
ORDER BY Expense DESC;

SELECT U.first_name, U.last_name, U.phone_num, R.ref_no, R.citizen_ID, R.is_available, R.rating 
FROM  rider R natural join station S natural join user U
WHERE S.name = 'Station1' or R.user_ID='UID00005';


(SELECT U.first_name, U.last_name, U.phone_num, R.ref_no, R.citizen_ID, R.is_available, R.rating 
FROM  rider R, station S, user U
WHERE U.user_ID=R.user_ID and R.station_ID=S.station_ID and S.name = 'Station1')
UNION 
(SELECT U.first_name, U.last_name, U.phone_num, R.ref_no, R.citizen_ID, R.is_available, R.rating 
FROM rider R, user U
WHERE U.user_ID=R.user_ID and R.user_ID='UID00005')
;