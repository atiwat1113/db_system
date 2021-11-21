insert into location values
('LC000001'),
('LC000002'),
('LC000003'),
('LC000004'),
('LC000005'),
('LC000006'),
('LC000007'),
('LC000008');

insert into manager values
('MN000001','First1','Last1','Area1','2'),
('MN000002','First2','Last2','Area2','1'),
('MN000003','First3','Last3','Area3','0');

insert into station values
('ST000001','LC000001','MN000001','Station1','2'),
('ST000002','LC000002','MN000001','Station2','0'),
('ST000003','LC000003','MN000002','Station3','1'),
('ST000004','LC000004','MN000003','Station4','0'),
('ST000005','LC000005','MN000003','Station5','0');

insert into user values
('UID00001','username1','password1','email1@gmail.com','CustomerFirst1','CustomerLast1','0800000001','customer'),
('UID00002','username2','password2','email2@gmail.com','RiderFirst2','RiderLast2','0800000002','rider'),
('UID00003','username3','password3','email3@gmail.com','RiderFirst3','RiderLast3','0800000003','rider'),
('UID00004','username4','password4','email4@gmail.com','CustomerFirst4','CustomerLast4','0800000004','customer'),
('UID00005','username5','password5','email5@gmail.com','RiderFirst5','RiderLast5','0800000005','rider'),
('UID00006','username6','password6','email6@gmail.com','CustomerFirst6','CustomerLast6','0800000006','customer'),
('UID00007','username7','password7','email7@gmail.com','CustomerFirst7','CustomerLast7','0800000007','customer');

insert into rider values
('UID00002','ST000001','ab11111111111111','1234567891011',true,null,0),
('UID00003','ST000001','ab11111111111112','1234567891012',false,1,100),
('UID00005','ST000003','ab11111111111113','1234567891013',true,5,500);

insert into customer values
('UID00001','cash'),
('UID00004','credit_card'),
('UID00006','bank_transfer'),
('UID00007','credit_card');

insert into cardinfo values
('1111222233334444','UID00004','Holder4','0622'),
('1111222233334445','UID00004','Holder4','0822'),
('1111222233334446','UID00007','Holder7','0622'),
('1111222233334447','UID00001','Holder1','1023'),
('1111222233334448','UID00006','Holder6','1221');

insert into savedaddress values
('UID00001','LC000006','address1'),
('UID00004','LC000006','address1'),
('UID00004','LC000008','address2'),
('UID00001','LC000007','address2'),
('UID00001','LC000008','address3'),
('UID00006','LC000008','address3'),
('UID00007','LC000007','address4');

insert into subscriptioninfo values
('SUB00001','SubA',200,10,10),
('SUB00002','SubB',300,20,20),
('SUB00003','SubC',400,30,30);

insert into customersubscription values
('SUB00001','UID00007',now(),now(),now(),5),
('SUB00001','UID00004',now(),now(),now(),5),
('SUB00002','UID00006',now(),now(),now(),5);

insert into vehicle values
('123456789abcdefg','ABC','red'),
('123456784abcdefg','ABC2','red'),
('123456780abcdefg','ABC3','red');

insert into ridervehicle values
('VEH00001','UID00002','123456789abcdefg'),
('VEH00002','UID00003','123456784abcdefg'),
('VEH00003','UID00005','123456780abcdefg');

insert into ride values
('RDE00001','UID00007','UID00002','matching',45,45,45,45,1,now(),now(),0,'comment'),
('RDE00002','UID00004','UID00003','completed',45,45,45,45,1,now(),now(),2,'comment'),
('RDE00003','UID00006','UID00002','completed',45,45,45,45,1,now(),now(),0,'comment'),
('RDE00004','UID00007','UID00005','completed',45,45,45,45,1,now(),now(),2,'comment');

insert into transactionrecord values
('TRN00001','top-up',now(),'pending',100,'cash'),
('TRN00002','top-up',now(),'success',100,'bank_transfer'),
('TRN00003','top-up',now(),'success',100,'credit_card'),
('TRN00004','subscription',now(),'pending',100,'cash'),
('TRN00005','subscription',now(),'success',100,'bank_transfer'),
('TRN00006','subscription',now(),'pending',100,'credit_card'),
('TRN00007','ride',now(),'pending',100,'cash'),
('TRN00008','ride',now(),'pending',100,'bank_transfer'),
('TRN00009','ride',now(),'success',100,'credit_card'),
('TRN00010','ride',now(),'success',100,'credit_card');

insert into topuptransaction values
('TRN00001','UID00002'),
('TRN00002','UID00003'),
('TRN00003','UID00005');

insert into subscriptiontransaction values
('TRN00004','UID00007'),
('TRN00005','UID00004'),
('TRN00006','UID00006');

insert into ridetransaction values
('TRN00007','RDE00001'),
('TRN00008','RDE00002'),
('TRN00009','RDE00003'),
('TRN00010','RDE00004');