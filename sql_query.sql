CREATE TABLE IF NOT EXISTS payers (
    Id CHAR(36) PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(100),
    State_headquartered CHAR(2),
    Zip VARCHAR(10),
    Phone VARCHAR(20)
);


ALTER TABLE public.payers 
ALTER COLUMN state_headquartered TYPE VARCHAR(5);


-- Create patients table
CREATE TABLE IF NOT EXISTS patients (
    Id CHAR(36) PRIMARY KEY,
    BIRTHDATE DATE,
    DEATHDATE DATE,
    PREFIX VARCHAR(10),
    FIRST VARCHAR(100),
    LAST VARCHAR(100),
    SUFFIX VARCHAR(10),
    MAIDEN VARCHAR(100),
    MARITAL CHAR(1),
    RACE VARCHAR(50),
    ETHNICITY VARCHAR(50),
    GENDER CHAR(1),
    BIRTHPLACE VARCHAR(255),
    ADDRESS VARCHAR(255),
    CITY VARCHAR(100),
    STATE VARCHAR(100),
    COUNTY VARCHAR(100),
    ZIP VARCHAR(10),
    LAT DOUBLE PRECISION,
    LON DOUBLE PRECISION
);




-- Create procedures table
DROP TABLE IF EXISTS public.procedures;

-- Create the table structure
CREATE TABLE public.procedures (
    start TEXT,                 -- Temporary TEXT type to handle the "to" in CSV
    stop TEXT,                  -- Temporary TEXT type to handle the "to" in CSV
    patient CHAR(36),
    encounter CHAR(36),
    code VARCHAR(20),
    description VARCHAR(255),
    base_cost NUMERIC,          -- Handles decimals and large numbers
    reasoncode VARCHAR(20),
    reasondescription VARCHAR(255)
);




DROP TABLE IF EXISTS public.encounters;

-- 2. Create the table with corrected types
CREATE TABLE public.encounters (
    id CHAR(36) PRIMARY KEY,
    start TEXT,                 -- Changed to TEXT to handle the "to" in your CSV
    stop TEXT,                  -- Changed to TEXT to handle the "to" in your CSV
    patient CHAR(36),
    organization CHAR(36),
    payer CHAR(36),
    encounterclass VARCHAR(50),
    code VARCHAR(20),
    description VARCHAR(255),
    base_encounter_cost DECIMAL(10,2),
    total_claim_cost DECIMAL(10,2),
    payer_coverage DECIMAL(10,2),
    reasoncode VARCHAR(20),
    reasondescription VARCHAR(255)
);



-- 2. Create Organizations Table
CREATE TABLE IF NOT EXISTS organizations (
    Id UUID PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(100),
    State CHAR(2),
    Zip VARCHAR(10),
    Lat NUMERIC,
    Lon NUMERIC
);



select *from data_dictionary;
select *from encounters;
select *from organizations;
select *from patients;
select *from payers;
select *from procedures;



-- 1. Harmonize types for Patients, Organizations, and Payers
ALTER TABLE public.patients ALTER COLUMN id TYPE TEXT;
ALTER TABLE public.organizations ALTER COLUMN id TYPE TEXT;
ALTER TABLE public.payers ALTER COLUMN id TYPE TEXT;

-- 2. Harmonize types for Encounters (The middle table)
ALTER TABLE public.encounters ALTER COLUMN id TYPE TEXT;
ALTER TABLE public.encounters 
  ALTER COLUMN patient TYPE TEXT,
  ALTER COLUMN organization TYPE TEXT,
  ALTER COLUMN payer TYPE TEXT;

-- 3. Harmonize types for Procedures (Notice no "id" column here)
ALTER TABLE public.procedures 
  ALTER COLUMN patient TYPE TEXT,
  ALTER COLUMN encounter TYPE TEXT;

-- 4. Create the Relationship Lines
-- Linking Encounters to its parents
ALTER TABLE public.encounters
  ADD CONSTRAINT fk_encounters_patients FOREIGN KEY (patient) REFERENCES public.patients (id),
  ADD CONSTRAINT fk_encounters_organizations FOREIGN KEY (organization) REFERENCES public.organizations (id),
  ADD CONSTRAINT fk_encounters_payers FOREIGN KEY (payer) REFERENCES public.payers (id);

-- Linking Procedures to its parents
ALTER TABLE public.procedures
  ADD CONSTRAINT fk_procedures_patients FOREIGN KEY (patient) REFERENCES public.patients (id),
  ADD CONSTRAINT fk_procedures_encounters FOREIGN KEY (encounter) REFERENCES public.encounters (id);



 -- a. How many total encounters occurred each year?
select extract(year from replace("start",'to','')::timestamp) as count_per_year,count(*) as count_year
from encounters
group by count_per_year
order by count_per_year;

-- b. For each year, what percentage of all encounters belonged to each encounter class
-- (ambulatory, outpatient, wellness, urgent care, emergency, and inpatient)?


select count_per_year,count(*)count_year,encounterclass,round(count(*)*100/sum(count(*)) over(encounterclass),2)
from(
	select extract(year from replace("start",'to','')::timestamp) as count_per_year,encounterclass
	from encounters)as subquery
group by count_per_year
order by count_per_year


-- c. What percentage of encounters were over 24 hours versus under 24 hours?

select 
	case when (replace("stop",'to',' ')::timestamp-replace("start",'to',' ')::timestamp)>=interval '24 hours'
	then 'over 24 hours'
	else 'under 24 hours'
	end AS duration_category,
	round(count(*)*100/sum(count(*))over(),2)AS percentage
	from encounters
	group by duration_category
	

-- OBJECTIVE 2: COST & COVERAGE INSIGHTS
-- a. How many encounters had zero payer coverage, and what percentage of total encounters does this represent?
select count(*) filter(where payer_coverage=0) as zero_coverage,
round(count(*)filter(where payer_coverage=0)*100/count(*),2)per_of_total
from encounters

-- b. What are the top 10 most frequent procedures performed and the average base cost for each?
select description,count(*) as frequancy,round(avg("base_encounter_cost"::numeric),2) as avg_base_cost
from encounters
group by description
order by frequancy desc
limit 10

-- c. What are the top 10 procedures with the highest average base cost and the number of times they were performed?
select description,count(*) as frequancy,round(avg("base_encounter_cost"::numeric),2) as avg_base_cost
from encounters
group by description
order by avg_base_cost desc
limit 10


-- d. What is the average total claim cost for encounters, broken down by payer name?
	select p.name,round(avg(e.total_claim_cost::numeric),2) as avg_cailm
	from encounters e
	join payers p on e.payer=p.id
	group by p.name	
	order by avg_cailm desc

-- a. How many unique patients were admitted each quarter over time?
select concat(p.first,p.last) as patient_name,
extract(year from replace(e.start,'to',' ')::timestamp)as by_year,
extract(quarter from replace(e.start,'to','')::timestamp) as by_quarter
from encounters as e
join patients as p on e.patient=p.id
GROUP BY by_year, by_quarter,patient_name
ORDER BY by_year DESC, by_quarter DESC;


-- b. How many patients were readmitted within 30 days of a previous encounter? 
with dummy as(select patient,replace(start,'to',' ')::timestamp AS start_time,
		lag(replace(stop,'to',' ')::timestamp)over(partition by patient ORDER BY REPLACE(start, ' to ', ' ')::timestamp)as last_stop_time
		from encounters e)
	select concat(p.first,p.last) as patient_name,count(*) as readdmited,d.patient,d.start_time,d.last_stop_time
	from dummy d
	join  patients p
	on d.patient=p.id
	where d.start_time-d.last_stop_time<=interval '30 days'
	group by d.patient,p.first,p.last,d.start_time,d.last_stop_time
	order by  readdmited desc
	limit 10
		
	