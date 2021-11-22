use winwin;
-- show tables;
INSERT INTO `user` VALUES  ('UID00008','username8','password8','email8@gmail.com','RiderFirst8','RiderLast8','0800000008','rider'),('UID00009','username9','password9','email9@gmail.com','RiderFirst9','RiderLast9','0800000009','rider');
INSERT INTO `rider` VALUES ('UID00008','ST000001','ab11111111111118','1234567891018',0,4,100),('UID00009','ST000001','ab11111111111119','1234567891019',0,4,100);
INSERT INTO `ride` VALUES ('RDE00007','UID00004','UID00008','completed',45,45,45,45,1,'2021-11-18 01:44:08','2021-11-18 01:44:08',2,'comment'),('RDE00008','UID00004','UID00008','completed',45,45,45,45,1,'2021-11-18 01:44:08','2021-11-18 01:44:08',2,'comment'),('RDE00009','UID00004','UID00008','completed',45,45,45,45,1,'2021-11-18 01:44:08','2021-11-18 01:44:08',2,'comment');
INSERT INTO `ride` VALUES ('RDE00010','UID00004','UID00009','completed',45,45,45,45,1,'2021-11-18 01:44:08','2021-11-18 01:44:08',2,'comment'),('RDE00011','UID00004','UID00009','completed',45,45,45,45,1,'2021-11-18 01:44:08','2021-11-18 01:44:08',2,'comment'),('RDE00012','UID00004','UID00009','completed',45,45,45,45,1,'2021-11-18 01:44:08','2021-11-18 01:44:08',2,'comment');

select  U.first_name as "Rider First Name",U.last_name as "Rider Last Name", S.name as "Station name", rating , count(ride_ID) as "Number of Ride" ,  M.first_name as "Manager First Name",M.last_name as "Manager Last Name"
from rider left join ride on rider.user_ID = ride.rider_ID  natural join station S natural join user U, manager M
where rating > 1 and M.manager_ID =  "MN000001" and S.manager_ID = M.manager_ID   group by user_ID having count(ride_ID)>1  ; 



