-- Netflix Project

Create table Netflix
( 
  show_id Varchar(10),
  type	  varchar(10),
  title   Varchar(200),
  director	varchar(210),
  casts      Varchar(1000),
  country	Varchar(150),
  date_added	Varchar(50),
  release_year	Int,
  rating  Varchar(10),
  duration	Varchar(15),
  listed_in	Varchar(150),
  description Varchar(250)
);

Select * from netflix;
