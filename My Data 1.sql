SELECT TOP (1000) [iso_code]
      ,[continent]
      ,[location]
      ,[date]
      ,[new_tests]
      ,[total_tests_per_thousand]
      ,[new_tests_per_thousand]
      ,[new_tests_smoothed]
      ,[new_tests_smoothed_per_thousand]
      ,[positive_rate]
      ,[tests_per_case]
      ,[tests_units]
      ,[total_vaccinations]
      ,[people_vaccinated]
      ,[people_fully_vaccinated]
      ,[total_boosters]
      ,[new_vaccinations]
      ,[new_vaccinations_smoothed]
      ,[total_vaccinations_per_hundred]
      ,[people_vaccinated_per_hundred]
      ,[people_fully_vaccinated_per_hundred]
      ,[total_boosters_per_hundred]
      ,[new_vaccinations_smoothed_per_million]
      ,[new_people_vaccinated_smoothed]
      ,[new_people_vaccinated_smoothed_per_hundred]
      ,[stringency_index]
      ,[population_density]
      ,[median_age]
      ,[aged_65_older]
      ,[aged_70_older]
      ,[gdp_per_capita]
      ,[extreme_poverty]
      ,[cardiovasc_death_rate]
      ,[diabetes_prevalence]
      ,[female_smokers]
      ,[male_smokers]
      ,[handwashing_facilities]
      ,[hospital_beds_per_thousand]
      ,[life_expectancy]
      ,[human_development_index]
      ,[excess_mortality_cumulative_absolute]
      ,[excess_mortality_cumulative]
      ,[excess_mortality]
      ,[excess_mortality_cumulative_per_million]
  FROM [Portfolio Project].[dbo].['Covid Deaths reviewed 2]


  SELECT *
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  ORDER BY 3, 4

  SELECT *
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed 2]
  ORDER BY 3, 4

  --Selecting Specific Data to use
  SELECT Location, date, Population, total_cases,(total_cases/Population)*100 as DeathPercentage
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  --WHERE Location Like '%states%'
  Order by 1, 2

  --Trying to figure out the percentage of people that got infected
  SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population))*100 as PercentageOfPopulationInfected
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  --WHERE Location Like '%states%'
  GROUP BY Location, Population
  Order by PercentageOfPopulationInfected desc

  --Counts of Death
  SELECT Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  --WHERE Location Like '%states%'
  WHERE continent is Not Null
  GROUP BY Location
  Order by TotalDeathCount desc

  --Total cases Vs Deaths
  SELECT location, date, total_cases,total_deaths
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  Order by 1,2

  SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  --WHERE Location Like '%states%'
  WHERE continent is Not Null
  GROUP BY continent
  Order by TotalDeathCount desc


  --Countries with highest Death Count per Population

  SELECT location, MAX(cast(Total_deaths as int)) as TotalDeathCount
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  --WHERE Location Like '%states%'
  WHERE continent is Not Null
  GROUP BY location
  Order by TotalDeathCount desc


SELECT date, SUM(new_cases), SUM(new_deaths)
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  --WHERE Location Like '%states%'
  Where continent is Not Null
  GROUP BY date
  Order by 1,2

  --Group By
  SELECT DISTINCT (Continent)
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed$']
  GROUP BY continent

  

  SELECT *
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed 2] rev2
  Join [Portfolio Project].dbo.['Covid Deaths reviewed$'] rev$
      ON rev2.location = rev$.location
	  and rev2.date = rev$.date

  
  --Using CTE

	With PopvsVac (Continent, Location, Date, Population, New_Vaccination, NoOfPeopleVaccinated)
	as
	(
	SELECT rev$.continent, rev$.location, rev$.date, rev$.population, rev2.new_vaccinations
  ,SUM(CONVERT(int,rev2.new_vaccinations)) OVER (Partition by rev$.location order by rev$.location,
   rev$.Date) as NoOfPeopleVaccinated
   --,(NoOfPeopleVaccinated/population)*100
  FROM [Portfolio Project].dbo.['Covid Deaths reviewed 2] rev2
  Join [Portfolio Project].dbo.['Covid Deaths reviewed$'] rev$
      ON rev2.location = rev$.location
	  and rev2.date = rev$.date
	WHERE rev$.continent is Not Null
    --Order By 1, 2, 3
	)
	SELECT *
	FROM PopvsVac

	

	