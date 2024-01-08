USE [22WQ_BUAN4210_Lloyd_ExcelsiorMobile]

--With Visualizations
--1A
SELECT CONCAT(S.FirstName,' ', S.LastName) AS 'Full Name', LMU.Minutes, LMU.DataInMB, LMU.Texts, B.Total
FROM Subscriber AS S, LastMonthUsage AS LMU, Bill AS B
WHERE S.MIN = LMU.MIN 
	AND LMU.MIN = B.MIN
ORDER By [Full Name];

--1B
SELECT S.City, AVG(LMU.Minutes) AS 'AVG Minutes',
			AVG(LMU.DatainMB) AS 'AVG Data',
			AVG(LMU.Texts) AS 'AVG Texts',
			AVG(B.Total) 'AVG Total'
FROM Subscriber AS S, LastMonthUsage AS LMU, Bill AS B
WHERE S.MIN = LMU.MIN 
	AND LMU.MIN = B.MIN
GROUP By S.City;

--1C
SELECT S.City, SUM(LMU.Minutes) AS 'Sum of Minutes',
			SUM(LMU.DatainMB) AS 'Sum of Data',
			SUM(LMU.Texts) AS 'Sum of Texts',
			SUM(B.Total) 'Sum Total'
FROM Subscriber AS S, LastMonthUsage AS LMU, Bill AS B
WHERE S.MIN = LMU.MIN 
	AND LMU.MIN = B.MIN
GROUP By S.City;

--1D
 SELECT S.PlanName, AVG(LMU.Minutes) AS 'AVG Minutes',
			AVG(LMU.DatainMB) AS 'AVG Data',
			AVG(LMU.Texts) AS 'AVG Texts',
			AVG(B.Total) 'AVG Total'
FROM Subscriber AS S, LastMonthUsage AS LMU, Bill AS B
WHERE S.MIN = LMU.MIN 
	AND LMU.MIN = B.MIN
GROUP By S.PlanName;

--1E
SELECT S.PlanName, SUM(LMU.Minutes) AS 'Sum of Minutes',
			SUM(LMU.DatainMB) AS 'Sum of Data',
			SUM(LMU.Texts) AS 'Sum of Texts',
			SUM(B.Total) 'Sum Total'
FROM Subscriber AS S, LastMonthUsage AS LMU, Bill AS B
WHERE S.MIN = LMU.MIN 
	AND LMU.MIN = B.MIN
GROUP By S.PlanName;


-- Without visualizations

--1A
SELECT TOP 2 City AS 'Cities With Most Users'
FROM Subscriber
GROUP BY City
ORDER BY COUNT(City) DESC;

--1B
SELECT TOP 3 City AS 'Cities With Least Users'
FROM Subscriber
GROUP BY City
ORDER BY COUNT(City) ASC;

--1C
SELECT TOP 1 PlanName AS 'Plan Name With Least Users'
FROM Subscriber
GROUP BY PlanName
ORDER BY COUNT(PlanName) ASC;


--2A
SELECT Type, COUNT(Type) AS 'Amount of Users'
FROM Device
GROUP BY Type;

--2B
SELECT CONCAT(S.FirstName,' ',S.LastName) AS 'Customer' 
FROM Subscriber AS S, Device AS D, Dirnums AS DN
WHERE S.MDN = DN.MDN AND DN.IMEI = D.IMEI 
	AND Type = 'Apple'
GROUP BY S.FirstName, S.LastName;

--2C
SELECT CONCAT(S.FirstName,' ',S.LastName) AS 'Customer', D.YearReleased
FROM Subscriber AS S, Device AS D, DirNums AS DN
WHERE S.MDN = DN.MDN AND DN.IMEI = D.IMEI
	AND D.YearReleased < 2018
GROUP By S.FirstName, S.LastName, D.YearReleased;

--3
SELECT TOP 1 U.DataInMB AS 'Most data W/o unlimited plan', S.City
FROM LastMonthUsage AS U, Subscriber AS S
WHERE U.MIN = S.MIN	
	AND PlanName NOT LIKE '%Unl%'
ORDER BY [Most data W/o unlimited plan] DESC;


--4A
SELECT CONCAT(FirstName,' ', LastName) AS 'Customer'
FROM Subscriber
WHERE MIN In
	(SELECT MIN
	FROM Bill
	WHERE Total IN
		(SELECT MAX(Total)
		FROM Bill))
GROUP BY FirstName, LastName;	


--4B
SELECT PlanName
FROM Subscriber AS S, Bill AS B
WHERE S.MIN = B.MIN AND B.Total = (SELECT MAX(Total) FROM Bill)
GROUP BY PlanName
ORDER BY SUM(Total);


--5A
SELECT TOP 1 SUM(Minutes) AS 'Total Minutes', LEFT(MDN,3) AS 'Area Code'
FROM Subscriber AS S, LastMonthUsage AS LMU
WHERE S.MIN = LMU.MIN
GROUP BY LEFT(MDN,3)
ORDER BY SUM(Minutes) DESC;


--5B
SELECT CITY, MAX(Minutes) - MIN(Minutes) AS 'Difference in Minutes usage'
FROM Subscriber AS S, LastMonthUsage AS LMU
WHERE S.MIN = LMU.MIN
GROUP BY City
HAVING MIN(Minutes)< 200 AND MAX(Minutes)> 700
ORDER BY City DESC;











