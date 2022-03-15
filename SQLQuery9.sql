-- 9.1 give the total number of recordings in this table
-- 9.2 the number of packages listed in this table?
-- 9.3 How many times the package "Rcpp" was downloaded?
-- 9.4 How many recordings are from China ("CN")?
-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
-- 9.9 Print the average length of the package name of all the UNIQUE packages
-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
-- 9.11 Print the name of the package whose download count is bigger than 1000.
-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).

-- 9.1 give the total number of recordings in this table
Select Count (*)
From CranLogs

-- 9.2 the number of packages listed in this table?
Select Count(Distinct package)
From CranLogs

-- 9.3 How many times the package "Rcpp" was downloaded?
Select Count(*)
From CranLogs
Where package = 'RCPP'

-- 9.4 How many recordings are from China ("CN")?
Select Count(*)
From CranLogs
Where country = 'CN'

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
select package, Count(*) As "Total"
From CranLogs
Group by package
Order by 2 Desc

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
Select C.package, Count(*) As Ranking
From ( 
	Select *
	From CranLogs
	Where time Between '9:00' And '11:00'
	)
	As C 
	Group by C.package

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
Select Count(*)
From CranLogs
Where country In ( 'CN', 'JP', 'SG' )

-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
Select C.country
From (
	Select country, Count(*) As Downloads
	From CranLogs
	Group by country
	) As C
Where 
	C.Downloads > (
		Select Count(*)
		From CranLogs
		Where country = 'CN'
		)

-- 9.9 Print the average length of the package name of all the UNIQUE packages
Select AVG(length (package)
From (
	Select Distinct package As Package
	From CranLogs
	)


-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
Select package
From (
	Select package , Count (*) b
	From CranLogs
	Group by package
	Order by b Desc
	Limit 2
	)
Order by b Asc

-- 9.11 Print the name of the package whose download count is bigger than 1000.
Select package
From CranLogs
Group by package
Having Count (*) > 1000

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).


