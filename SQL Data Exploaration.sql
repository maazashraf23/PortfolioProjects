
--Covid Vaccinations Table
SELECT *
FROM PortfolioProject..CovidVaccinations
order by 3,4

--Covid Deaths Table
SELECT *
FROM PortfolioProject..CovidDeaths
order by 1,2






--Select the data that we are going to be using
SELECT location,continent,date,total_cases, total_deaths,new_cases,population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL;
--order by 1,2







--Total cases vs total deaths

SELECT 
location,
continent,
MAX(CAST(total_cases AS bigint)) AS total_cases, 
MAX(CAST(total_deaths AS bigint)) AS total_deaths,
(MAX(CAST(total_deaths AS FLOAT))/MAX(CAST(total_cases AS FLOAT)))*100 AS Death_Percentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
and location like '%istan%'
group by continent, location
order by Death_Percentage desc





SELECT *
FROM PercentVaccinated




--Total cases vs population
--Shows what percentage of the population is infected
SELECT location,MAX(total_cases) as total_cases,MAX(population) as population,(MAX(total_cases)/MAX(population))*100 as infectedPercentage
FROM PortfolioProject..CovidDeaths
WHERE total_cases is not null
group by location
order by infectedPercentage desc







--Total cases vs population in USA
SELECT DISTINCT 
	location
	,date
	,total_cases
	,population
	,(total_cases/population) *  100	AS	infectedPercentage
FROM	PortfolioProject..CovidDeaths
WHERE	total_cases IS NOT NULL
and		location='United States'
--group by location,date
order by date






--Showing Countries with highest death count per population
--We need to use cast because the column data type of total deaths is nvarchar(255) so first we have to change it to integer before taking the max otherwise we will get a wrong answer
SELECT 
location,
MAX(cast(total_deaths as int)) as total_deaths,
MAX(population) as population,
MAX(total_deaths/population)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location='United States'
WHERE continent is not null
group by location
order by DeathPercentage desc






--Showing Continent with highest death count and death ratio wrt population.
SELECT 
location,
MAX(cast(total_deaths as int)) as total_deaths,
MAX(population) as population,
MAX(total_deaths/population)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location='United States'
WHERE continent is null
group by location
order by total_deaths desc







--Global Numbers new cases vs new deaths per day
SELECT
date,
SUM(CASE WHEN new_cases = 0 THEN NULL ELSE new_cases END) AS total_cases,
SUM(CASE WHEN new_deaths = 0 THEN NULL ELSE CAST(new_deaths AS INT) END) AS total_deaths,
SUM(CASE WHEN new_cases = 0 THEN NULL ELSE CAST(new_deaths AS INT) END) / SUM(new_cases) * 100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
group by date
order by 1








--Total Population vs New Vaccinations per day
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT DISTINCT
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(CONVERT(bigint,vac.new_vaccinations)) 
		OVER (
			PARTITION BY dea.location
			ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated
	--CONCAT(SUM(CAST(ISNULL(vac.new_vaccinations,'0') as bigint))/	MAX(dea.population)*100,'%' ) as PercentageVaccinated
FROM PortfolioProject..CovidDeaths AS dea
Join PortfolioProject..CovidVaccinations AS vac
	On dea.location=vac.location
	AND  dea.date=vac.date
WHERE dea.continent IS NOT NULL
--group by dea.location





--Now we have the columns with which we can do the rolling sum for new vaccinations to get the total vaccination for each country 
--Create CTE 
with PopVsVac(location,date,population,new_vaccinations)
AS(
SELECT DISTINCT
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations
	--SUM(CONVERT(bigint,vac.new_vaccinations)) 
	--	OVER (
	--		PARTITION BY dea.location
	--		ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated
	--CONCAT(SUM(CAST(ISNULL(vac.new_vaccinations,'0') as bigint))/	MAX(dea.population)*100,'%' ) as PercentageVaccinated
FROM PortfolioProject..CovidDeaths AS dea
Join PortfolioProject..CovidVaccinations AS vac
	On dea.location=vac.location
	AND  dea.date=vac.date
WHERE dea.continent IS NOT NULL
)
SELECT *,SUM(CONVERT(bigint,new_vaccinations)) 
			OVER (
			PARTITION BY location
			ORDER BY location,date) AS RollingPeopleVaccinated
FROM PopVsVac






--Total Population vs Total vaccination country wise
--For this we can create a TEMP Table


CREATE Table #PercentPop
(Location nvarchar(255),
Date datetime,
Population numeric,
PeopleVaccinated numeric
)
INSERT INTO #PercentPop
SELECT DISTINCT
	dea.location,
	dea.date,
	dea.population, 
	vac.new_vaccinations
	--SUM(CONVERT(bigint,vac.new_vaccinations))
	--	OVER(PARTITION BY dea.location  
	--		ORDER BY dea.location) as Total_Vaccination_Countrywise
FROM PortfolioProject..CovidDeaths AS dea
JOIN PortfolioProject..CovidVaccinations AS vac
	ON dea.location=vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
UPDATE #PercentPop
SET PeopleVaccinated=0
WHERE PeopleVaccinated IS NULL 

SELECT location, 
		Max(population) As Population,
		SUM(CONVERT(bigint,PeopleVaccinated)) As PeopleVaccinated,
		SUM(CONVERT(bigint,PeopleVaccinated))/Max(population)*100 AS PercentVaccinated
FROM #PercentPop
GROUP By location
ORDER by PeopleVaccinated desc





--Create View to store data for later visualization
CREATE VIEW PercentVaccinated AS
SELECT DISTINCT
	dea.location,
	MAX(dea.population) AS Population,
	SUM(CONVERT(bigint,vac.new_vaccinations)) AS vaccinations,
	--SUM(CONVERT(bigint,vac.new_vaccinations)) 
	--	OVER (
	--		PARTITION BY dea.location
	--		ORDER BY dea.location,dea.date) AS RollingPeopleVaccinated,
	CONCAT(SUM(CAST(ISNULL(vac.new_vaccinations,'0') as bigint))/	MAX(dea.population)*100,'%' ) as PercentageVaccinated
FROM PortfolioProject..CovidDeaths AS dea
Join PortfolioProject..CovidVaccinations AS vac
	On dea.location=vac.location
	AND  dea.date=vac.date
WHERE dea.continent IS NOT NULL
group by dea.location

