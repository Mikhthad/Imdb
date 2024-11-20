use imdb;
show tables;
select * from movies;

-- 1. List all actors (first name, last name, gender) from the actors table: 
select first_name,last_name,gender from actors;

-- 2. Find the number of movies directed by each director: 
select d.id,d.first_name,count(md.movie_id) as Total_movies  
from directors d left join movies_directors md
on d.id = md.director_id group by d.id,d.first_name;

-- 3. List all movies from the movies table released after the year 2000: 
select name,year from movies where year > 2000;

-- 4. Find the top 5 movies with the highest rank score: 
select * from movies order by rankscore desc limit 5;

-- 5. Count the number of male and female actors: 
select gender,count(*) as total from actors group by gender;

-- 6. Find the actors who played 'Demon' role in any movie:
select a.first_name,r.role from roles r left join actors a on r.actor_id = a.id where r.role = 'Demon';

-- 7. List all genres of movie with movie id = 1 belongs to: 
select * from movies_genres;
select * from movies_genres where movie_id in(1);

-- 8. Find all movies directed by 'Anthony Abrams':
select concat(d.first_name,' ' ,d.last_name)as full_name,m.name from 
movies m left join movies_directors md on m.id = md.movie_id 
left join directors d on d.id = md.director_id where concat(d.first_name,' ' ,d.last_name)= 'Anthony Abrams';

-- 9. Count the number of movies in each genre:
select genre,count(*) as Total from movies_genres group by genre;

-- 10. Find the top 5 directors with the highest average rank score:
select d.first_name,d.last_name,m.name,avg(m.rankscore) from 
directors d left join movies_directors md on d.id = md.director_id 
left join movies m on md.movie_id = m.id group by d.first_name,d.last_name,m.name
order by avg(m.rankscore) desc limit 5;

-- 11. List all the directors who have directed movies in more than one genre: 
select d.first_name,d.last_name,dg.genre from directors d 
left join directors_genres dg 
on d.id = dg.director_id 
where dg.director_id in 
(select director_id from directors_genres group by director_id having count(distinct genre )>1)
group by d.first_name,d.last_name,dg.genre;

-- 12. Find all actors who have worked in movies from the 'Action' genre: 
select a.first_name,a.last_name from actors A
left join roles r on a.id = r.actor_id 
left join movies_genres mg on r.movie_id = mg.movie_id 
where mg.genre = 'Action';

-- 13. Find all actors who have acted in more than 5 movies: 
select a.first_name,a.last_name from actors a 
left join roles r on a.id = r.actor_id 
where r.actor_id in(select actor_id from roles group by actor_id having count(movie_id)>5)
group by a.first_name,a.last_name;

-- 14. List all movies along with their directors and genres: 
select m.name,d.first_name,d.last_name,mg.genre from movies m 
right join movies_genres mg on m.id = mg.movie_id 
left join movies_directors md on m.id = md.movie_id
inner join directors d on md.director_id=d.id;

-- 15. Find the genre in which the highest number of directors have worked: 
select genre,count(director_id) from directors_genres 
group by genre order by count(director_id) desc limit 1;