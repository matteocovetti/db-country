-- 1. Selezionare tutte le nazioni il cui nome inizia con la P e la cui area è maggiore di 1000 kmq
select * 
from countries
where name like 'P%' and area > 1000;

-- 2. Selezionare le nazioni il cui national day è avvenuto più di 100 anni fa
select *
from countries
where TIMESTAMPDIFF(year, national_day, curdate())>100;

-- 3. Selezionare il nome delle regioni del continente europeo, in ordine alfabetico
select r.name 
from regions r 
inner join continents c 
on r.continent_id = c.continent_id 
where c.name = 'Europe'
order by r.name;

-- 4. Contare quante lingue sono parlate in Italia
select count(l.language_id) as lingue_in_italia
from languages l 
inner join country_languages cl 
on l.language_id = cl.language_id 
inner join countries c 
on c.country_id = cl.country_id 
where c.name = 'Italy';

-- 5. Selezionare quali nazioni non hanno un national day
select *
from countries c 
where national_day is null;

-- 6. Per ogni nazione selezionare il nome, la regione e il continente
select c.name , r.name , c2.name 
from countries c 
inner join regions r 
on c.region_id = r.region_id 
inner join continents c2 
on r.continent_id = c2.continent_id ;

-- 7. Modificare la nazione Italy, inserendo come national day il 2 giugno 1946
update countries c 
set national_day = '1946-06-02'
where c.name = 'Italy';

-- 8. Per ogni regione mostrare il valore dell'area totale
select r.name , sum(c.area) as area_totale
from regions r 
inner join countries c 
on r.region_id = c.region_id 
group by r.name
order by r.name;

-- 9. Selezionare le lingue ufficiali dell'Albania
select l.`language` 
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on l.language_id = cl.language_id 
where c.name = 'Albania' and cl.official = 1;

-- 10. Selezionare il Gross domestic product (GDP) medio dello United Kingdom tra il 2000 e il 2010
select c.name , avg(cs.gdp) as media_gdp
from countries c 
inner join country_stats cs 
on c.country_id = cs.country_id 
where c.name = 'United Kingdom' and cs.`year` >= 2000 and cs.`year` <= 2010
group by c.name ;

-- 11. Selezionare tutte le nazioni in cui si parla hindi, ordinate dalla più estesa alla meno estesa
select c.name , c.area , l.`language` 
from countries c 
inner join country_languages cl 
on c.country_id = cl.country_id 
inner join languages l 
on cl.language_id = l.language_id 
where l.`language` = 'hindi'
order by c.area desc;

-- 12. Per ogni continente, selezionare il numero di nazioni con area superiore ai 10.000 kmq ordinando i risultati 
-- a partire dal continente che ne ha di più
select c.name , count(c2.country_id) as nazioni_con_area_maggiore_di_10000
from continents c 
inner join regions r 
on c.continent_id = r.continent_id 
inner join countries c2 
on c2.region_id = r.region_id 
where c2.area > 10000
group by c.name
order by nazioni_con_area_maggiore_di_10000 desc;
