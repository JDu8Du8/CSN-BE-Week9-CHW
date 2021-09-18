create database if not exists social_media;
use social_media;

create table if not exists users (
  user_id INT NOT NULL auto_increment,
  user_name VARCHAR(50) NOT NULL,
  pass VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  PRIMARY KEY (user_id)
  );
  
create table if not exists posts (
	post_id INT NOT NULL auto_increment,
    user_id INT NOT NULL,
    Title varchar(255),
    Content MEDIUMBLOB NULL,
    time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    );
  
create table if not exists comments (
  comment_id INT NOT NULL auto_increment,
  post_id INT NOT NULL,
  user_id INT NOT NULL,
  Content MEDIUMBLOB NULL,
  time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (comment_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (post_id) REFERENCES posts(post_id)
  );

-- Populate Tables
  Insert into users values ('1', 'jim', '123', 'jim@jim.com');
  Insert into users values ('2', 'bob', '456', 'bob@gmail.com');
  Insert into users values ('3', 'sam', '789', 'sam@hotmail.com');
  insert into posts values ('1', '1', 'Jim\'s Post', 'A post by Jim bbb', DEFAULT);
  insert into posts values ('2', '1', 'Jim\'s Other Post', 'Another Jim Post', DEFAULT);
  insert into posts values ('3', '3', 'Sam\'s Sample Post', 'A Sam Post', DEFAULT);
  insert into posts values ('4', '2', 'Bob Made A Post', 'The Bob Post', DEFAULT);
  insert into comments values ('1', '2', '1', 'Jim\'s Reply', DEFAULT);
  insert into comments values ('2', '3', '1', 'Jim\'s 2nd Reply', DEFAULT);
  insert into comments values ('3', '1', '3', 'Sam\'s Reply', DEFAULT);
  insert into comments values ('4', '3', '2', 'Bob\'s Reply', DEFAULT);
  insert into comments values ('5', '1', '3', 'Bob\'s 2nd Reply', DEFAULT);
  insert into comments values ('6', '1', '2', 'Sam\'s 2nd Reply', DEFAULT);
  insert into comments values ('7', '2', '1', 'Jim\'s 3rd Reply', DEFAULT);

-- User-to-Post Search
select u.user_name as 'USER', p.Title as 'TITLE', p.time_created as 'TIMESTAMP', 
	p.Content as 'ORIGINAL POST'
    from users u
    join posts p
    where u.user_id = p.user_id;

-- Users-to-Comments grouped by Comment ID 
select p.post_id, c.comment_id, u.user_name as 'USER', 
	p.Content as "POST CONTENT", p.time_created as 'TIMESTAMP',
	p.Title as 'TITLE', c.Content as 'COMMENT', c.time_created as 'TIMESTAMP'
    from users u
    join posts p
    join comments c
    where c.user_id = p.user_id and p.user_id = u.user_id 
		and u.user_id = c.user_id group by c.comment_id;
    
