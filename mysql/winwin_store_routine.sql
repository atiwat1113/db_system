-- drop table TriggerTime;
-- drop trigger  deleteAccountLog;
-- drop procedure addBooking;
-- drop procedure GetRiderFromStation;
-- drop procedure UpdateRiderStation;
-- drop function CalcPrice;


CREATE TABLE IF NOT EXISTS TriggerTime (
    time DATETIME NOT NULL,
    userID CHAR(8) NOT NULL
);

-- FUNCTION -------------------

DELIMITER $$
CREATE FUNCTION calcPrice(dist float)
	RETURNS INT
	DETERMINISTIC
BEGIN
	DECLARE price INT;
	DECLARE remDist float;
	IF dist > 5 THEN
	BEGIN
		set remDist = dist - 5;
		IF MOD(remDist,1) < 0.5 THEN
			set remDist = remDist - MOD(remDist,1);
		ELSE
			set remDist = remDist - MOD(remDist,1) + 1;
		END IF;
		set price = (48 + remDist*12);
	END;
	ELSEIF (dist <= 5 AND dist > 2.5) THEN
	BEGIN
		set remDist = dist - 2.5;
		IF MOD(remDist,1) < 0.5 THEN
			set remDist = remDist - MOD(remDist,1);
		ELSE
			set remDist = remDist - MOD(remDist,1) + 1;
		END IF;
		set price = (30 + remDist*6);
	END;
	ELSEIF (dist <= 2.5 AND dist > 0) THEN
		set price = 30;
	END IF;
	RETURN (price);
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION calcRideT(startT datetime, stopT datetime)
	RETURNS time
	DETERMINISTIC
BEGIN
	DECLARE totalT INT;
	set totalT = abs(timediff(stopT, startT));
	RETURN (totalT);
END $$
DELIMITER ;


-- TRIGGER -----------------------------

CREATE 
    TRIGGER  deleteAccountLog
 AFTER DELETE ON User FOR EACH ROW 
    INSERT INTO TriggerTime VALUES (NOW() , OLD.user_ID);

DELIMITER //
CREATE TRIGGER updateNumberOfRiders
AfTER update
ON rider for each row
BEGIN
	IF NEW.station_ID != OLD.station_ID THEN
    BEGIN
		DECLARE new_station_manager char(8);
        DECLARE old_station_manager char(8);
        
        select manager_ID into new_station_manager
        from station
        where station_ID = NEW.station_ID;
        
        select manager_ID into old_station_manager
        from station
        where station_ID = OLD.station_ID;
    
		update station
        set number_of_riders = number_of_riders + 1
        where station_ID = NEW.station_ID;
        
        update station
        set number_of_riders = number_of_riders - 1
        where station_ID = OLD.station_ID;
        
        IF new_station_manager != old_station_manager THEN
        BEGIN
			update manager
			set number_of_riders = number_of_riders + 1
			where manager_ID = new_station_manager;
			
			update manager
			set number_of_riders = number_of_riders - 1
			where manager_ID = old_station_manager;
        END;
        END IF;
    END;
    END IF;
END //
DELIMITER ;

-- PROCEDURE -----------------------------

DELIMITER //
CREATE PROCEDURE addBooking (
	IN ride_ID char(8), 
    IN customer_ID char(8), 
    IN rider_ID char(8), 
	IN start_latitude float, 
    IN start_longitude float, 
    IN stop_latitude float, 
    IN stop_longitude float, 
    IN distance float, 
    IN start_time datetime,
	IN transaction_ID char(8), 
    IN payment_method enum('cash','bank_transfer','credit_card')
)
BEGIN
	-- error handler
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		Resignal;
	END;

	SET autocommit = 0;
	START TRANSACTION;
	INSERT INTO ride(ride_ID,customer_ID,rider_ID,status,start_latitude,start_longitude,stop_latitude,stop_longitude,distance,start_time) VALUES
    (ride_ID,customer_ID,rider_ID,'matching',start_latitude,start_longitude,stop_latitude,stop_longitude,distance,start_time);
    
    INSERT INTO transactionrecord(transaction_ID,type,status,amount,payment_method) VALUES
    (transaction_ID,'ride','pending',calcPrice(distance),payment_method);
    
    INSERT INTO ridetransaction VALUES
    (transaction_ID,ride_ID);
    COMMIT;
END//
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE GetRiderFromStation(IN stationName varchar(50))
BEGIN 
	SELECT U.first_name, U.last_name, U.phone_num, R.ref_no, R.citizen_ID, R.is_available, R.rating 
	FROM  rider R natural join station S natural join user U
	WHERE S.name = stationName;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE UpdateRiderStation(
 	IN i_user_ID CHAR(8),
 	IN i_station_ID CHAR(8)
 )
BEGIN
	DECLARE exit handler for sqlexception
	Begin
		Rollback;
		Resignal;
	End;

	start transaction;

	update Rider 
    set station_ID=i_station_ID 
    where user_ID = i_user_ID;

	commit;
END$$
DELIMITER ;


-- CALL addBooking('RDE00006','UID00007','UID00002',50,50,80,80,45,now(),'TRN00011','cash');
-- call GetRiderFromStation('Station1');
-- CALL UpdateSubscriptionInfo('SUB00001','SubAA',5000,30,30,'UID00007',DATE('2021-11-17'),DATE('2021-11-17'),0);
-- select DATE(DATE(now()) + 2) as date;
-- CALL UpdateRiderStation('UID00002','ST000001');