
----Creating Database, Schema and Tables ---------------------------

If Object_Id('Bank') Is Not Null
Drop Database Bank_Project
Go
Create Database Bank_Project ----------Database

--Creating Schema and Tables--

Use Bank_Project
Go
Create Schema Bank ------- 1st Schema 

Create Table Bank.Bank  
(
Bank_Code nvarchar(50)Primary Key,
Bank_Name nvarchar(50) Not Null,
Bank_Address nvarchar(50)
)

       ----Rename the column: Bank_Address---
exec sp_rename 'Bank.Bank.Bank_Address','District'
------------------------------------------------------
Create Table Bank.Branch
(
Branch_Id int identity(100,1) Primary key,
Bank_Code int references Bank.Bank(Bank_Code),
Branch_Name varchar(50) Not Null,
Branch_ZipCode int not null
)

-----Droping the column: Branch_Name

Alter Table Bank.Branch
Drop column Branch_Name

Create Schema Person -------------2nd Schema

If Object_Id('Person.Account') is not null
Drop Table Person.Account
Go
Create Table Person.Account
(
Acct_Num int identity(10000,1) Primary key,
Branch_Id int references Bank.Branch(Branch_Id),
Acct_Balance int Not Null,
)

-- Change Data type of Acct_Balance to money
Alter Table Person.Account
Alter column Acct_Balance money not null
------------------------------------------------

Create Table Person.Customer
(
Cust_Id int identity(500,1) Primary key,
Cust_Fname nvarchar(50) Not Null,
Cust_Lname nvarchar(50) Not Null,
Cust_Gender nchar(1),
City nvarchar(50)
)

Create Table Person.Loan
(
Loan_Num int identity(5000,1) Primary key,
Branch_Id int,
Loan_Amount int Not Null
)
--Adding Foreign Key to the existing column Branch_Id

Alter Table Person.Loan
Add Foreign Key (Branch_Id) references Bank.Branch(Branch_Id)
----------------------------------------------------------------

-- Change Data type of Loan_Amount to money
Alter Table Person.Loan
Alter column Loan_Amount money not null
----------------------------------------------------------------

If Object_Id('Person.Depositor') Is Not Null
Drop Table Person.Depositor
Go
Create Table Person.Depositor
(
Deposit_Id int identity(200,1) Primary Key,
Cust_Id int references Person.Customer(Cust_Id),
Acct_Num int references Person.Account(Acct_Num)
)
--Adding a column, named,Deposit_Date to Person.Depositor Table 
Alter Table [Person].[Depositor]
Add [Deposit_Date] DateTime Null

If Object_Id('Person.Borrower') Is Not Null
Drop Table Person.Borrower
Go
Create Table Person.Borrower
(
Borrower_Id int identity(300,1) Primary Key,
Cust_Id int references Person.Customer(Cust_Id),
Loan_Num int references Person.Loan(Loan_Num)
)

------------------------------Data Insertion---------------------


------INSERTING DATA INTO BANK.BANK TABLE

insert into [Bank].[Bank]([Bank_Code],[Bank_Name],[District])
Values
('AACOUS31XXX'	,'AMBAC ASSURANCE CORPORATION	           ' , 'San Francisco'),
('AAMCUS41XXX'	,'ATTUCKS ASSET MANAGEMENT LLC	    '  , '	Atlanta		 '),
('AAMSUS31XXX'	,'ARNOLD AND S. BLEICHROEDER ADVISORS LLC	', 'Richmond	 '),
('AANCUS31XXX'	,'XARAF MANAGEMENT LLC	                   ' , 'Chicago		 '),
('ABAIUS31XXX'	,'ABERDEEN AMERICA INC	                   ' , 'Dallas		 '),
('ABBVUS44XXX'	,'ABBVIE  INC.					   '       ,   'Cleveland '),
('ABCOUS33XXX'	,'ARAB BANKING CORPORATION	               ' , 'Philadelphia '),
('ABCTUS31XXX'	,'ABACO INTERNATIONAL CORPORATION	       ' , 'Boston		 '),
('ABEEUS31XXX'	,'ABG SECURITIES INC	                   ' , 'St. Louis	 '),
('ABENUS31XXX'	,'ABEL NOSER CORP	                       ' , 'Kansas City	 '),
('ABFGUS41XXX'	,'ABACUS FINANCIAL GROUP  INC'	             , 'Minneapolis'  ),
('ABGBUS44XXX'	,'ASSOCIATED BANK GREEN BAY N.A'            ,'San Francisco'  ),
('ABIAUS31XXX'	,'ALEX BROWN INVESTMENT MANAGEMENT			',' Atlanta 	' ),
('ABMRUS31XXX'	,'ABNER HERRMAN AND BROCK	'				,'Richmond	   '  ),
('ABMSUS61XXX'	,'ABM COPRORATE SERVICES'					,' Chicago	   '  ),
('ABNYUS33XXX'	,'NEW YORK COMMUNITY BANK'					,' Dallas	   '  ),
('ABOCUS33XXX'	,'AGRICULTURAL BANK OF CHINA NEW YORK BRANCH',' Cleveland   '  ),
('ABRSUS41XXX'	,'ABRAHAM AND SONS INC	                    ' , '  Philadelphia	' ),
('ABTTUS44XXX'	,'ABBOTT LABORATORIES	                    ' , '    Boston		'),
('ACALUS41XXX'	,'ARBOR CAPITAL MANAGEMENT  LIC	            ' , '  St. Louis	  ' ),
('ACBBUS6LXXX'	,'AMERICAN BUSINESS BANK                    '  ,'	   Kansas City'	),
('ACDLUS31XXX'	,'ATHENA CAPITAL ADVISORS LLC	            '  ,'     Minneapolis	'),
('ACENUS41XXX'	,'AMERICAN CENTURY INVESTMENT MANAGEMENT INC'  ,'   San Francisco '),
('ACFIUS31XXX'	,'ACF INTERNATIONAL INC	                    '    ,'   Atlanta 	 '  ),
('ACFOUS31XXX'	,'ACORN FOUNDATION	                        '      ,'Richmond'		),
('ACGLUS41XXX'	,'ATIVO CAPITAL MANAGEMENT LLC	            '    ,  ' Chicago'		),
('ACILUS61XXX'	,'ALGERT COLDIRON INVESTORS  LLC	        '     , '  Dallas'	 ),
('ACISUS51XXX'	,'ACCI SECURITIES INC	                    '     ,  ' Cleveland'	 ),
('ACLCUS31XXX'	,'PARA ADVISORS LLC	                        '      ,' Philadelphia'),
('ACMLUS31XXX'	,'AZIMUTH CAPITAL MANAGEMENT LLC	        '      ,' Boston	'   ),
('ACMSUS41XXX'	,'ALLBRITTON CAPITAL MANAGEMENT ASSOC	    '      ,' St. Louis '),
('ACNLUS31XXX'	,'ACORN CAPITAL MANAGEMENT LLC	            '      ,' Kansas City'),
('ACOLUS66XXX'	,'AMAZON CORPORATE LLC.	                    '      ,' Minneapolis'	 ),
('ACPRUS31XXX'	,'AMBAC CREDIT PRODUCTS  LLC	            '      ,' San Francisco'),
('ACPYUS33XXX'	,'ACUPAY SYSTEM LLC	                        '      ,' Atlanta   '),
('ACSEUS31XXX'	,'ACCI SECURITIES INC	                    '      ,' Richmond	' ),
('ACSUUS31XXX'	,'ACCESS SECURITIES INC	                    '      ,' Chicago	' ),
('ADCLUS31XXX'	,'ADLER, COLEMAN AND CO	                    '      ,' Dallas	'),
('ADCMUS31XXX'	,'ADVENT CAPITAL MANAGEMENT	                '      ,' Cleveland '),
('ADHAUS31XXX'	,'CANACCORD ADAMS INC	                    '      ,' Philadelphia '),
('ADIBUS33XXX'	,'FIRST ABU DHABI BANK USA N.V.	            '      ,' Boston	' ),
('ADIPUS31XXX'	,'ADVANCED INVESTMENT PARTNERS	            '      ,' St. Louis '),
('ADMDUS41XXX'	,'ADM DERIVATIVES  INC	                    '      ,' Kansas City	'),
('ADMIUS41XXX'	,'ADM INVESTOR SERVICES INC	                '      ,' Minneapolis	' ),
('ADPGUS33XXX'	,'ADP GLOBAL PROXY SERVICES	                '      ,' San Francisco  '),
('ADPIUS33XXX'	,'AUTOMATIC DATA PROCESSING INC	            '      ,' Atlanta  '),
('ADRSUS41XXX'	,'ADVISORY RESEARCH  INC	                '      ,' Richmond	'),
('ADSOUS61XXX'	,'ADVENT SOFTWARE ENGINEERING	            '      ,' Chicago	'),
('ADTRUS31XXX'	,'ADIRONDACK TRUST CO	                    '      ,' Dallas'),
('ADVEUS31XXX'	,'ADVEST GROUP INC	                        '      ,' Boston' )

------------------------INSERTING DATA INTO BRANCH TABLE-------------------

Insert Into Bank.Branch([Bank_Code],[Branch_ZipCode])
Values
('AACOUS31XXX',	10001),('AACOUS31XXX',	10013),('AACOUS31XXX',	10011),
('AAMCUS41XXX',	11554),('AAMCUS41XXX',	10010),('ABAIUS31XXX',	2143 ),
('ABMSUS61XXX',	30303),('ABNYUS33XXX',	11201),('ABOCUS33XXX',	10024),
('ABRSUS41XXX',	43215),('ABTTUS44XXX',	10025),('ACALUS41XXX',	10003),
('ACBBUS6LXXX',	21215),('ACBBUS6LXXX',	33132),('ACBBUS6LXXX',	10002),
('ACBBUS6LXXX',	11211),('ACDLUS31XXX',	20001),('ACENUS41XXX',	80428),
('ACFIUS31XXX',	30309),('ACFOUS31XXX',	34446),('ACFOUS31XXX',	2118 ),
('ACGLUS41XXX',	33156),('ACILUS61XXX',	63110),('ACGLUS41XXX',	92860),
('ACILUS61XXX',	76039),('ACISUS51XXX',	85718),('ACLCUS31XXX',	77521),
('ACMLUS31XXX',	10032),('ACMSUS41XXX',	11212),('ACNLUS31XXX',	11101),
('ACOLUS66XXX',	10022),('ACPRUS31XXX',	30022),('ACPYUS33XXX',	11221),
('ACSEUS31XXX',	30040),('ACSUUS31XXX',	11235),('ADCLUS31XXX',	78218),
('ADCLUS31XXX',	96706),('ADCMUS31XXX',	95121),('ADCMUS31XXX',	75249),
('ADCMUS31XXX',	75070),('ADCMUS31XXX',	94109),('ADCMUS31XXX',	77471),
('ADCMUS31XXX',	47306),('ADHAUS31XXX',	92563),('ADHAUS31XXX',	77388),
('ADHAUS31XXX',	91205),('ADIBUS33XXX',	60089),('ADIPUS31XXX',	11201),
('ADMDUS41XXX',	36303),('ADMIUS41XXX',	43231)

------------------------INSERTING DATA INTO Account TABLE-------------------

Insert Into Person.Account([Branch_Id],[Acct_Balance])
Values
(100,500.00 ),(100,	3666.00	),(100,	466.50),(103,	3546.20),(104,356.70	),
(105,7688.40),(105,129.50	),(107,200.00	),(108,8365.60),(109,4568.00),
(109,105.00	),(109,4766.00),(112,457.00	),(113,3456.00),(114,9000.00),
(115,2345.78),(116,6754.90),(116,456.90	),(116,7854.53),(116,4910.60),
(116,57875.00),(116,1903.68),(116,5672.00),(116,267.00	),(124,9818.00),
(125,23459.67),(126,4396.90),(127,3601.58),(128,6017.60),(129,5000.00),
(130,4029.67),(130,484.00	),(132,248.00	),(133,2020.00),(134,26780.78),
(135,38910.00),(136,7572.00),(137,800.00	),(137,20005.90),(139,1515.00),
(140,566.90	),(141,8940.78),(142,1777.67),(142,9000.00),(144,10456.00) ,
(145,786255.89),(146,8779.00),(146,920.00	),(148,2000.00),(149,3000.00)

-----------------INSERTING DATA INTO CUSTOMER TABLE--------
Insert Into [Person].[Customer]([Cust_Fname],[Cust_Lname],[Cust_Gender],[City])
Values
('Ken	    ','Sánchez	        ','M','	New York           '),   
('Terri	    ','Duffy			','F','	Los Angeles        '),
('Roberto	','Tamburello		','M','	Chicago 		   '),
('Rob	    ','Walters			','M','	Houston    		   '),
('Gail	    ','Erickson		    ','F','	Philadelphia       '),
('Jossef	','Goldberg		    ','M','	Phoenix    		   '),
('Dylan	    ','Miller			','M','	San Antonio        '),
('Diane	    ','Margheim		    ','F','	San Diego 		   '),
('Gigi	    ','Matthew			','F','	Dallas    		   '),
('Michael	','Raheem			','M','	 San Jose     	   '),
('Ovidiu	','Cracium			','M','	 Austin      	   '),
('Thierry	','Dhers			','M','	 Jacksonville      '),
('Janice	','Galvin			','F','	 San Francisco     '),
('Michael	','Sullivan		    ','M','	 Indianapolis      '),
('Sharon	','Salavaria		','F','	 Columbus      	   '),
('David	    ','Bradley			','M','	 Fort Worth        '),
('Kevin	    ','Brown			','M','	 Charlotte   	   '),
('John	    ','Wood			    ','M','	 Seattle  		   '),
('Mary	    ','Dempsey			','F','	 Denver   		   '),
('Wanida	','Benshoof		    ','F','	 El Paso      	   '),
('Terry	    ','Eminhizer		','M','	 Detroit     	   '),
('Sariya	','Harnpadoungsataya','M','	 Washington        '),  
('Mary	    ','Gibson			','F','	 Boston     	   '),
('Jill	    ','Williams		    ','F','	 Memphis      	   '),
('James	    ','Hamilton		    ','M','	 Nashville     	   '),
('Peter	    ','Krebs			','M','	 Portland   	   '),
('Jo	    ','Brown			','F','	 Oklahoma City     '),
('Guy	    ','Gilbert			','M','	 Las Vegas         '),
('Mark	    ','McArthur		    ','M','	 Baltimore    	   '),
('Britta	','Simon			','F','	 Louisville        '),
('Margie	','Shoop			','F','	 Milwaukee   	   '),
('Rebecca	','Laszlo			','F','	 Albuquerque       '),
('Annik	    ','Stahl			','M','	 Tucson      	   '),
('Suchitra	','Mohan			','F','	 Fresno    		   '),
('Brandon	','Heidepriem		','M','	 Sacramento        '),
('Jose	    ','Lugo			    ','M','	 Kansas City       '),
('Chris	    ','Okelberry		','M','	 Long Beach        '),
('Kim	    ','Abercrombie		','F','	 Mesa     		   '),
('Ed	    ','Dudenhoefer		','M','	 Atlanta    	   '),
('JoLynn	','Dobney			','F','	 Colorado Springs  '),
('Bryan	    ','Baker			','M','	 Virginia Beach    '),
('James	    ','Kramer			','M','	 Raleigh      	   '),
('Nancy	    ','Anderson		    ','F','	 Omaha    		   '),
('Simon	    ','Rapier			','M','	 Miami    		   '),
('Thomas	','Michaels		    ','M','	 Oakland 		   '),
('Eugene	','Kogan			','M','	 Minneapolis       '),
('Andrew    ','Hill			    ','M','	 Tulsa  		   '),
('Ruth	    ','Ellerbrock		','F','	 Wichita     	   '),
('Barry	    ','Johnson			','M','	 New Orleans       '),
('Sidney	','Higa			    ','M','	 Arlington		   ')

----------------INSERTING DATA INTO LOAN TABLE---------
Insert Into [Person].[Loan]([Branch_Id],[Loan_Amount])
Values
(111,5000  ),(143,12000 ),(143,6000  ),(143,40000 ),(149,20345 ),(149,34276 ),
(149,40145 ),(149,46014 ),(112,51883 ),(123,57752 ),(123,63621 ),(123,69490 ),
(141,75359 ),(141,81228 ),(125,87097 ),(125,92966 ),(125,98835 ),(125,104704),
(125,6000  ),(125,40000 ),(125,20345 ),(135,34276 ),(135,40145 ),(135,46014 ),
(129,51883 ),(113,57752 ),(140,63621 ),(140,3500  ),(146,30000 ),(146,6727  ),
(105,76827 ),(105,15516 ),(105,16388 ),(105,36346 ),(105,2467  ),(105,24572 ),
(102,9444  ),(102,7773  ),(133,39200 ),(133,33450 ),(133,6050  ),(133,15000 ),
(133,25000 ),(125,27500 ),(135,7633  ),(145,10000 ),(120,13000 ),(130,50000 ),
(140,46000 ),(100,35000 )

------------INSERTING DATA INTO DEPOSITOR TABLE-------------
Insert Into [Person].[Depositor]([Cust_Id],[Acct_Num],[Deposit_Date])
Values
(500,10000,'7/31/2013 '),(500,10001,'8/1/2011  '),(500,10001,'8/1/2011  '),
(500,10001,'7/31/2013 '),(500,10001,'5/31/2011 '),(500,10001,'7/31/2012 '),
(506,10006,'5/31/2011 '),(507,10007,'10/30/2012'),(508,10008,'7/1/2011  '),
(509,10009,'8/1/2011  '),(509,10009,'6/30/2013 '),(509,10009,'7/31/2013 '),
(512,10012,'5/31/2011 '),(513,10013,'8/1/2011  '),(514,10014,'7/31/2012 '),
(514,10014,'5/30/2012 '),(514,10014,'7/31/2013 '),(517,10017,'5/30/2013 '),
(518,10018,'6/30/2012 '),(518,10018,'8/1/2011  '),(518,10018,'3/30/2013 '),
(521,10021,'6/30/2013 '),(522,10022,'7/1/2011  '),(523,10023,'10/31/2011'),
(523,10023,'7/1/2011  '),(523,10023,'7/1/2011  '),(523,10023,'7/1/2011  '),
(527,10027,'7/31/2013 '),(528,10028,'6/30/2012 '),(528,10028,'7/31/2013 '),
(530,10030,'7/1/2011  '),(530,10030,'6/30/2013 '),(532,10032,'6/30/2013 '),
(533,10033,'8/1/2011  '),(534,10034,'6/30/2013 '),(534,10034,'5/30/2012 '),
(534,10034,'7/1/2011  '),(537,10037,'7/1/2011  '),(538,10038,'7/1/2011  '),
(538,10038,'6/30/2013 '),(538,10038,'8/1/2011  '),(541,10041,'6/30/2013 '),
(542,10042,'7/31/2013 '),(542,10042,'7/31/2012 '),(544,10044,'7/31/2013 '),
(544,10044,'7/31/2012 '),(546,10046,'10/31/2011'),(547,10047,'8/30/2012 '),
(547,10047,'5/31/2011 '),(549,10049,'7/31/2013 ')

-----------INSERTING DATA INTO BORROWER TABLE----------------

Insert Into [Person].[Borrower]([Cust_Id],[Loan_Num],[Borrow_Date])
Values
(502,5001,	'6/30/2013'	),(502,5001,	'6/30/2013'	),(502,5001,	'6/30/2013'	),
(503,5003,	'6/30/2013'	),(504,5004,	'12/25/2013'),(505,5005,	'5/11/2014'	),
(505,5005,	'5/21/2014'	),(505,5005,	'5/22/2014'	),(null,5005,	'5/18/2014'	),
(509,5009,	'6/20/2013'	),(509,5009,	'6/26/2013'	),(509,5009,	'6/28/2013'	),
(512,5012,	'6/29/2013'	),(null,5013,	'6/24/2013'	),(514,5014,	'6/19/2013'	),
(514,5014,	'6/21/2013'	),(514,5014,	'6/17/2013'	),(517,5017,	'6/22/2013'	),
(518,5018,	'6/23/2013'	),(null,5019,	'6/25/2013'	),(519,5019,	'6/19/2013'	),
(519,5019,	'6/13/2013'	),(null,5019,	'6/26/2013'	),(523,5023,	'6/14/2013'	),
(524,5024,	'6/30/2013'	),(524,5024,	'6/30/2013'	),(526,5026,	'6/30/2013'	),
(527,5027,	'7/30/2013'	),(527,5027,	'7/29/2013'	),(527,5027,	'12/25/2013'),
(527,5027,	'12/29/2013'),(527,5027,	'12/30/2013'),(527,5027,	'12/30/2013'),
(null,5033,	'12/22/2013'),(null,5034,	'9/27/2013'),(535,5035,	'9/30/2013'),
(535,5035,	'3/26/2014'),(537,5037,	'3/28/2014'),(537,5037,	'3/24/2014'),
(537,5037,	'8/30/2013'),(540,5040,	'8/30/2013'),(540,5040,	'8/30/2013'),
(540,5040,	'8/30/2013'),(543,5043,	'8/30/2013'),(543,5043,	'8/30/2013'),
(543,5043,	'8/30/2013'),(546,5046,	'8/30/2013'),(546,5046,	'8/30/2013'),
(548,5048,	'8/30/2013'),(549,5049,	'8/30/2013')


---Add Borrow_Date Column to [Person].[Borrower] Table
Alter Table [Person].[Borrower]
Add [Borrow_Date] DateTime Null

---Then Insert Data to the new Column
Insert Into [Person].[Borrower]([Borrow_Date])
 Values
('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),('12/31/2013'),('5/1/2014'),
('5/1/2014'),('5/1/2014'),('5/1/2014'),('6/30/2013'),('6/30/2013'),('6/30/2013'),
('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),
('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),('6/30/2013'),
('6/30/2013'),('6/30/2013'),('6/30/2013'),('7/31/2013'),('7/31/2013'),('12/31/2013'),
('12/31/2013'),('12/31/2013'),('12/31/2013'),('12/31/2013'),('9/30/2013'),('9/30/2013'),
('3/31/2014'),('3/31/2014'),('3/31/2014'),('8/30/2013'),('8/30/2013'),('8/30/2013'),
('8/30/2013'),('8/30/2013'),('8/30/2013'),('8/30/2013'),('8/30/2013'),('8/30/2013'),
('8/30/2013'),('8/30/2013')

---------------------- DML-Demonstrations----------------
DISTINCT(to get unique values)
	SELECT DISTINCT [Cust_Fname]
	FROM [Person].[Customer]     --> 47 ROWS 

TOP(to retrieve the first top rows after sort)
	SELECT TOP 10 *
	FROM  [Bank].[Bank] --> Displays top 10 records after sorted by the primary key 

WHERE CLAUSE (Filtering records according a given condition) 
	SELECT *
	FROM [Bank].[Bank]
	WHERE [District] = 'San Francisco'-->Retrieves bank information with 'San Francisco' district
            
IN OPERATOR
	SELECT *
	FROM [Bank].[Branch]
	WHERE [Branch_ZipCode] IN (11554,10010,2143 ,30303,11201,10024,43215,10025,10003)
	  --> Retrieves bank branch information where Branch_ZipCode is wwithin the list 
    
EXISTS(to test for the existence of any record in a subquery)
	SELECT *
	FROM [Bank].[Branch]
	WHERE EXISTS
			   (SELECT [Branch_ZipCode]
				FROM [Bank].[Branch]
				WHERE [Branch_ZipCode] = 10003 )
	--> The subquery returns True or False and if true, the outer query returns all the records
        if false, it returns no records

NOT EXISTS: the negation of EXISTS
	SELECT *
	FROM [Bank].[Branch]
	WHERE NOT EXISTS
			   (SELECT [Branch_ZipCode]
				FROM [Bank].[Branch]
				WHERE [Branch_ZipCode] = 10003 )
	   --> Returns no records as the subquery is True and negated by NOT EXISTS operator, therefore
   became False 

Null, Not Null --> are constraints for a record. if no record, 'Null', otherwise 'Not Null' 
Is Null, Is Not Null- Filtering operators
Example:
	SELECT * 
	FROM [Person].[Customer]
	WHERE [Cust_Gender] IS NULL --> Retrieves customers with no gender data

	SELECT * 
	FROM [Person].[Customer]
	WHERE [Cust_Gender] IS NOT NULL --> Retrieves customers having gender data

BETWEEN AND OPREATOR:
EXAMPLE:
    SELECT * 
	FROM [Person].[Customer]
	WHERE [Cust_Id] BETWEEN 520 AND 530 -->Returns customers whose Cust_Id between 520 and 530

Group by- Dealt with aggregate functions
EXAMPLE: Count() of customers by gender
	SELECT [Cust_Gender],COUNT([Cust_Gender]) AS Gender_Customers
	FROM [Person].[Customer]
	WHERE [Cust_Gender] IS NOT NULL
	GROUP BY [Cust_Gender] --> Returns count of customers by gender(F=18, M=29)

Having clauses: Filtering clause like WHERE but works with aggregate conditions
EXAMPLE:
	SELECT [Branch_Id],AVG([Loan_Amount]) as Average_loan
	FROM [Person].[Loan]
	GROUP BY [Branch_Id]
	HAVING AVG([Loan_Amount]) > 20000
	--> Retrieves Average loan by Branch_Id and having Average loan greater than 20000

Aggregate Functions: to get aggregate value, like Min(),Max(),Avg(),and Count()
EXAMPLE:
	SELECT [Branch_Id],Min([Acct_Balance]) as Min_Balance, Max([Acct_Balance]) as Max_Balance, Avg([Acct_Balance]) as Average_Balance
	FROM [Person].[Account]
	GROUP BY [Branch_Id]

Date Function: GetDate(),DateDiff(),DateAdd(),DatePart()
	SELECT GetDate() --> returns current time

EXAMPLES-DateDiff():-Get difference between two dates in terms of years, months, or days
	
	SELECT [Deposit_Date],DATEDIFF(YYYY,[Deposit_Date],GETDATE()) as YearsAgo_since_DepositDate
	FROM [Person].[Depositor] -->Retrieves number of years since deposit date
	SELECT [Deposit_Date],DATEDIFF(MM,[Deposit_Date],GETDATE()) as MonthsAgo_since_DepositDate
	FROM [Person].[Depositor] -->Retrieves number of months since deposit date
	SELECT [Deposit_Date],DATEDIFF(DD,[Deposit_Date],GETDATE()) as DaysAgo_since_DepositDate
	FROM [Person].[Depositor] -->Retrieves number of days since deposit date

EXAMPLES-DateAdd():- Adding years/months or days to a specified date
	SELECT [Deposit_Date],DateAdd(YYYY,10,[Deposit_Date]) as TenYearsAfter_DepositDate
	FROM [Person].[Depositor] -->adding 10 years to the deposit date
	SELECT [Deposit_Date],DateAdd(MM,10,[Deposit_Date]) as TenMonthsAfter_DepositDate
	FROM [Person].[Depositor]-->adding 10 months to the deposit date
	SELECT [Deposit_Date],DateAdd(DD,10,[Deposit_Date]) as TenDaysAfter_DepositDate
	FROM [Person].[Depositor]-->adding 10 days to the deposit date

EXAMPLES-DatePart():-to extract the date parts, like, year part, month part, day part etc of a given datetime
	SELECT [Deposit_Date], DatePart(YYYY,[Deposit_Date]) as Year_Part
	FROM [Person].[Depositor] --> Extracts the year part of Deposit date
	SELECT [Deposit_Date], DatePart(MM,[Deposit_Date]) as Month_Part
	FROM [Person].[Depositor] --> Extracts the Month part of Deposit date
	SELECT [Deposit_Date], DatePart(DD,[Deposit_Date]) as Day_Part
	FROM [Person].[Depositor] --> Extracts the Day part of Deposit date
 
String function: Rtrim(),Ltrim(),Lower(),Upper(),Concat() and others
EXAMPLE:
	SELECT [Cust_Fname],[Cust_Lname],Lower([Cust_Fname]) as Lower_Case,
		  Upper([Cust_Fname]) as Upper_Case, Concat([Cust_Fname],'',[Cust_Lname]) as FullName,
		  Rtrim([Cust_Fname]) as Rtrimmed_Fname,Ltrim([Cust_Lname]) as Ltrimmed_Lname
	FROM [Person].[Customer]
 
Numeric functionS:Sqrt(),Abs(),exp() and so on
EXAMPLE:
	SELECT [Loan_Amount],Sqrt([Loan_Amount]) as Sqrt_Amount  
	FROM [Person].[Loan]

SQL Joins (Inner, left, right, self, Cross product, fullouter join). Please join at least three of your tables. 
Inner Join:
EXAMPLE:
    --INNER JOIN
	SELECT B.[Bank_Name], BR.[Branch_ZipCode],A.[Acct_Balance]
	FROM [Bank].[Bank] as B
	Inner Join [Bank].[Branch] as BR
	On B.[Bank_Code] = BR.[Bank_Code]
	Inner Join [Person].[Account] as A
	On BR.[Branch_Id] = A.[Branch_Id]
	-->joins three tables and displays one column from each table(44 Rows)	 

	--LEFT JOIN
	SELECT C.[Cust_Id],  D.[Deposit_Date]
	FROM [Person].[Customer] as C
	Left Join [Person].[Depositor] as D
	On C.[Cust_Id] = D.[Cust_Id]

	--RIGHT JOIN
	SELECT C.[Cust_Id],  D.[Deposit_Date]
	FROM [Person].[Customer] as C
	Right Join [Person].[Depositor] as D
	On C.[Cust_Id] = D.[Cust_Id]

	--SELF JOIN:allows us to join a table itself. It is useful when a user wants to compare the data (rows) within the same table.
	SELECT C1.[Cust_Id], C2.[Cust_Id], C1.[Cust_Fname] as cust_Fname1,C2.[Cust_Fname] as Cust_Fname2,
	FROM [Person].[Customer] as C1,[Person].[Customer] as C2
	Where C1.[Cust_Id] <> C2.[Cust_Id]
	And C1.[Cust_Lname] = C2.[Cust_Lname]
	ORDER BY C1.[Cust_Lname] -->returns 2 rows satisfying the where condition

	--CROSS JOIN:Cross join allows us to join each and every row of both the tables.
	SELECT C.[Cust_Id],  D.[Deposit_Date]
	FROM [Person].[Customer] as C
	cross Join [Person].[Depositor] as D -->50*50 = 2500 ROWS 
	              --OR
	SELECT C.[Cust_Id],  D.[Deposit_Date]
	FROM [Person].[Customer] as C
	cross Join [Person].[Depositor] as D 
	Where C.[Cust_Id]=D.[Cust_Id] -->47 ROWS (Based on the condition)
	
Union All: Retrieves all the data from all the sql statements

EXAMPLE: Returns all the cust_ids, could be duplicated, from both the tables
	SELECT [Cust_Id]
	FROM [Person].[Depositor]
	UNION ALL
	SELECT [Cust_Id]
	FROM [Person].[Borrower]   -->100 ROWS

UNION
EXAMPLE: Returns unique cust_ids from both the tables
	SELECT [Cust_Id]
	FROM [Person].[Depositor]
	UNION 
	SELECT [Cust_Id]
	FROM [Person].[Borrower]   --> 37 ROWS
 
INTERSECTION
EXAMPLE: Returns cust_ids found in both the tables
	SELECT [Cust_Id]
	FROM [Person].[Depositor]
	INTERSECTION 
	SELECT [Cust_Id]
	FROM [Person].[Borrower]   --> 50 ROWS

EXCEPT
EXAMPLE: Returns cust_ids found in 1st statement but not in the 2nd one
	SELECT [Cust_Id]
	FROM [Person].[Depositor]
	EXCEPT 
	SELECT [Cust_Id]
	FROM [Person].[Borrower]   --> 15 ROWS

--View, Index (Clustered and non Clustered Index)

VIEW: is a virtual table based on the result-set of an SQL statement.
     A view contains rows and columns, just like a real table.

--Creating View
	CREATE VIEW View_1 as
		SELECT B.[Bank_Name], BR.[Branch_ZipCode],A.[Acct_Balance]
		FROM [Bank].[Bank] as B
		Inner Join [Bank].[Branch] as BR
		On B.[Bank_Code] = BR.[Bank_Code]
		Inner Join [Person].[Account] as A
		On BR.[Branch_Id] = A.[Branch_Id]

		SELECT * 
		FROM View_1

Index:Clustered and non Clustered Index- used for performance improvement

    --CREATING Non_INDEX
	  CREATE nonclustered INDEX Index_1 
	  On [Person].[Customer] ([Cust_Fname])

Decision making statements (IIF, IF, IF ELSE, While Condition)

--IF ELSE 
   Declare @balance money = 5050 

   IF @balance > (SELECT TOP 1 [Acct_Balance] 
                  FROM [Person].[Account])
   Begin 
      Select 'ENOUGH BALANCE'
   end
   ELSE
   begin
       Select 'DEPOSIT MORE'
   END 
   --> this statment compares top 1 account_balance with @balance value returns
        either 'ENOUGH BALANCE' or 'DEPOSIT MORE'

--IIF
	   Declare @balance1 money = 10000
	   Declare @balance2 money =(SELECT AVG([Acct_Balance]) FROM [Person].[Account])
	   Select IIF(@balance2 > @balance1,'High_Income', 'Low_Income') as Decision
      --> this returns either 'High_Income' or 'Low_Income' based on the condition given

-- WHILE CONDITION: used in case of a loop or iteration conditions 
      Declare @num money = 100000
	  WHILE @num < (SELECT max([Acct_Balance]) FROM [Person].[Account])
	       Begin
		   Select 'Still inside the loop'
		   Set @num = @num +100000
		   End
		Select 'Num now is greater than' + ' '+convert(varchar(50),(SELECT max([Acct_Balance]) FROM [Person].[Account]))
  -->Here, the 'Still inside the loop' displayed 7 times and when the while condition is false,
           the second select statement is returned

--Sub Query inside From and SELECT
EXAMPLE:
		SELECT [Cust_Id],[Cust_Fname],[Cust_Gender],(SELECT TOP 1 [Acct_Balance] 
													 FROM [Person].[Account] as AcctBalace)

		FROM [Person].[Customer]
		WHERE [Cust_Lname] LIKE 's%'
		--> this selects [Cust_Id],[Cust_Fname],[Cust_Gender] from [Person].[Customer] table
		  and an additional column from [Person].[Account] with values: top 1 Acct_Balance(500)
	  
-- CORRELATED QUERY:
EXAMPLE:
		SELECT B.*
		FROM [Bank].[Bank] as B
		Where Exists (SELECT BR.[Bank_Code]
					  FROM [Bank].[Branch] as BR
					  WHERE B.[Bank_Code]= BR.[Bank_Code])
		--> Here, the inner query takes the [Bank_Code] from [Bank].[Bank] 
		 and compares with [Bank].[Branch]s [Bank_Code] then returns the matching to the 
		 outer query, then the outer query takes the matching codes and returns the specified colmns 
		 
-- UDF(Scalar and table valued function): are declared using the CREATE FUNCTION statement

SCALAR:
EXAMPLE:
Alter FUNCTION FX_Acct()
returns varchar(50)
as
Begin
Declare @num1 money
set @num1 = 265473
	If @num1 > (Select max([Acct_Balance]) From [Person].[Account])
		Begin
		return 'It is high num'
		End
		return 'It is Low num'		
End
select [dbo].[FX_Acct]() -->Returns the 'It is Low num' as the else part is executed


-- Scalar Function with parameter
Example:
Create FUNCTION FX_Acct_2(@num1 int, @num2 int)
returns varchar(50)
as
Begin
Declare @num1 money
set @num1 = 265473
	If @num1 > (Select max([Acct_Balance]) From [Person].[Account])
		Begin
		return 'It is high num'
		End
		return 'It is Low num'		
End
select [dbo].[FX_Acct]() -->Returns the 'It is Low num' as the else part is executed

TABLE VALUED FUNCTION:
EXAMPLE:
Alter Function Fx_Customer(@Cust_Id int)
returns Table
as
return
(
Select *
From [Person].[Customer]
Where [Person].[Customer].Cust_Id = @Cust_Id
)
Select * from dbo.Fx_Customer(505) 


 
