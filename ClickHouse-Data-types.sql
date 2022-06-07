/* 
checking for null  
is null or is not null
returns 0 and 1 
clickhouse does not have boolean type so values 0 and 1 represent boolean values

Data types

Numeric

Integers

int16,int32,int64....
uint16,uint32,uint64 ...
 
Floats

float32,float64
INF and -INF (infinity both + and - ) 
nan (not a number)

Decimal

Decimal32(S),Decimal64(S),Decimal128(S) 
S is a parameter that determinse the number of 
decimal digits that are allowed in fraction

Boolean

clickhouse does not have boolean type so values 0 and 1 
represent boolean values clickhouse uses Uint8 datatype 
with values 0 and 1

String

represented by string type 
can be of any length
not encoded
stored as set of bytes
are enclosed in single quotes while querying

FixedString

this datatype is used to represent a string of fixed length(N bytes).
if the values are less than N bytes at the time of inserting the data
in the table, Clickhouse will automatically add Null bytes, an exception 
is thrown

At the time of querying if the search string is shorter than the 
defined length (N bytes), the Null bytes should be included in the 
column is defined as type FixedString(3) and named a ,to search it 
should be padded with one more null byte and searched as it is shorter
than the defined length. 

select * from table where a = 'ch\o'

Date

clickhouse stores date as the number of days since 1970-0-01 (unix epoch)
The upper limit for the date is until the year 2105.
The date values are stored in two bytes.

DateTime

DateTime type stores the timestamp and is expressed as the calendar date 
and time of the day.

The resolution is 1 second and milliseconds are not supported.
Time zone can be defined for the entire column in table
By default output is in YYYY-MM-DD hh:mm:ss
If time zone is not specified the clickhouse server-time zone


DateTime

milliseconds are not supported.

Arrays

Arrays are a collection of items.Clickhouse arrays can be created 
using array() function or enclosing the array elements in square 
brackets 

Tuples

Tuples allow incompatible data types

Nested 

create table nested_example(
	dt Date,
	ID UInt32,
	code Nested(
		code_id String,
		`count` UInt32
		)
	)
	engine=MergeTree(dt,ID,8192)
	
insert into nested_example values('2020-11-01',77,['1','2','3'],[123,654,785])
--error as the nested columns not of equal length
insert into nested_example values('2020-11-01',77,['1','2'],[123,654,785]) 

Enum
Enumerated datatype consists of named values like a dictionary
and is declared with string (name) and a corresponding value 
(8 bit or 16-bit integer) for the name
**/

select 0/0; --NAN
select 3.14/0; -- infinity
select -3.14/0; -- -infinity
select toFloat32(20); -- float
select 'Hello World!';
select toDate('2020-01-01') --Date
select toDate('1968-12-31') --returns 1970-01-01
select toDateTime('2020-01-01 00:00:00') --DateTime 
select toDateTime64('2020-01-01 00:00:00.0000',4,'Europe/London') --DateTime64 millisecond , precision ,timezone
select array('a','b','c',NULL) as x;
select ['a','b','c','d'] as x; 
select [1,2,3,4.0] as x; --numeric types
select [1,2,3,4.0,'a'] as x; --incompatible types error
select tuple(1,2,'a',toDate('2020-01-01',Null)) as x, toTypeName(x) --tuple allows incompatible types

--Nested Type

create table nested_example(
	dt Date,
	ID UInt32,
	code Nested(
		code_id String,
		`count` UInt32
		)
	)
	engine=MergeTree(dt,ID,8192)
	
insert into nested_example values('2020-11-01',77,['1','2','3'],[123,654,785])



--Enum

create table enum_example (
	col1 Enum('a'=1,'b'=2)
)Engine TinyLog
insert into enum_example values ('a'),('b'),('a'),('b');
insert into enum_example values (1),(2),(1),(2);



