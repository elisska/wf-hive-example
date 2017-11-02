ALTER TABLE input_ratings ADD IF NOT EXISTS PARTITION(year=${YEAR}) LOCATION '/data/input/input_ratings/${YEAR}';

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

insert into table target_table PARTITION (year)
select ir.UserID, ir.MovieID, m.title, m.genres, ir.rating, ir.time_stamp, year
from input_ratings ir
left join movies m
on ir.movieID = m.movieID
where ir.year = ${YEAR};
