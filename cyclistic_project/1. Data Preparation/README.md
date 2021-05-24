# Data preparation on Excel

### Step 1: Download data 
Download data from the website where the case study has attached a link.
[Data Sources](https://divvy-tripdata.s3.amazonaws.com/index.html)
- Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the
datasets are appropriate and will enable you to answer the business questions. The data has been made available by Motivate
International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).
- I determine to use only the data in 2020 since I though it was a appropiate time for this analysis.

### Step 2: Create folder 
Create folders to store data and go through the data analysis process.

### Step 3: Check number of columns and rows of each file
**All the file had 13 columns including**

1. **ride_id**              : ID of every access to the service of bike-share program
2. **rideable_type**        : The type of bicycle used
3. **started_at**           : Service used start date and time
4. **ended_at**             : Service used end date and time
5. **start_station_name**   : Name of the starting station of the service use
6. **start_station_id**     : ID of the starting station of the service use
7. **end_station_name**     : Name of the ending station of the service use
8. **end_station_id**       : ID of the ending station of the service use
9. **start_lat**            : Latitude of started station
10. **start_lng**           : Longitude of started station
11. **end_lat**             : Latitude of ended station
12. **end_lng**             : Longitude of ended station
13. **member_casual**       : Type of user

**The number total rows of all file: 3,541,683 rows**

# Data processing

### Step 1: Set format of started_at and ended_at column
Set date and time format from __mm/dd/yyyy hh:mm__ to __yyyy-mm-dd hh:mm:ss__ \
Example: 8/20/2020 18:08 -> 2020-08-20 18:08:14

### Step 2: Create "ride_length" column
**Split** date and time from column in Step 1
Then we will have new 4 columns
- started_date
- started_time
- ended_date
- ended_time

Let say "ended_time" located in __column G__ and "started_time" located in __column F__\
After that, create new column and take ended_time - started_time (Example: G2-F2)\
Then do the same for all the remaining rows in the column.

Change column format to number with 2 decimal

Now, I've got ride_length column

### Step 3: Create day_of_week column
- Create new column
- Copy started_time column to new column
- Change column format to custom -> type: ddd for abbreviated day name

> I did this in each data source files and I merged them by RStudio later