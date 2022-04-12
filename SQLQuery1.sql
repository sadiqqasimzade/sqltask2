CREATE DATABASE TASK1

USE TASK1

CREATE TABLE Branch
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Position
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) NOT NULL
)
CREATE TABLE Product
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) NOT NULL,
PurchasePrice FLOAT CHECK(PurchasePrice>0)NOT NULL ,
SellingPrice  FLOAT CHECK(SellingPrice>0)NOT NULL
)
CREATE TABLE Employee
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) NOT NULL,
Surname NVARCHAR(50) NOT NULL,
FatherName NVARCHAR(50) NOT NULL,
PositionId INT REFERENCES Position(Id),
Salary FLOAT CHECK(Salary>0)
)
CREATE TABLE Sales
(
Id INT IDENTITY PRIMARY KEY,
ProductId INT REFERENCES Product(Id) NOT NULL,
EmployeeId INT REFERENCES Employee(Id) NOT NULL,
BranchId INT REFERENCES Branch(Id) NOT NULL,
SaleDate DATE NOT NULL
) 



--drop table Sales
--drop table Product
--drop table Employee
--drop table Position
--drop table Branch


INSERT INTO Branch VALUES
('Baki'),('Gence'),('Qarabag'),('Sumqayit')

INSERT INTO Position VALUES
('Vezife1'),('Vezife2'),('Vezife3'),('Vezife4'),('Vezife5')

INSERT INTO Product VALUES
('Product1',1,2),
('Product2',3,4),
('Product3',5,6),
('Product4',7,8)

INSERT INTO Employee VALUES
('NAME1','SURNAME1','FATHERNAME1',1,100),
('NAME2','SURNAME2','FATHERNAME2',2,200),
('NAME3','SURNAME3','FATHERNAME3',3,300),
('NAME4','SURNAME4','FATHERNAME4',4,400),
('NAME5','SURNAME5','FATHERNAME5',5,500)

INSERT INTO Sales VALUES
(1,1,1,'2022-01-12'),
(2,2,2,'2022-05-12'),
(3,3,3,'2021-03-12'),
(4,4,4,GETDATE())

--1
SELECT Employee.Name, Employee.Surname, Employee.FatherName, Product.Name AS "Product Name " , Branch.Name AS "Branch Name", Product.PurchasePrice, Product.SellingPrice FROM Employee, Branch,Sales, Product 
WHERE Sales.ProductId = Product.Id and
Sales.EmployeeId = Employee.Id and
Sales.BranchId = Branch.Id
--2
SELECT SUM(Product.SellingPrice) AS 'Sum' FROM Product
--3
SELECT SUM(Product.SellingPrice) AS 'Sum' FROM Sales,Product WHERE DATEDIFF(MONTH, GETDATE(date), SaleDate) between 0 and 1
--4
SELECT Employee.Name , COUNT(Sales.ProductId) FROM Sales ,Employee
Where Sales.EmployeeId=Employee.Id
GROUP BY Employee.Name 
--5
SELECT TOP 1  Branch.Name , COUNT(Sales.ProductId)  AS 'Total',Sales.SaleDate FROM Sales ,Branch
Where Sales.BranchId=Branch.Id AND SaleDate='2022-04-12'
GROUP BY Branch.Name,Sales.SaleDate
--6
SELECT TOP 1 Product.Name , COUNT(Sales.ProductId)  AS 'Total' FROM Sales ,Product
Where Sales.ProductId=Product.Id  
GROUP BY  Sales.SaleDate, Product.Name