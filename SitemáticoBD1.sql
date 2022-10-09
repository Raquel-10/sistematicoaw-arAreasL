USE AdventureWorks2019
GO

CREATE OR ALTER PROC US_Ejercisio1(
       @NAME VARCHAR,
	   @MODIFIEDDATE2 DATE
)  
AS
BEGIN
 DECLARE @myid uniqueidentifier = NEWID();
 INSERT INTO Production.ProductCategory(Name,ModifiedDate)
 VALUES
 (
   @NAME,@MODIFIEDDATE2
 )
END
GO


EXEC US_Ejercisio1 'Umbrella','2022/08/10'
GO

SELECT * FROM Production.ProductCategory
GO

--------------------------------------EJERCICIO 2----------------------------------------------------------------------------------
CREATE OR ALTER  FUNCTION BirthEmployee()
RETURNS TABLE
AS
RETURN
(
SELECT D.LoginID,D.JobTitle,D.BirthDate,D.HireDate, DATEPART(YEAR,GETDATE())- DATEPART(YEAR,D.BirthDate) AS AGE, DATEPART(YEAR,GETDATE())- DATEPART(YEAR,D.HireDate) AS ANTIGUEDAD FROM  HumanResources.Employee AS D
);


SELECT * FROM BirthEmployee()
GO

--------------------------------------------EJERCICIO 3 CREACION DE LOGIN---------------------------------------------

CREATE LOGIN Vendedores WITH PASSWORD = 'aral'
GO

CREATE USER ARLarios FOR LOGIN Vendedores WITH DEFAULT_SCHEMA = Sales;
GO

CREATE ROLE db_Vendedores AUTHORIZATION [ARLarios]
GO
GRANT SELECT ON SCHEMA::Sales TO db_Vendedores
GO
GRANT INSERT ON SCHEMA::Sales TO db_Vendedores
GO
GRANT UPDATE ON SCHEMA::Sales TO db_Vendedores
GO
GRANT DELETE ON SCHEMA::Sales TO db_Vendedores
GO
GRANT SELECT ON Production.ProductCategory  TO db_Vendedores
GO
GRANT SELECT ON Production.Product  TO db_Vendedores
GO

ALTER ROLE db_Vendedores ADD MEMBER ARLarios
GO
