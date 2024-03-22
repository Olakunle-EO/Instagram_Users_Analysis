USE ig_clone;

-- 1. Find the 5 oldest user of the instagram from the database provided.
select username, created_at from users order by created_at limit 5;

-- Find the user who have never posted a single photo on instagram. 
select * from photos, users;
select * from users u left join photos p on p.user_id = u.id where p.image_url is null order by username;

-- 3. Indentify the winner of the contest and provide their name to the team
select * from likes, photos, users;

select likes.photo_id,users.username, count(likes.user_id) as nooflikess 
from likes inner join photos on likes.photo_id = photos.id
inner join users on photos.user_id = users.id group by likes.photo_id, users.username order by nooflikess desc ;

-- 4. Identify and suggest the top 5 most commonly used hashtags on the platform
select * from photo_tags,tags;
select t.tag_name,count(p.photo_id) as ht from photo_tags p inner join tags t on t.id=p.tag_id group by t.tag_name order by ht desc limit 5; 

-- 5. What day of the week do most users register on? Provide insight on when to schedule am ad campaign.
select * from users;
select date_format((created_at), '%Wd') as dayy,count(username) from users group by 1 order by 2 desc ;

-- 6. Provide how many times does average user post on instagram. Also, Provide the number of photos on instagram/Total numbers of users
select * from photos,users;
with base as (
select u.id as userid,count(p.id) as photoid from users u left join photos p on p.user_id = u.id group by u.id)
select sum(photoid) as Totalphotos,count(userid) as Totalusers, sum(photoid)/count(userid) as photoperuser
from base ;

-- 7. Provide data on users(bots) who have liked every single post on the site (since any normal user would not be able to do this)
select * from users,likes;
with base as ( 
select u.username,count(l.photo_id) as likess from likes l inner join users u on u.id = l.user_id
group by u.username)
select username,likess from base where likess=(select count(*) from photos) order by username;