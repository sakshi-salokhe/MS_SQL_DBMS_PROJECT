--Creating database
USE master
GO

IF DB_ID('IRide_DBMS_Project_02') IS NOT NULL
DROP DATABASE IRide_DBMS_Project_02
GO

CREATE DATABASE IRide_DBMS_Project_02
GO

USE IRide_DBMS_Project_02
GO


--Creating Tables
CREATE TABLE Customers(
	cust_id int IDENTITY,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	middle_name varchar(255) NULL,
	phone_no varchar(10) NOT NULL,
	email varchar(255) NULL,
	address varchar(255) NOT NULL,
	user_name varchar(255) NOT NULL,
	date_of_birth date NOT NULL,
	date_of_last_trip date NOT NULL,
	total_trips_this_year int NOT NULL,
	ratings float NOT NULL, 
	isDriver bit Not Null,
	isActive bit NOT NULL, 
	
	PRIMARY KEY (cust_id)
);
GO

CREATE TABLE CustomerCreditCards(
	id int IDENTITY,
	cust_id int NOT NULL,
	card_number varchar(16) NOT NULL,
	name_on_card varchar(255) NOT NULL,
	card_expiry_date date NOT NULL,
	CVV Int NOT NULL,
	isDefault bit Not Null,

	PRIMARY KEY(id),

	FOREIGN KEY(cust_id)
	REFERENCES Customers(cust_id),
);
GO	

CREATE TABLE DriverCurrentStatus(
	id int IDENTITY,
	status varchar(255) NOT NULL,
	
	PRIMARY KEY (id),
);
GO

CREATE TABLE Driver(
	driver_id int IDENTITY,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	middle_name varchar(255) NULL,
	date_of_birth date NOT NULL,
	date_of_joining date NOT NULL,
	SSN BigInt NOT NULL,
	address varchar(255) NOT NULL,
	phone_number varchar(10) NOT NULL,
	email_address varchar(255) NULL,
	ratings float NOT NULL, 
	driver_current_status Int Not Null, 
	
	PRIMARY KEY (driver_id),
	
	FOREIGN KEY(driver_current_status)
	REFERENCES DriverCurrentStatus(id),
);
GO

CREATE TABLE Trips(
	trip_id int IDENTITY,
	pickup_date date NOT NULL,
	dropoff_date date NOT NULL,
	trip_completion bit NOT NULL,
	pickup_address varchar(255) NOT NULL,
	destination_address varchar(255) NOT NULL,
	number_of_people Int NOT NULL,
	number_of_bags Int NOT NULL,
	customer_notes varchar(255) NULL,
	driver_notes varchar(255) NULL,
	cust_id Int NOT NULL,
	driver_id Int NOT NULL,
	total_cost money NOT NULL,
	tip money NOT NULL,
	cust_credit_card_info Int NOT NULL, 

	PRIMARY KEY(trip_id),

	FOREIGN KEY(cust_id)
	REFERENCES Customers(cust_id),
	FOREIGN KEY(driver_id)
	REFERENCES Driver(driver_id),
	
);
GO

CREATE TABLE Ratings(
	id int IDENTITY,
	trip_id int NOT NULL,
	date_of_review date NOT NULL,
	rate float NOT NULL,
	text varchar(255) NULL,
	
	PRIMARY KEY(id),

	FOREIGN KEY(trip_id)
	REFERENCES Trips(trip_id), 
);
GO

CREATE TABLE DriverInsurance(
	id int IDENTITY,
	driver_id int NOT NULL,
	company_name varchar(255) NOT NULL,
	policy_number BigInt NOT NULL,
	date_of_issue date NOT NULL,
	date_of_expiry date NOT NULL,
	
	PRIMARY KEY(id),
	
	FOREIGN KEY(driver_id)
	REFERENCES Driver(driver_id),

);
GO

CREATE TABLE DriverPayDate(
	id int IDENTITY,
	driver_id int NOT NULL,
	date_paid date NOT NULL,
	amount money NOT NULL,
	
	PRIMARY KEY(id),
	
	FOREIGN KEY(driver_id)
	REFERENCES Driver(driver_id),

);
GO

CREATE TABLE StateTable(
	id int IDENTITY,
	name varchar(255) NOT NULL,
	
	PRIMARY KEY (id),
);
GO

CREATE TABLE DriverLicense(
	id int IDENTITY,
	driver_id int NOT NULL,
	state_id int NOT NULL,
	license_number BigInt NOT NULL,
	date_of_issue date NOT NULL,
	date_of_expiry date NOT NULL,
	
	PRIMARY KEY(id),
	
	FOREIGN KEY(driver_id)
	REFERENCES Driver(driver_id),
	FOREIGN KEY(state_id)
	REFERENCES StateTable(id),

);
GO

CREATE TABLE BankAccountType(
	id int IDENTITY,
	name varchar(255) NOT NULL,
	
	PRIMARY KEY (id),
);
GO

CREATE TABLE BankInformation(
	id int IDENTITY,
	driver_id int NOT NULL,
	bank_name varchar(255) NOT NULL,
	routing_number BigInt NOT NULL,
	account_number BigInt NOT NULL,
	account_type Int NOT NULL,
	
	PRIMARY KEY(id),
	
	FOREIGN KEY(driver_id)
	REFERENCES Driver(driver_id),
	FOREIGN KEY(account_type)
	REFERENCES BankAccountType(id),
	
);
GO

CREATE TABLE CarColors(
	id int IDENTITY,
	color_name varchar(255) NOT NULL,
	
	PRIMARY KEY (id),
);
GO

CREATE TABLE CarClass(
	id int IDENTITY,
	name varchar(255) NOT NULL,
	
	PRIMARY KEY (id),
);
GO

CREATE TABLE Car(
	id int IDENTITY,
	driver_id int NOT NULL,
	model_name varchar(255) NOT NULL,
	year_of_purchase smallInt NOT NULL,
	color_id int NOT NULL,
	car_class int NOT NULL,
	number_of_passengers Int NOT NULL,
	number_of_bags Int NOT NULL,
		
	PRIMARY KEY(id),
	
	FOREIGN KEY(driver_id)
	REFERENCES Driver(driver_id),
	FOREIGN KEY(color_id)
	REFERENCES CarColors(id),
	FOREIGN KEY(car_class)
	REFERENCES CarClass(id),
		
);
GO

CREATE TABLE CarInsurance(
	id int IDENTITY,
	car_id int NOT NULL,
	company_name varchar(255) NOT NULL,
	policy_number BigInt NOT NULL,
	date_of_issue date NOT NULL,
	date_of_expiry date NOT NULL,
	
	PRIMARY KEY(id),
	
	FOREIGN KEY(car_id)
	REFERENCES Car(id),

);
GO


--Inserting values in the tables
INSERT INTO
Customers (first_name,last_name,middle_name,phone_no,email,address,user_name,date_of_birth,date_of_last_trip,total_trips_this_year,ratings,isDriver,isActive)
VALUES
('Sakshi Sanjay','Salokhe','','3152438254','ssalokhe@syr.edu','105 Concord Pl, Syracuse, NY', 'ssalokhe', '1995-11-19', '2019-04-21',0,5.0,0,1),
('Pushkar Mahendra','Tatiya','','3153963628','pmtatiya@syr.edu','105 Concord Pl, Syracuse, NY', 'pmtatiya', '1995-08-02', '2019-03-21',0,5.0,1,1),
('Shruti','Salokhe','','3152438434','sshrutis@syr.edu','318 Westcott Street, Syracuse, NY', 'sshrutis', '2000-01-25', '2018-12-13',0,5.0,0,1),
('Vishnu','Menon','Kailas','8152438252','kmvishnu@gmail.com','105 Concord Pl, NJ', 'kmvishnu', '1992-12-19', '2019-04-21',0,5.0,1,1),
('Kruti','Kalmath','','8004557895','kruti@gmail.com','New Brunswick, NY', 'kruti', '1994-05-19', '2019-04-15',0,5.0,0,1),
('Chaitali','P','C','3152438000','cpulkund@syr.edu','111 Trinity Pl, Syracuse, NY', 'cpulkund', '1995-09-18', '2019-04-02',0,5.0,0,1),
('Saurabh','Pohnerkar','','3152336254','spohner@syr.edu','105 South Beach Street, Syracuse, NY', 'saurabh', '1996-01-05', '2018-11-21',0,5.0,1,1),
('Souradeepta','Biswas','','8155168254','soura@syr.edu','222 Broadway, NY', 'soura', '1990-02-28', '2019-04-01',0,5.0,0,1),
('Siddharth','Kumar','S','3152008254','skumar@syr.edu','Frederick, Maryland', 'skumar', '1995-06-19', '2019-03-11',0,5.0,0,1),
('Anushka Atul','Patil','','3152448004','apatil@syr.edu','Boston, MA', 'apatil', '1997-09-04', '2019-01-17',0,5.0,0,1);

INSERT INTO
CustomerCreditCards (cust_id,card_number,name_on_card,card_expiry_date,CVV,isDefault)
VALUES
(1,'1234123412341234','Sakshi Salokhe','2022-11-01',123,1),
(1,'1234123412344321','Sakshi Salokhe', '2025-01-01',432,0),
(2,'2345234523452345','Pushkar Tatiya','2022-01-01',234,1),
(2,'2345234523455432','Pushkar M Tatiya','2024-01-01',543,0),
(2,'2345234554325432','Pushkar Tatiya','2018-12-01',503,0),
(3,'3456345634563456','Shruti Salokhe','2023-10-01',943,1),
(4,'4567456745674567','Vishnu KM','2024-05-21',643,1),
(5,'5678567856785678','Kruti Kalmath','2021-01-01',533,1),
(6,'2345678967896789','Chaitali','2020-01-01',003,1),
(7,'876987698769876','Saurabh Pohnerkar','2024-01-01',911,1),
(8,'6478647864789990','Souradeepta Biswas','2023-04-21',001,1),
(9,'2314346243114634','Siddharth K','2021-01-01',563,1),
(10,'5948362545987465','Anushka A Patil','2025-12-12',333,1);

--
INSERT INTO
DriverCurrentStatus (status)
VALUES
('inActive'),
('Idle/Available'),
('Busy / onTrip'),
('offline');

INSERT INTO
BankAccountType (name)
VALUES
('Checking'),
('Savings');

INSERT INTO
CarClass (name)
VALUES
('Regular Sedan'),
('Luxury Sedan'),
('SUV');

INSERT INTO
CarColors (color_name)
VALUES
('Red'),
('Yellow'),
('Blue'),
('Green'),
('Orange'),
('Brown'),
('Grey'),
('White'),
('Black');

INSERT INTO
StateTable (name)
VALUES
('Alabama'),
('Alaska'),
('Arizona'),
('Arkansas'),
('California'),
('Colorado'),
('Connecticut'),
('Delaware'),
('Florida'),
('Georgia'),
('Hawaii'),
('Idaho'),
('Illinois'),
('Indiana'),
('Iowa'),
('Kansas'),
('Kentucky'),
('Louisiana'),
('Maine'),
('Maryland'),
('Massachusetts'),
('Michigan'),
('Minnesota'),
('Mississippi'),
('Missouri'),
('Montana'),
('Nebraska'),
('Nevada'),
('New Hampshire'),
('New Jersey'),
('New Mexico'),
('New York'),
('North Carolina'),
('North Dakota'),
('Ohio'),
('Oklahoma'),
('Oregon'),
('Pennsylvania'),
('Rhode Island'),
('South Carolina'),
('South Dakota'),
('Tennessee'),
('Texas'),
('Utah'),
('Vermont'),
('Virginia'),
('Washington'),
('West Virginia'),
('Wisconsin'),
('Wyoming');

--
INSERT INTO
Driver (first_name,last_name,middle_name,date_of_birth,date_of_joining,SSN, address,phone_number,email_address, ratings,driver_current_status)
VALUES
('Pushkar Mahendra','Tatiya','','1995-08-02','2019-01-01',123123123,'105 Concord Place, Syracuse, NY','3152438254','pmtatiya@syr.edu',5.0,4),
('Vishnu','Menon','Kailas', '1992-12-19', '2017-12-01',234234234,'105 Concord Pl, NJ','8152438252','kmvishnu@gmail.com',5.0,1),
('Saurabh','Pohnerkar','','1996-01-05', '2018-01-21',345345345,'105 South Beach Street, Syracuse, NY','3152336254','spohner@syr.edu',5.0,2),
('Prashant','Kamath','','1993-06-21','2018-07-08',456456456,'Green Lakes Park, Syracuse, NY','8974587955','pkamat@gmail.com',5.0,4),
('Ritesh','Deshmukh' , 'M', '1985-02-19','2018-08-08',567567568,'Frederick,Maryland','4859632145','rdeshmukh@gmail.com',5.0,2),
('Shah','Khan', 'Rukh', '1971-11-02','2018-06-08',875487544,'Boston, MA', '5654228888','skhan@gmail.com',5.0,4),
('Aishwarya','Rai','','1974-11-01','2019-04-08',199999990,'New York City','7908096677','arai@gmail.com',5.0,1);

INSERT INTO
DriverInsurance (driver_id, company_name, policy_number, date_of_issue, date_of_expiry)
VALUES
(1,'ABC',1234512345,'2019-01-01','2022-12-12'),
(2,'DEF',6664253777,'2018-12-01','2025-01-12'),
(3,'ABC',2323232323,'2017-01-01','2019-01-01'),
(4,'DEF',4444455555,'2019-12-01','2022-05-12'),
(5,'DEF',1230000345,'2016-01-01','2020-12-12'),
(6,'JKL',1111112345,'2016-05-05','2025-12-01'),
(7,'DEF',1238888885,'2017-10-01','2029-12-12');

INSERT INTO
DriverLicense (driver_id, state_id, license_number, date_of_issue, date_of_expiry)
VALUES
(1,32,5645566666,'2019-01-01','2022-12-12'),
(2,30,2525252525,'2018-12-01','2025-01-12'),
(3,32,7897897899,'2017-01-01','2019-01-01'),
(4,32,3698521478,'2019-02-01','2022-05-12'),
(5,20,1456327895,'2016-01-01','2020-12-12'),
(6,21,3524169874,'2016-05-05','2025-12-01'),
(7,32,7891235364,'2017-10-01','2029-12-12');

INSERT INTO
BankInformation (driver_id, bank_name, routing_number, account_number, account_type)
VALUES
(1,'chase',1234567859,1234356777,1),
(2,'chase',4564564567,4564564563,1),
(3,'key',2582582587,1231230777,2),
(4,'mnt',4587434122,1478594034,1),
(5,'chase',4441115557,4441115550,1),
(6,'chase',0123456780,5555555558,2),
(7,'mnt',1234564789,1234565707,1);

--
INSERT INTO
Car (driver_id, model_name, year_of_purchase, color_id, car_class, number_of_passengers, number_of_bags)
VALUES
(1,'Toyota','2019',2,1,4,2),
(2,'Nissan','2018',4,2,6,3),
(3,'Ford','2017',5,3,4,2),
(4,'Skoda','2019',3,3,4,2),
(5,'Cadillac','2016',1,1,6,3),
(6,'Nissan','2016',7,3,7,3),
(7,'Cadillac','2017',9,2,4,2);

INSERT INTO
CarInsurance (car_id, company_name, policy_number, date_of_issue, date_of_expiry)
VALUES
(1,'XYZ',6354711255,'2019-02-01','2029-01-31'),
(2,'LMN',6354711255,'2019-01-01','2028-12-31'),
(3,'XYZ',6354711255,'2017-02-01','2027-01-31'),
(4,'XYZ',6354711255,'2019-03-01','2029-02-28'),
(5,'PQR',6354711255,'2016-02-01','2026-01-31'),
(6,'PQR',6354711255,'2016-06-05','2026-05-31'),
(7,'XYZ',6354711255,'2017-11-01','2027-10-31');

--
INSERT INTO
Trips (pickup_date,dropoff_date,trip_completion,pickup_address,destination_address,number_of_people,number_of_bags,customer_notes,driver_notes,cust_id,driver_id,total_cost,tip,cust_credit_card_info)
VALUES
('2019-04-21','2019-04-21',1,'Slutzker Center','105 Concord Place',3,0,'','',1,7,7.6,1.5,1),
('2019-04-21','2019-04-21',1,'Hendrick Chapel', 'Destiny USA',2,0,'','',4,4,14.7,1.5,7),
('2019-04-15','2019-04-15',1,'Alto cinco', '111 TrinityPl',1,1,'','',5,7,7.6,2.5,8),
('2019-04-02','2019-04-02',1,'Recess Caffe','Bird Library',2,0,'meet me at the east entrance','sure.',6,1,10.0,3.5,9),
('2019-04-01','2019-04-01',1,'Als Pub','Crouse Hospital',1,2,'come to the parking place','sure sir',8,2,12.3,1.5,11),
('2019-03-21','2019-03-21',1,'105 Concord Place', 'Recess Caffe',4,2,'','',2,5,7.6,1.0,3),
('2019-03-11','2019-03-11',1,'Bird Library','Hendrick Chapel',4,2,'','',9,6,3.2,2.0,12),
('2019-01-17','2019-01-17',1,'Crouse Hospital','111 TrinityPl',1,0,'','',10,1,11.0,1.5,13),
('2018-12-13','2018-12-13',1,'Destiny USA','Als Pub',2,2,'','',3,1,14.3,1.5,6),
('2018-11-21','2018-11-21',1,'318 Westcott Street', '105 Concord Place',1,1,'come to the other side of the road','sure',7,1,5.6,1.35,10);

INSERT INTO
Ratings (trip_id, date_of_review,rate,text)
VALUES
(1,'2019-04-23',4.5,''),
(2,'2019-04-21',5.0,'very comfortable'),
(3,'2019-04-18',5.0,''),
(4,'2019-04-05',4.0,'car unclean'),
(5,'2019-04-02',4.5,''),
(6,'2019-03-23',5.0,''),
(7,'2019-03-19',5.0,'very comfortable'),
(8,'2019-01-18',4.0,''),
(9,'2018-12-18',5.0,''),
(10,'2018-11-25',5.0,'');

INSERT INTO
DriverPayDate (driver_id, date_paid, amount)
VALUES
(1,'2019-03-30',300),
(2,'2019-03-30',165),
(3,'2019-03-30',190),
(4,'2019-03-08',90),
(5,'2019-03-08',177),
(6,'2019-03-08',135),
(7,'2019-04-19',70);

-- Views
CREATE VIEW CustomerFullName
AS
SELECT cust_id,
first_name+’ ‘+middle_name+’ ‘+ last_name AS cust_full_name
FROM Customers
Go
SELECT * FROM CustomerFullName


CREATE VIEW Customers_Drivers
AS
SELECT first_name, last_name, middle_name, email, phone_no
From Customers
WHERE Customers.isDriver = 1
GO
Select * From Customers_Drivers;


CREATE VIEW TotalEarningForEachTrip
AS
SELECT t.trip_id AS TripID, t.driver_id AS DriverID, d.first_name AS DriverName,
c.cust_id AS CustomerID, c.first_name AS CustomerName, ( t.total_cost + t.tip) AS
TotalEarning
FROM Customers c JOIN Trips t
ON c.cust_id = t.cust_id JOIN Driver d
ON t.driver_id = d.driver_id;
Select * From TotalEarningForEachTrip;


CREATE VIEW Top2CostliestTrips
AS
SELECT TOP 2 TripID, DriverName, CustomerName, TotalEarning
FROM TotalEarningForEachTrip
ORDER BY TotalEarning DESC;
SELECT * FROM Top2CostliestTrips;


--Functions
Create Function trips_in_date_range(@DateMin date, @DateMax date)
RETURNS TABLE
RETURN
( SELECT trip_id, cust_id, driver_id, pickup_date
FROM Trips
Where pickup_date Between @DateMin AND @DateMax) ;
Select * FROM trips_in_date_range('2019-01-01', '2019-04-22');


Create Function customers_Current_Credit_Card(@trip_ID int)
RETURNS TABLE
RETURN
( SELECT cust_id, card_number,name_on_card
FROM CustomerCreditCards
Where cust_id = (SELECT cust_id FROM Trips WHERE trip_id = @trip_ID ) AND
isDefault = 1);
Select * FROM customers_Current_Credit_Card(1);


--Stored Procedures
CREATE Procedure spCarAfterDate
@DateMin varchar(20) = Null
As
SET NOCOUNT ON
If @DateMin Is Null
THROW 500001, 'Please provide DateMin Parameters.', 1;
Select id, driver_id, model_name, year_of_purchase
FROM Car
Where year_of_purchase Between CAST(@DateMin as smallInt) AND GETDATE()
Return 0
BEGIN
EXEC spCarAfterDate '2018';
END


CREATE PROCEDURE spUpdateTip @trip_ID INT, @tip1 FLOAT
AS
BEGIN
IF (@tip1 < 0)
BEGIN
RAISERROR('Tip amount cannot be negative',16,1);
return;
END
ELSE
BEGIN
UPDATE Trips SET tip = @tip1
WHERE trip_id = @trip_ID
END
END
BEGIN
EXEC spUpdateTip 1,3.8;
END
select * from Trips where trip_id = 1;


--Scripts
SELECT driver_current_status FROM Driver
WHERE driver_id = 3;
UPDATE Driver
SET driver_current_status = 1
WHERE driver_id = (SELECT driver_id FROM DriverLicense
WHERE date_of_expiry < GETDATE());
SELECT driver_current_status FROM Driver
WHERE driver_id = 3;


DECLARE @TotalBalanceDue money;
SELECT @TotalBalanceDue = amount
FROM DriverPayDate
WHERE amount > 0;
IF @TotalBalanceDue > 100
BEGIN
SELECT first_name, last_name, phone_number
FROM Driver JOIN DriverPayDate
ON Driver.driver_id = DriverPayDate.driver_id
WHERE amount > 0
PRINT 'Amount paid to the driver is '+ CONVERT(varchar, @TotalBalanceDue, 1) ;
END
ELSE PRINT 'Amount paid was less than $100.';