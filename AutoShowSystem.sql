CREATE SCHEMA `Car1`;
USE `Car1`;

-- Table 1 : Employee
create table Employee2 (
FirstName VARCHAR(50),
Lastname VARCHAR(50),
EmployeeID int(10) Not Null,
ExpiryDate int(4),
DateOfBirth date,
university VARCHAR(50),
GraduationYear int(4),
yearsOfWork int(2),
CurrentJob VARCHAR(50),
Gender VARCHAR(6),
Salary Decimal,
constraint Employee_PK primary key(EmployeeID)
);
-- Insert table 1 :
INSERT INTO Employee2
VALUES 
('Fahad' , 'Ahmad', 1118743271,'2025','96/2/15','UMM AL-QURA','2018','3','Marketing','Male',8500 ),
('Sara' , 'Ali', 1113456904,'2026','98/6/11','UMM AL-QURA','2020','2','Customr Service','Female','7500'),
('Maha' , 'mohammed', 1112378935,'2024','95/9/1','UMM AL-QURA','2017','5','Sales Manager','female',9900 ),
('lama' , 'naif', 1118735261,'2029','94/5/3','UMM AL-QURA','2018','3','Vendor','female',8500 ),
('suha' , 'saud', 1191544286,'2025','93/2/21','UMM AL-QURA','2016','6','Accounting','female',11000 ),
('mohammed' , 'saleh', 1153002716,'2027','97/7/8','UMM AL-QURA','2019','4','Vendor','Male','9000' ),
('abdullrahman' , 'naser', 1156398320,'2028','92/11/1','UMM AL-QURA','2015','8','Financial Manager','Male',12000 );

-- --------------------------------------------
-- Table 2 : customer
create table Customer ( 
  CustomerID  int(10) not null,
  Nationality  varchar(200),
  IDexpiration int(4),
  FName varchar(30),
  LName varchar(30),
  DateOfBirth date,
  Gender varchar(6),
  Country varchar(200),
  PostCode int(5),
  City varchar(200),
  constraint AutoShowSystem_PK primary key( CustomerID )
);
-- Insert table 2 :
INSERT INTO Customer 
VALUES
(1178064089,'Saudi',2027,'Lama','Abdullah','04/3/15','Women','Saudi Arabia',65532,'Jeddah'),
(1165088032,'Saudi',2024,'Naif','Rami','99/5/2','Man','Saudi Arabia',20339,'Makkah'),
(1125038094,'Saudi',2030,'Hala','Ahmed','92/9/10','Women','Saudi Arabia',11506,'Makkah'),
(1194077350,'Saud',2030,'Samar','Faisal','00/1/1','Women','Saudi Arabia',64322,'Taif'),
(1178055034,'Saudi',2025,'Faisal','Abdullah','98/5/11','Man','Saudi Arabia',54410,'Taif'),
(1133750122,'Saudi',2028,'Omar','Ahmed','93/7/20','Man','Saudi Arabia',60473,'Makkah');

-- --------------------------------------------
-- Table 3 : Product
CREATE TABLE `Product` (
	VIN VARCHAR(17) NOT NULL UNIQUE, 
    Price DECIMAL(10,2),
    CONSTRAINT Product_PK PRIMARY KEY (VIN)
);
-- Insert table 3 :
INSERT INTO Product (VIN, Price)
VALUES
('A1234', 100.00),
('E5678', 250.50),
('I012', 500.00),
('M3456', 75.25),
('Q7890', 999.99);

-- --------------------------------------------
-- Table 4 : Manufacturing
CREATE TABLE `Manufacturing` (
	Brand VARCHAR(30) NOT NULL,
	Country VARCHAR(200),
    CONSTRAINT Manufacturing_PK PRIMARY KEY (Brand)
);
-- Insert table 4 : 
INSERT INTO Manufacturing (Brand, Country)
VALUES 
('BMW', 'Germany'),
('mercedes', 'Germany'),
('hyundai', 'south korea'),
('GMC', 'america'),
('genesis', 'korea'),
('mazda', 'japan'),
('bently', 'england');

-- --------------------------------------------
-- Table 5 : Contract
CREATE TABLE Contract (
ContractNumber     INT(10)     NOT NULL ,
`Date`             Date ,
FullBatch          DECIMAL(6,2) ,
HallfBatch         DECIMAL(6,2) ,          -- CHECK (HallfBatch IN (HallfBatch = Price/2)),
Installment        DECIMAL(6,2) ,
VIN                VARCHAR(17) NOT NULL      UNIQUE,
EmployeeID         INT(10)                   UNIQUE,
CustomerID         INT(10)                   UNIQUE,
CONSTRAINT Contract_PK  PRIMARY KEY(ContractNumber) ,
CONSTRAINT Contract_FK1 FOREIGN KEY (EmployeeID)  REFERENCES Employee2(EmployeeID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT Contract_FK2 FOREIGN KEY (CustomerID)  REFERENCES Customer(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT Contract_FK3 FOREIGN KEY (VIN)  REFERENCES Product(VIN)
ON DELETE CASCADE
ON UPDATE CASCADE
);
-- Insert table 5 :
INSERT INTO Contract 
  VALUES
  (1722498015, '2015/8/11', null, null, null, 'A1234' , 1118743271 , 1178064089),
  (1968989006, '2006/9/18', null, null, null, 'E5678' , 1113456904 , 1133750122),
  (1648989089, '1989/4/30', null, null, null, 'I012' , 1112378935 , 1125038094),
  (1478743005, '2005/5/28', null, null, null, 'M3456' , 1118735261 , 1194077350),
  (1932843002, '2002/3/25', null, null, null, 'Q7890', 1156398320 , 1178055034);

-- --------------------------------------------
-- Table 6 : Service
CREATE TABLE service (
    CarRental VARCHAR(20), -- shortName = R
    CarPlate VARCHAR(20), -- shortName = P
    CarMaintenance VARCHAR(20), -- shortName = M
    SoshibalCar VARCHAR(20), -- shortName = S
    shortNameService VARCHAR(20) not null,
    ContractNumber int(10) not null,
    PRIMARY KEY (shortNameService, ContractNumber),
    FOREIGN KEY (ContractNumber) REFERENCES Contract(ContractNumber)
);
-- Insert table 6 :
insert INTO Service 
VALUES
   ('Yes', 'ABC123', 'Yes', 'No', 'RPM', 1968989006),
   ('No', 'DEF456', 'No', 'Yes', 'PS', 1648989089),
   ('Yes', 'GHI789', 'Yes', 'No', 'RPM', 1478743005),
   ('No', 'JKL012', 'No', 'Yes', 'PS', 1932843002),
   ('Yes', 'MNO345', 'Yes', 'No', 'RPM', 1722498015);

-- --------------------------------------------
-- Table 7 : GetsOn 
CREATE TABLE GetsOn (
CustomerID         INT(10)       NOT NULL,
ShortNameservice   varchar(20)   NOT NULL ,
ContractNumber     INT(10)       NOT NULL ,
CONSTRAINT GetsOn_PK  PRIMARY KEY ( CustomerID , ContractNumber , ShortNameservice ) ,
CONSTRAINT GetsOn_FK1 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT GetsOn_FK2 FOREIGN KEY (ShortNameservice) REFERENCES Service(ShortNameservice)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT GetsOn_FK3 FOREIGN KEY (ContractNumber) REFERENCES Service(ContractNumber)
ON DELETE CASCADE
ON UPDATE CASCADE
);
-- Insert table 7 :
INSERT INTO GetsOn 
VALUES
  (1178064089 , 'RPM' , 1722498015),
  (1133750122 , 'RPM' , 1968989006),
  (1125038094 , 'PS' , 1648989089),
  (1194077350 , 'RPM' , 1478743005),
  (1178055034 , 'PS' , 1932843002);

-- --------------------------------------------
-- Table 8 : Produces 
create table produced (
 Brand varchar(30) not null ,
 VIN varchar(17) not null ,
 constraint produces_pk1 primary key(Brand,VIN),
 constraint produces_fk1 foreign key (Brand) references Manufacturing(Brand)
 ON DELETE CASCADE
 ON UPDATE CASCADE,
 constraint produces_fk2 foreign key (VIN) references Product(VIN)
 ON DELETE CASCADE	
 ON UPDATE CASCADE
);
-- Insert table 8 :
INSERT INTO produced
VALUES 
('BMW' , 'A1234'),
('mercedes' , 'E5678'),
('hyundai' , 'I012'),
('GMC' , 'M3456'),         
('genesis' , 'Q7890');

-- --------------------------------------------
-- Table 9 : Employess_Phnumber
create table Employess_Phnumber (
PhoneNumber int not null ,
EmployeeID int(10) not null ,
constraint Employess_Phnumber_pk1 primary key(PhoneNumber,EmployeeID),
constraint EmployeeID_fk1 foreign key (EmployeeID) references Employee2(EmployeeID)
 ON DELETE CASCADE 
 ON UPDATE CASCADE
);
-- Insert table 9 :
INSERT INTO Employess_Phnumber
VALUES 
(0561566453, 1118743271),
(0549003205, 1113456904),
(0550328879, 1112378935),
(0506094354, 1118735261),
(0506839221, 1191544286);

-- --------------------------------------------
-- Table 10 : Customer_Phnumber
CREATE TABLE  CustomerPhoneNumber (
  PhoneNumber INT NOT NULL,
  CustomerID  INT(10) NOT NULL,
  PRIMARY KEY (PhoneNumber),
  FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
  ON DELETE CASCADE 
  ON UPDATE CASCADE
);
-- Insert table 10 : 
INSERT INTO CustomerPhoneNumber
VALUES 
(0561134537, 1125038094),
(0579891205, 1133750122), 
(0555342379, 1178055034),
(0513409754, 1178064089),
(0598564321, 1194077350);

-- --------------------------------------------
-- Table 11 : MultiTypeOfVehicle
CREATE TABLE `MultiTypeOfVehicle` (
	VIN VARCHAR(17) NOT NULL,
	TypeOfVehicle VARCHAR(50) NOT NULL,
    CONSTRAINT MultiTypeOfVehicle_PK PRIMARY KEY (VIN, TypeOfVehicle),
    CONSTRAINT MultiTypeOfVehicle_FK FOREIGN KEY (VIN) REFERENCES Product(VIN) 
     ON DELETE CASCADE ON UPDATE CASCADE
);
-- Insert table 11 : 
INSERT INTO MultiTypeOfVehicle (VIN, TypeOfVehicle)
VALUES
('M3456', 'SUV'),
('I012', 'Sedan'),
('I012', 'Supercar'),
('A1234', 'Hatchback'),
('Q7890', 'Sedan'),
('E5678', 'Supercar');

-- --------------------------------------------
-- Table 12 : MultiColor
CREATE TABLE multicolor (
  Color VARCHAR(30)   NOT NULL,
  VIN   VARCHAR(255)  NOT NULL  UNIQUE,
PRIMARY KEY (Color),
foreign key (VIN) references `Product` (VIN) 
  ON DELETE CASCADE 
  ON UPDATE CASCADE
  );
 -- Insert table 12 :  
INSERT INTO multicolor
VALUES 
('Grey', 'A1234'),
('Red', 'E5678'),
('Blue', 'I012'),
('White', 'M3456'),
('Black', 'Q7890');

-- --------------------------------------------
-- Table 13 : YearOfManufacturing
CREATE TABLE `YearOfManufacturing` (
	Brand VARCHAR(30) NOT NULL,
	YearManufacturing INT(4) NOT NULL,
    CONSTRAINT YearOfManufacturing_PK PRIMARY KEY (Brand, YearManufacturing),
    CONSTRAINT YearOfManufacturing_FK FOREIGN KEY (Brand) REFERENCES Manufacturing(Brand)
      ON DELETE CASCADE ON UPDATE CASCADE
);
-- Insert table 13 :
INSERT INTO YearOfManufacturing (Brand, YearManufacturing)
VALUES
('BMW', 2011),
('mercedes', 1999),
('hyundai', 2021),
('GMC', 2016),
('genesis', 2015),
('mazda', 2023),
('bently', 2015);

-- QUERIES ----------------------------------------------------------

-- Queries table 2 : [DELETE + WHERE + SELECT]
DELETE From Customer
where CustomerID= 1165088032;
select * from Customer;

-- Queries table 3 : [UPDATE + WHERE]
UPDATE Product
SET Price = 299.99
WHERE VIN = 'E5678';
select * from Product;

-- Queries table 4 : [ORDER BY]
SELECT Brand 
FROM Manufacturing
ORDER BY Brand ASC;

-- Queries table 5 : [GROUP BY]
SELECT ContractNumber , CustomerID , Count(*)
FROM Contract
GROUP BY ContractNumber , CustomerID ;

-- Queries table 6 : [JOIN]
-- SQL query that performs a join operation between the Service and Product tables
-- It selects the shortNameService and ContractNumber columns from the Service table 
-- and the VIN and Price columns from the Product table
SELECT S.shortNameService, S.ContractNumber, P.VIN, P.Price
FROM Service S JOIN Contract C ON S.ContractNumber = C.ContractNumber
JOIN Product P ON C.VIN = P.VIN;

-- Queries table 7 : [WHERE]
SELECT ContractNumber 
FROM GetsOn
WHERE CustomerID = 1178064089 ;
  
SELECT * FROM Contract;  

-- Queries table 8 : [UPDATE + ORDER BY + WHERE]
delete from produced
 where Brand='GMC';
 
select *
FROM produced 
order by VIN desc;

-- Queries table 9 : [UPDATE + ORDER BY + WHERE]
update Employess_Phnumber
SET PhoneNumber=0530704098
where EmployeeID=1113456904;

SELECT *
FROM Employess_Phnumber
ORDER BY PhoneNumber asc;

-- Queries table 10 : [ORDER BY + SUBQUERIES]
SELECT *
FROM CustomerPhoneNumber
ORDER BY PhoneNumber DESC;

SELECT *
FROM CustomerPhoneNumber
WHERE CustomerID IN (SELECT CustomerID FROM Customer WHERE City = 'Jeddah');

-- Queries table 11 : [INNER JOIN]
SELECT P.VIN, P.Price, MTV.TypeOfVehicle
FROM Product AS P
INNER JOIN MultiTypeOfVehicle AS MTV
ON P.VIN = MTV.VIN;

-- Queries table 12 : [ORDER BY]
SELECT *
FROM multicolor
ORDER BY Color ASC;

-- Queries table 13 : [LEFT JOIN + WHERE + ORDER BY]
SELECT M.Brand, YM.YearManufacturing, M.Country
FROM Manufacturing AS M
LEFT JOIN YearOfManufacturing AS YM
ON M.Brand = YM.Brand WHERE YM.YearManufacturing >= 2015 
ORDER BY YM.YearManufacturing ASC;