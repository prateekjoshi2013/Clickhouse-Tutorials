/**
 * CHAPTER 5
 * SQL Functions 
 * 
 * there are two types of functions
 * regular functions and aggregate 
 * functions
 * 
 * 
 * -type conversion of the input is important
 * -if any one of the args is null the func returns null
 * -if invalid data is passed it throws an exception and 
 *  query is cancelled and error text is returned to client
 * -Constants as arguments and constant expressions are also
 *  supported
 * 
 *  DATA TYPE CONVERSION
 * -Be cautious s it is prone to data loss like 
 *  from Float64 to Int32
 *  
 *  Integers
 *  
 *  these are available to Int/UInt or Null/Zero
 * 
 * 	toInt[8/16/32/64](expression)
 *  toUInt[8/16/32/64](expression)
 *  toInt[8/16/32/64]OrZero(expression) -- string as argument
 *  toUInt[8/16/32/64]OrZero(expression) -- string as argument
 *  toInt[8/16/32/64]OrNull(expression) -- string as argument
 *  toUInt[8/16/32/64]OrNull(expression) -- string as argument
 * 
 *  Float
 * 
 * 	toFloat[32/64](expression)
 *  toFloatOrZero[32/64](expression)
 *  toFloatOrNull[32/64](expression)
 * 
 *  Decimal
 * 
 * 	toDecimal[32/64/128](value_to_be_converted, decimal_places)
 *  toDecimal[32/64/128]OrZero(value_to_be_converted, decimal_places)
 *  toDecimal[32/64/128]OrNull(value_to_be_converted, decimal_places)
 * 
 * 	Date & DateTime
 *  
 *  toDate(value)
 *  toDateTime(value)
 *  toDateOrZero(value)
 *  toDateTimeOrZero(value)
 *  toDateOrNull(value)
 *  toDateTimeOrNull(value)
 * 
 * 	String
 *  
 *  toFixedString(value,length) - string as arg and output is fixed string with const length
 *  toStringCutToZero(value) - string or fixed string type as arg 
 * 
 * 	Mathematical Functions
 *  
 *  e() , pi()
 *  
 * Rounding functions
 * 
 * round(value,[decimal_places])
 * ceil(value,[decimal_places])
 * floor(value,[decimal_places])
 * 
 * Date/DateTime
 * 
 * current datetime
 * now()
 * 
 * current today's date
 * today()
 * 
 * current yesterday's date
 * yesterday()
 * 
 * toYear()
 * toQuarter()
 * toMonth()
 * toWeek()
 * 
 * SELECT toDateTime('2020-05-05 07:06:51') as ts, toYear(ts) , toQuarter(ts) ,toMonth(ts) ,toWeek(ts) 
 * SELECT toDateTime('2020-05-05 07:06:51') as ts, toHour(ts) , toMinute(ts) ,toSecond(ts) 
 * SELECT toDate('2020-05-01') as dt , toDayOfWeek(dt) ,toDayOfMonth(dt) ,toDayOfYear(dt) 
 * SELECT toDateTime('2020-05-01 02:35:44','US/Samoa') as samoa_ts , toTimeZone(samoa_ts,'Asia/Kolkata')
 * SELECT toUnixTimestamp('2020-05-01 02:35:44')
 *  
 */

SELECT toInt8(-322.8),toInt16(322.8),toInt8(-322.8),
toInt32('-322'),toInt32OrZero('-32a2')

SELECT toFloat32(-322+255.67) ,toFloat64('322002220.87'),
toFloat32OrZero('-322.0a'),toFloat64OrZero('322002220.87')

SELECT toDecimal32(3.14126876868,8),toDecimal64('2548.87',8)

SELECT toDate('2020-08-01'), toDate(-100) ,toDate(100), toDate(100.5)
,toDateTime('2020-08-01 00:00:00'),toDateTime(-2),toDateTime(2),
toDateTime(-2.2)

SELECT toString(77),toString(32.1),toString(toDate('2002-08-01')),
toFixedString(toString(1235),5),toStringCutToZero('abc\0def\0g')

SELECT e(),pi()
SELECT exp(0), exp2(3.14) , exp10(3.14)
SELECT log(1), ln(2.0) , log2(3.14) , log10(3.14)
SELECT sqrt(2.0),cbrt(8.0) ,power(3,3)
SELECT sin(90),cos(270),tan(45),asin(0.99),acos(0.2),atan(0.1)
SELECT round(10.5354),round(10.535,2),ceil(10.535,2),floor(10.536,2)
SELECT now(),today(),yesterday()

SELECT toDateTime('2020-05-05 07:06:51') as ts, toYear(ts) , toQuarter(ts) ,toMonth(ts) ,toWeek(ts) 
SELECT toDateTime('2020-05-05 07:06:51') as ts, toHour(ts) , toMinute(ts) ,toSecond(ts) 
SELECT toDate('2020-05-01') as dt , toDayOfWeek(dt) ,toDayOfMonth(dt) ,toDayOfYear(dt) 
SELECT toDateTime('2020-05-01 02:35:44','US/Samoa') as samoa_ts , toTimeZone(samoa_ts,'Asia/Kolkata')
SELECT toUnixTimestamp('2020-05-01 02:35:44')
SELECT toDateTime('2020-05-05 07:06:51') as ts,toStartOfYear(ts) as year_start,toStartOfISOYear(ts) as  start_iso_year,toStartOfQuarter(ts) as quarter_start,toStartOfMonth(ts) as month_start
SELECT toDateTime('2020-05-05 07:06:51') as ts, toMonday(ts) as nearest_monday, toStartOfWeek(ts) as week_start
SELECT toDateTime('2020-05-05 07:06:51') as ts, toStartOfDay(ts) as day_start, toStartOfHour(ts) as hour_start , toStartOfMinute(ts) as minute_start
SELECT toDateTime('2020-05-05 07:06:51') as ts, toStartOfFiveMinute(ts) as five_mins, toStartOfTenMinutes(ts) as ten_mins , toStartOfFifteenMinutes(ts) as fifteen_mins
SELECT toDateTime('2020-05-05 07:06:51') as ts, toYYYYMM(ts) as YYYYMM, toYYYYMMDD(ts) as YYYYMMDD, toYYYYMMDDhhmmss(ts) as YYYYMMDDhhmmss

/**
 * Date Arithmatic
 */

--TIME DIFFERENCE
SELECT dateDiff('second',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-02-08 16:40:00')) as seconds_diff
SELECT dateDiff('minute',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-02-08 16:40:00')) as minutes_diff
SELECT dateDiff('hour',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-02-08 16:40:00')) as hours_diff
SELECT dateDiff('day',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-02-09 16:40:00')) as day_diff
SELECT dateDiff('week',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-02-17 16:40:00')) as week_diff
SELECT dateDiff('month',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-03-08 16:40:00')) as month_diff
SELECT dateDiff('quarter',toDateTime('2020-02-08 10:00:00'),toDateTime('2020-07-08 16:40:00')) as quarter_diff
SELECT dateDiff('year',toDateTime('2020-02-08 10:00:00'),toDateTime('2021-02-08 16:40:00')) as year_diff

--SUBTRACTING TIME UNITS 
SELECT toDateTime('2020-02-08 16:40:00') as ts, subtractYears(ts,7) as sub_years , subtractMonths(ts,7) as sub_months
, subtractWeeks(ts,7) as sub_weeks , subtractDays(ts,7) as sub_days

SELECT toDate('2020-02-08 16:40:00') as ts, subtractHours(ts,7) as sub_hours , subtractMinutes(ts,7) as sub_minutes
, subtractSeconds(ts,7) as sub_seconds

--ADD TIME UNITS
SELECT toDateTime('2020-02-08 16:40:00') as ts,addYears(ts,7) as add_years ,addMonths(ts,7) as add_months ,addWeeks(ts,7) as add_weeks,
addDays(ts,7) as add_days

SELECT toDate('2020-02-08') as ts, addHours(ts,7) as add_hours , addMinutes(ts,7) as add_minutes ,addSeconds(ts,7) as add_seconds; 

--DATE TIME FORMATTING

SELECT formatDateTime(toDate('1996-11-01'),'%d/%m/%Y') as formatted_date1,formatDateTime(toDate('1996-11-01'),'%D') as formatted_date2

--format modifiers in docs

/*
 * Strings
 * 
 * Strings are not encoded in clickhouse and are stored as bytes.
 * */ 

--EMPTY STRING
SELECT empty(''),empty('Hi!');
SELECT notEmpty(''),notEmpty('Hi!');

--STRING LENGTH
SELECT '~𝘈Ḇ𝖢𝕯٤ḞԍНǏ' as text,length(text) as length, char_length(text) as char_length,
lengthUTF8(text) as lengthUTF8, character_length(text) as character_length;

--STRING CASE CONVERSION
SELECT 'Rain' as text , lower(text) as lower, upper(text) as upper;
SELECT '\x52\x61\x69\x6E' as text, lowerUTF8(text) as lower, upperUTF8(text) as upper;

--STRING MANIPULATION
SELECT 'air' as text,repeat(text,3) as repeat, reverse(text) as reverse, concat(text,'water') as concat;

--STRING EXTRACT
SELECT 'MANHATTAN' as text ,substring(text,4,3) as substring ,
substr(text,4,3) as substr , mid(text,4,3) as mid;

--STRING REMOVE WHITESPACES
SELECT '          HELLO          ' as txt,trimLeft(txt) as trim_left ,trimRight(txt) as trim_right 
, trimBoth(txt) as trim_both; 

--STRING REMOVING A SEQUENCE OF CHAR
SELECT '***Hello , world!***' as text , trim(BOTH '*' FROM text) as trimmed

--STARTSWITH
SELECT 'Hello' as txt, startsWith(txt,'H') starts_with_H, startsWith(txt,'A') starts_with_A

--ENDSWITH
SELECT 'Hello' as txt, endsWith(txt,'lo') ends_with_lo, endsWith(txt,'A') ends_with_A

/***
 * Searching in strings
 */

SELECT 'She sells sea shells, on the sea shore!' as txt, position(txt,'sea') as position
,multiSearchAllPositions(txt,['sea','shore']) as multiple_positions;

SELECT 'She sells sea shells, on the sea shore!' as txt, positionCaseInsensitive(txt,'sea') as position
,multiSearchAllPositions(txt,['sea','shore']) as multiple_positions;

SELECT 'She sells sea shells, on the sea shore!' as txt
,multiSearchFirstPosition(txt,['sea','shore']) as multiple_positions
,multiSearchFirstPositionCaseInsensitive(txt,['sea','shore']) as multiple_positions_case_insensitive;

/**
 * SEARCHING DOR OCCURENCE OF AT LEAST ONE SUBSTRING
 * 
 */

SELECT 'She sells sea shells, on the sea shore!' as txt,
multiSearchAny(txt,['shop','shore','sea']) as search_any_yes,
multiSearchAny(txt,['shop','share','see']) as search_any_no,
multiSearchAnyCaseInsensitive(txt,['shop','shore','sea']) as search_any_ca_yes,
multiSearchAnyCaseInsensitive(txt,['shop','share','see']) as search_any_ca_no,
match(txt,'he.') as matched, -- using regular exprs
match(txt,'[\d]') as not_match, -- using regular exprs
multiMatchAny(txt,['[\d]','sea.']) as multi_match,
multiMatchAny(txt,['[\d]','john']) as no_multi_match,
multiMatchAllIndices(txt,['[\d]','sea.','she.']) as multi_match_all_indices,
like(txt,'%sea%') as like,
notLike(txt,'%sea%') as not_like,
extract(txt,'s...s') as extract, -- Extracting substrings using regular expressions
extractAll(txt,'s...s') as extract_all;

/**
 * Replacing substrings from the source string
 */

SELECT 'She sells sea shells, on the sea shore!' as txt,
replaceOne(txt,'sea','SEA') as replace_one,
replaceAll(txt,'sea','SEA') as replace_all,
replaceRegexpOne(txt,'s..','SEA'),
replaceRegexpAll(txt,'s..','SEA');


/**
 * Array functions
 * 
 * Arrays in click house have similar functions as strings have for data 
 * manipulation
 * 
 */

SELECT array(1,2,3) as arr,empty(arr) as is_empty,notEmpty(arr) 
as is_not_empty,length(arr) as length;

/**
 * Creating empty arrays
 * 
 */

SELECT emptyArrayUInt8() as int_arr,
emptyArrayFloat32() as float_arr,
emptyArrayString() as string_arr,
emptyArrayDateTime() as date_time_arr;

/**
 * Array concatenation
 */

SELECT arrayConcat([1,2,3],[7,8,9],[4,5,6]) as concat_array;

/**
 * Accessing the array elements
 */

SELECT array('a','b','c') as arr, 
arrayElement(arr,2) array_element,
has(arr,'e') as has_element,
hasAll(arr,['a','b']) as hasAll,
hasAny(arr,['c','d','e']) as has_any;

/*
 * Finding and counting elements
 */*
 
 SELECT array(3,1,2,4,5,1,2,3) as arr, 
 indexOf(arr,2) as index,
 countEqual(arr,2) as count;

/**
 * Push and pop operations
 */
 
SELECT array(1,2,4) as arr,
arrayPushFront(arr,7) as push_front,
arrayPushBack(arr,7) as push_back,
arrayPopFront(arr) as pop_front,
arrayPopBack(arr) as pop_back;

/**
 * Slicing and resizing
 * arraySlice()- 3 args -> array, starting index,length of slice(optional)
 * arrayResize()- 3 args -> array, new size, default padding value (optional)
*/
	
 SELECT array(1,2,3,4,5) as arr , 
	arraySlice(arr,3,2) as slice , 
	arrayResize(arr,7,7) as resize;


/*
 * Sorting the array 
 */
 * *
 
 SELECT array(3,1,8,4,5,2) as arr, arraySort(arr) as sort,
 arrayReverseSort(arr) as rev_sort;

/**
 * Unique elements in an array
 */

SELECT array(3,1,2,4,5,1,2,3) as arr,arrayUniq(arr) as unique_count,
arrayDistinct(arr) as unique_elements;
 
/**
 * Splitting and merging arrays and strings
 * 
*/

SELECT 'Hello Hi Hello Hi' as txt , splitByChar(' ',txt) as split_char,
splitByString('Hello',txt) as split_string;

SELECT array('a','p','p','l','e') as arr , arrayStringConcat(arr,':') arr_str ,arrayStringConcat(arr) m_arr_str;


