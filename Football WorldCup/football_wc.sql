--adding the year column in my tables 


ALTER TABLE dbo.[FIFA - 1930]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1934]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1938]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1950]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1954]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1958]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1962]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1966]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1970]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1974]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1978]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1982]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1986]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1990]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1994]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 1998]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 2002]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 2006]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 2010]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 2014]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 2018]
ADD year varchar(4);
ALTER TABLE dbo.[FIFA - 2022]
ADD year varchar(4);




UPDATE dbo.[FIFA - 1930]
SET year = ISNULL(year, '1930')
UPDATE dbo.[FIFA - 1934]
SET year = ISNULL(year, '1934')
UPDATE dbo.[FIFA - 1938]
SET year = ISNULL(year, '1938')
UPDATE dbo.[FIFA - 1950]
SET year = ISNULL(year, '1950')
UPDATE dbo.[FIFA - 1954]
SET year = ISNULL(year, '1954')
UPDATE dbo.[FIFA - 1958]
SET year = ISNULL(year, '1958')
UPDATE dbo.[FIFA - 1962]
SET year = ISNULL(year, '1962')
UPDATE dbo.[FIFA - 1966]
SET year = ISNULL(year, '1966')
UPDATE dbo.[FIFA - 1970]
SET year = ISNULL(year, '1970')
UPDATE dbo.[FIFA - 1974]
SET year = ISNULL(year, '1974')
UPDATE dbo.[FIFA - 1978]
SET year = ISNULL(year, '1978')
UPDATE dbo.[FIFA - 1982]
SET year = ISNULL(year, '1982')
UPDATE dbo.[FIFA - 1986]
SET year = ISNULL(year, '1986')
UPDATE dbo.[FIFA - 1990]
SET year = ISNULL(year, '1990')
UPDATE dbo.[FIFA - 1994]
SET year = ISNULL(year, '1994')
UPDATE dbo.[FIFA - 1998]
SET year = ISNULL(year, '1998')
UPDATE dbo.[FIFA - 2002]
SET year = ISNULL(year, '2002')
UPDATE dbo.[FIFA - 2006]
SET year = ISNULL(year, '2006')
UPDATE dbo.[FIFA - 2010]
SET year = ISNULL(year, '2010')
UPDATE dbo.[FIFA - 2014]
SET year = ISNULL(year, '2014')
UPDATE dbo.[FIFA - 2018]
SET year = ISNULL(year, '2018')
UPDATE dbo.[FIFA - 2022]
SET year = ISNULL(year, '2022')






WITH fwc AS (
    SELECT * FROM football_wc.dbo.[FIFA - 1930]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1934]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1938]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1950]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1954]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1958]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1962]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1966]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1970]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1974]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1978]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1982]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1986]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1990]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1994]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 1998]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 2002]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 2006]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 2010]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 2014]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 2018]
    UNION
    SELECT * FROM football_wc.dbo.[FIFA - 2022]
)

--SELECT * FROM fwc
--order by year

SELECT * FROM football_wc.dbo.fwc
order by year

---------------------------- Most Goals Scored by team in every world cup------------------------------------
CREATE VIEW goals_scored AS
WITH max_goals_scored AS(

SELECT  year,Team, Goals_For FROM football_wc.dbo.fwc
where year ='1930'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1930')
OR year='1934'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1934')

OR year='1938'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1938')

OR year='1950'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1950')

OR year='1954'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1954')


OR year='1958'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1958')


OR year='1962'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1962')

OR year='1966'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1966')

OR year='1970'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1970')

OR year='1974'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1974')

OR year='1978'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1978')
OR year='1982'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1982')
OR year='1986'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1986')
OR year='1990'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1990')
OR year='1994'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1994')
OR year='1998'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='1998')
OR year='2002'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='2002')
OR year='2006'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='2006')
OR year='2010'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='2010')

OR year='2014'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='2014')
OR year='2018'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='2018')
OR year='2022'
and Goals_For=(
		SELECT MAX(Goals_For) 
			FROM football_wc.dbo.fwc
				WHERE year='2022')

)


SELECT * from max_goals_scored

CREATE TABLE most_goals_scored (
year INT,
Team VARCHAR(25),
Goals_For INT
)
INSERT INTO most_goals_scored
SELECT YEAR, team, goals_for FROM goals_scored
order by year


SELECT * from most_goals_scored
order by year






---------------------------- Most Goals Conceded by Teams in every World Cup-------------------------------


CREATE TABLE most_goals_conceded (
year INT,
Team VARCHAR(25),
Goals_For INT
)
INSERT INTO most_goals_conceded
SELECT  year,Team, Goals_Against FROM football_wc.dbo.fwc
where year ='1930'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1930')
OR year='1934'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1934')

OR year='1938'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1938')

OR year='1950'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1950')

OR year='1954'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1954')


OR year='1958'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1958')


OR year='1962'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1962')

OR year='1966'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1966')

OR year='1970'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1970')

OR year='1974'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1974')

OR year='1978'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1978')
OR year='1982'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1982')
OR year='1986'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1986')
OR year='1990'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1990')
OR year='1994'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1994')
OR year='1998'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='1998')
OR year='2002'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='2002')
OR year='2006'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='2006')
OR year='2010'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='2010')

OR year='2014'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='2014')
OR year='2018'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='2018')
OR year='2022'
and Goals_Against=(
		SELECT MAX(Goals_Against) 
			FROM football_wc.dbo.fwc
				WHERE year='2022')



SELECT * FROM most_goals_conceded
order by year

SELECT * From football_wc.dbo.fwc
Order by year

SELECT * FROM most_goals_conceded
order by year
SELECT * FROM football_wc.dbo.[FIFA - World Cup Summary]
order by year

