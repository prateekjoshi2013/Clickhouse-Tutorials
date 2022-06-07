--SELECT 
select "DateTime",Voltage from electricity.consumption ; --datetime is a keyword so we have to enclose them in double quotes
select * from electricity.consumption ;

/*
 *
 * LIMIT
limit the number of rows 
limit 10    limit the first 10
limit 10,5  limit the first 5 rows and return the next 10 rows
 
 */

select * from electricity.consumption limit 10,10;


/*
 * DISTINCT
 * to select distinct values from a column
 * 
 */*
 select distinct(Sub_metering_3) from electricity.consumption c ;
 
/*
 * SAMPLE
 * Clickhouse allows for sample clause for example
 * 
 * select avg(column_name) from table_name sample 8/10 offset 1/2
 * the avg value of a column from 80 % of the data is taken from 
 * the second half of data in the table
 */
 * 
 
 select avg(Sub_metering_3) from electricity.consumption sample 1/10 offset 3/4 ;

/*
 * WHERE 
 * 
 */*
 select "Date",Global_intensity from electricity.consumption where Voltage>=250.0 and Global_intensity<4.6;
 

/*
 * Group By
 * 
 * The group by is generally used with aggregate functions and they
 * are used to group rows with the identical values
 * 
 * multiple columns can be used for grouping and the data is grouped
 * based on the unique combination of these columns.
 * In the select statement the group by clause comes after the where 
 * clause and the order by clause follows the group by clause
 * */
 select avg(Voltage),"Date" from electricity.consumption group by "Date";

/**
 * ORDER BY
 * To sort the results from a select query, the order by clause is used.
 * The results can be ordered in ascending or descending order.In case 
 * the order is not specified
 */

select avg(Voltage) as avg_voltage ,"Date" from electricity.consumption group by "Date" having avg(Voltage) > 240 order by "Date" desc ;


/**
 * Create statement can be used to create a database , table , user and
 *  views CREATE DATABASE [ IF NOT EXISTS ] 
 *  database_name [ON CLUSTER cluster_name] 
 *  [ENGINE = engine(...)]
 * 
 * To create a database using a native engine, the following query is used
 * 
 *  CREATE DATABASE IF NOT EXISTS testing;
 * 
 * A new database will becreated and will be displayed in Dbeaver after
 * refreshing.
 * 
 * Create table statement
 * 
 * 	CREATE TABLE [IF NOT EXISTS] [database_name.]table_name [ON CLUSTER cluster_name ](
 * 	
 * 	column1 [datatype1] [DEFAULT | MATERIALIZED|ALIAS expr1] [compression_codec] [TTL expr1]
 *  column2 [datatype2] [DEFAULT | MATERIALIZED|ALIAS expr2] [compression_codec] [TTL expr2]
 * 
 * ) ENGINE = engine
 * 
 *  To create a simple table (using MergeTree engine), the following SQL statement can be used:
 * 
 * CREATE TABLE IF NOT EXISTS testing.test_table (
 * 	ID String,
 * 	NAME String DEFAULT ID CODEC(LZ4),
 *  Quantity UInt32 CODEC(ZSTD),
 *  TOTAL Float32 MATERIALIZED Quantity*3.14,
 *  Bill Float32 ALIAS Total*1,
 *  "Date" Date,
 *  CONSTRAINT quality_constraint CHECK Quantity>0
 * )
 * ENGINE = MergeTree()
 * PARTITION BY Date
 * ORDER BY (ID,Name,Date)
 * 
 * Explaination:
 * 
 * A new table named test_table is created under the database testing 
 * -we have six columns
 * -the table partitioned by date and ordered by ID,Name,Date
 * -while inseting if name is not available ID is used
 * -total column is materialized (derived from Quantity column) 
 *  we cannot insert data manually using the insert statement
 * -Bill is an alias and will not be stored in the disk
 * -default compression is using LZ4 like ZSTD
 */

 CREATE DATABASE IF NOT EXISTS testing;

 CREATE TABLE IF NOT EXISTS testing.test_table (
  	ID String,
  	Name String DEFAULT ID CODEC(LZ4),
    Quantity UInt32 CODEC(ZSTD),
    Total Float32 MATERIALIZED Quantity*3.14,
    Bill Float32 ALIAS Total*1,
    "Date" Date,
    CONSTRAINT quality_constraint CHECK Quantity>0
   )
   ENGINE = MergeTree()
   PARTITION BY Date
   ORDER BY (ID,Name,Date)
/**
 * VIEWS 
 * 
 * Views are like tables based on other tables and its contents are
 * -defined based on a sql query.
 * -Clickhouse supports normal as well as materialized view
 * -Normal views dont store data and read from another table
 * -Materialized View stores the data and read from another table,
 * -Materialized View stores the data which is processed by select query
 * -Materialized View can be used to populate data from a temporary table 
 * 	into permanent table (used in populating data from kafla source )
 *  or to store computed or aggregated values from othe tables
 * -Materiliazed View if you specify POPULATE , the existing table data is 
 *  inserted into the view when creating it, as if making a CREATE TABLE ... 
 *  AS SELECT ... . Otherwise, the query contains only the data inserted
 *  in the table after creating the view. We do not recommend using POPULATE
 *  ,since data inserted in the table during the view creation will not 
 *  be inserted in it.
 * 
 * CREATE [MATERIALIZED] VIEW [IF NOT EXISTS]
 * [database_name.]view_name [TO[database_name.]name] [ENGINE = engine]
 * [POPULATE] AS SELECT ....
 * 
 * The result set of the select statement will be available in the view
 * and if TO keyword is used, the data held in the view is inserted in 
 * the table.
 * 
 * Normal view 
 * 
 * CREATE VIEW testing.test_table_view AS SELECT ID,Name,"Date"
 * FROM testing.test_table
 * 
 * Materialized view
 * 
 * CREATE MATERIALIZED VIEW testing.test_table_materialized_view
 * ENGINE = MergeTree()
 * ORDER BY (ID,Name,"Date")
 * AS SELECT ID,Name,"Date" FROM testing.test_table;  
 * 
 * 
 */
  
  CREATE VIEW testing.test_table_view AS SELECT ID,Name,"Date"
  FROM testing.test_table
  
  DROP VIEW testing.test_table_view
  
  INSERT INTO testing.test_table(ID,Name,Quantity,"Date") VALUES 
  ('123a','John',5,'2020-09-05')
  
  SELECT * FROM testing.test_table_view ;
--  this will  have jimmy and  johny as these records
--  inserted after the test_table_view was
--  created  
   
  CREATE VIEW testing.test_table_view_1 AS SELECT ID,Name,"Date"
  FROM testing.test_table
  
  CREATE MATERIALIZED VIEW testing.test_table_materialized_view
  ENGINE = MergeTree()
  ORDER BY (ID,Name,"Date")
  AS SELECT ID,Name,"Date" FROM testing.test_table;  
 
   INSERT INTO testing.test_table(ID,Name,Quantity,"Date") VALUES 
  ('123b','Jimmy',7,'2020-09-05')
 
  SELECT * FROM testing.test_table_materialized_view ;
--  this will only have jimmy and not johny as johny was 
--  inserted before the test_table_materialized_view was
--  created  
  CREATE MATERIALIZED VIEW testing.test_table_materialized_view_1
  ENGINE = MergeTree()
  ORDER BY (ID,Name,"Date")
  AS SELECT ID,Name,"Date" FROM testing.test_table; 
 /**
 * INSERT INTO
 * 
 * INSERT INTO [database.]table_name [(column1,column2,column3)] 
 * VALUES (vlaue11,value12,value13),(value21,value22,value23),...
 */

 
 /**
  * DROP
  * DROP statement is used to drop an existing entity in 
  * Clickhouse which could be 
  * database
  * table
  * user
  * view
  * dictionary
  * 
  * DROP TABLE [IF EXISTS] [database_name.]table_name 
  * [ON CLUSTER cluster]
  * 
  * DROP DATABASE [IF EXISTS] [databse_name] [ON CLUSTER cluster]
  */

 /**
  * ALTER
  * Using alter statement to manipulate the columns update delete
  * data in the tables
  * 
  * ALTER TABLE database_name.table_name [ON CLUSTER cluster]
  * ADD | DROP | CLEAR | COMMENT | MODIFY column_name
  */

 	ALTER TABLE testing.test_table ADD 
 	COLUMN new_column1 Nullable(String)
 	DEFAULT toString('default1');
 	
 	ALTER TABLE testing.test_table ADD 
 	COLUMN new_column2 Nullable(String);
 
 	ALTER TABLE testing.test_table DROP 
 	COLUMN new_column2;
 
 
-- 	The partition info is mandatory here and it is not possible
-- 	to clear the column contents without partition information 
-- 	since this table is partitioned by the Date column

 	ALTER TABLE testing.test_table CLEAR
 	COLUMN new_column2 IN PARTITION tuple('2020-09-05')
 	
 	INSERT INTO testing.test_table
 	(ID,Name,Quantity,"Date",new_column1,
 	new_column2) VALUES ('123c','Jack',5,
 	'2020-09-05','Jack1','Jack2');
 
 	this will change the Quantity column to Float64
 	which was Int32 earlier.
 	
    ALTER TABLE testing.test_table MODIFY 
 	COLUMN IF EXISTS Quantity Float64 DEFAULT -1;
 
 	ALTER TABLE testing.test_table MODIFY 
 	COLUMN IF EXISTS Quantity Float32 DEFAULT -1;
 
 /**
  * UPDATES AND DELETES
  * 
  * updating the rows in batch 
  * 
  * ALTER TABLE [database_name.]table_name UPDATE 
  * col1=value1 [,...] WHERE expression
  * 
  * for deleting rows in batch
  * 
  * ALTER TABLE [database_name.]table_name DELETE 
  * WHERE expression
  * 
  */
 
   ALTER TABLE testing.test_table UPDATE 
   new_column1='Jimmy Anderson' WHERE 
   Name='Jimmy';
  
   ALTER TABLE testing.test_table DELETE 
   WHERE Name='Jack';
  
  /**
   * SHOW 
   * Show statement can be used to display info
   * -databases
   * -tables
   * -processes running
   * -query used to create table
   * 
   * SHOW CREATE [TEMPORARY] [TABLE|DICTIONARY]
   * [database_name.]table_name
   * 
   * SHOW TABLES [FROM | IN database_name] [LIKE ''|
   * WHERE filter_expression];
   */
  	
  	SHOW CREATE TABLE testing.test_table;
   
  	SHOW DATABASES;
   
    SHOW TABLES FROM testing WHERE name 
    LIKE '%view%';
 	
   	SHOW PROCESSLIST;
   
   /**
    * RENAME
    * 
    * Statement used to rename the tables
    * 
    * RENAME TABLE [database_name1.]table_name1 TO 
    * [database_name2.]table_name2 [ON CLUSTER cluster]
    */
   
   /**
    * USE
    * USE statement allows us to choose the database for 
    * the session.The database set to be used via the USE 
    * statement will be used by default if dbname is not 
    * explicitly mentioned
    * 
    * USE database_name; 
    */
    


