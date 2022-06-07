create database electricity;


drop table electricity.consumption;


create table electricity.consumption (

	`Date` Date,
	`DateTime` DateTime,
	`Global_reactive_power` Nullable(Float64),
	`Global_active_power` Nullable(Float64),
	`Voltage` Nullable(Float64),
	`Global_intensity` Nullable(Float64),
	`Sub_metering_1` Nullable(Float64),
	`Sub_metering_2` Nullable(Float64),
	`Sub_metering_3` Nullable(Float64))
	ENGINE = MergeTree()
	PARTITION BY toYYYYMMDD(Date)
	ORDER BY (DateTime)
	SETTINGS index_granularity = 8192;

commit;
	
select count() from electricity.consumption;

select * from electricity.consumption limit 5;
