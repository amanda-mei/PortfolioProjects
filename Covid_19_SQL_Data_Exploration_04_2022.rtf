{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww19200\viewh13240\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 /* Covid-19 Data Exploration \
\
SQL Skills Used: Joins, CTE's, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types\
*/\
\
\
-- Setup covid deaths table in pgAdmin with data types\
\
CREATE TABLE covid_deaths (\
	iso_code varchar(255),\
	continent varchar(255),\
	location varchar(255),\
	dt date,\
	population float,\
	total_cases float,\
	new_cases float,\
	new_cases_smoothed float,\
	total_deaths float,\
	new_deaths float,\
	new_deaths_smoothed float,\
	total_cases_per_million float,\
	new_cases_per_million float,\
	new_cases_smoothed_per_million float,\
	total_deaths_per_million float,\
	new_deaths_per_million float,\
	new_deaths_smoothed_per_million float,\
	reproduction_rate float,\
	icu_patients bigint,\
	icu_patients_per_million float,\
	hosp_patients bigint,\
	hosp_patients_per_million float,\
	weekly_icu_admissions bigint,\
	weekly_icu_admissions_per_million float,\
	weekly_hosp_admissions bigint,\
	weekly_hosp_admissions_per_million float\
);\
\
-- Check data in table\
SELECT * from covid_deaths\
\
-- Select data to be used\
\
SELECT \
location, dt, total_cases, new_cases, total_deaths, population \
FROM covid_deaths\
\
-- Total Cases vs Total Deaths, dates ordered descending \
\'97 Likelihood of fatal Covid case\
SELECT \
location, dt, total_cases, total_deaths, (total_deaths/total_cases) * 100 as death_percentage\
FROM covid_deaths\
WHERE location like '%States'\
ORDER BY dt DESC;\
\
-- Total Cases versus Population\
-- Shows what percentage of population got Covid\
\
SELECT \
location, dt, total_cases, population, (total_cases/population) * 100 as total_cases_vs_pop\
FROM covid_deaths\
WHERE location like '%States'\
ORDER BY dt DESC;\
\
-- Countries with Highest Infection Rate compared to Population\
\
SELECT \
location, population, MAX(total_cases) as highest_infection_count, \
MAX((total_cases/population)) * 100 as percent_population_infected\
FROM covid_deaths\
--WHERE location like '%States'\
GROUP BY location, population\
ORDER BY percent_population_infected DESC\
\
-- Highest Death Count compared to Population\
-- use cast to convert to integer\
SELECT \
location, MAX(cast(total_deaths as int)) as HighestDeathCount\
FROM covid_deaths\
WHERE continent is not null\
GROUP BY location\
ORDER BY HighestDeathCount DESC\
\
\
-- BREAD DOWN BY CONTINENT\
\
-- Continents with the Highest Death Count\
SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount\
FROM covid_deaths\
WHERE continent is null\
GROUP BY location\
ORDER BY HighestDeathCount DESC\
\
-- Showing the Countries with the Highest Death Count in Europe Only\
SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount\
FROM covid_deaths\
WHERE continent like 'Europe'\
GROUP BY location\
ORDER BY HighestDeathCount DESC\
\
-- GLOBAL NUMBERS\
SELECT dt, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, \
SUM(new_deaths)/SUM(new_cases)*100 as death_percentage_global\
FROM covid_deaths\
WHERE continent is not null\
GROUP BY dt\
ORDER BY dt\
\
-- Total Aggregate Cases\
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, \
SUM(new_deaths)/SUM(new_cases)*100 as death_percentage_global\
FROM covid_deaths\
WHERE continent is not null\
\
\
-- setup covid vaccinations table in pgAdmin\
CREATE TABLE covid_vaccinations (\
iso_code varchar(255),\
continent varchar(255),\
location varchar(255),\
dt date,\
new_tests float,\
total_tests_per_thousand float,\
new_tests_per_thousand float,\
new_tests_smoothed float,\
new_tests_smoothed_per_thousand float,\
positive_rate float,\
tests_per_case float,\
tests_units varchar(255),\
total_vaccinations float,\
people_vaccinated float,\
people_fully_vaccinated float,\
total_boosters float,\
new_vaccinations float,\
new_vaccinations_smoothed float,\
total_vaccinations_per_hundred float,\
people_vaccinated_per_hundred float,\
people_fully_vaccinated_per_hundred float,\
total_boosters_per_hundred float,\
new_vaccinations_smoothed_per_million float,\
new_people_vaccinated_smoothed float,\
new_people_vaccinated_smoothed_per_hundred float,\
stringency_index float,\
population bigint,\
population_density float,\
median_age float,\
aged_65_older float,\
aged_70_older float\
);\
\
-- Total Population vs Vaccinations\
SELECT dea.continent, dea.location, dea.dt, dea.population, vac.new_vaccinations,\
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.dt) \
as rolling_people_vaccinated,\
from covid_deaths dea\
join covid_vaccinations vac\
	on dea.location = vac.location\
	and dea.dt = vac.dt\
where dea.continent is not null\
order by 2,3\
\
-- Use CTE\
\
With PopvsVac (continent, location, dt, population, new_vaccinations, rolling_people_vaccinated)\
as\
(\
SELECT dea.continent, dea.location, dea.dt, dea.population, vac.new_vaccinations,\
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.dt) \
as rolling_people_vaccinated\
from covid_deaths dea\
join covid_vaccinations vac\
	on dea.location = vac.location\
	and dea.dt = vac.dt\
where dea.continent is not null\
--order by 2,3\
)\
\
SELECT *, (rolling_people_vaccinated/population)*100 as pop_vs_vac\
FROM PopvsVac\
\
-- Creating View to store data for later visualizations\
\
SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount\
FROM covid_deaths\
WHERE continent is null\
GROUP BY location\
ORDER BY HighestDeathCount DESC\
\
Create View PercentPopulationVaccinated as\
SELECT dea.continent, dea.location, dea.dt, dea.population, vac.new_vaccinations,\
SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.dt) \
as rolling_people_vaccinated\
from covid_deaths dea\
join covid_vaccinations vac\
	on dea.location = vac.location\
	and dea.dt = vac.dt\
where dea.continent is not null\
\
-- Check the View: PercentPopulationVaccinated\
SELECT * FROM PercentPopulationVaccinated\
\
-- Creating View: PercentPopulationInfected\
Create View PercentPopulationInfected as\
SELECT \
location, population, MAX(total_cases) as highest_infection_count, \
MAX((total_cases/population)) * 100 as percent_population_infected\
FROM covid_deaths\
GROUP BY location, population\
ORDER BY percent_population_infected DESC\
\
-- Check the View: PercentPopulationInfected\
SELECT * FROM PercentPopulationInfected\
\
\
}