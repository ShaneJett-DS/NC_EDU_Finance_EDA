/* U.S. Educational Finance Analysis*/

LIBNAME DS '/home/u62056965/myfolders/data_science';

* Store the file name;
FILENAME states '/home/u62056965/myfolders/data_science/states.csv';

* Import the data file(.csv) to DS library;
PROC IMPORT DATAFILE=states
	DBMS=CSV
	OUT=DS.states;
	GETNAMES=YES;
RUN;

* Query & Filter N.C. Education Financial data;
PROC SQL;
	CREATE TABLE nc_data as
	SELECT *
	FROM DS.states
	WHERE state = 'North Carolina';
QUIT;

* Configure Plot Settings;
ods graphics / reset width=6.4in height=4.8in imagemap;

* Plot NC's Revenue Data;
proc sgplot data=nc_data;
	title 'NC Education Revenue (1992-2016)';
	series x=YEAR y=LOCAL_REVENUE;
	series x=YEAR y=STATE_REVENUE;
	series x=YEAR y=FEDERAL_REVENUE;
	yaxis grid label='Revenue';
run;
title;

* Total Revenue Distribution Statistics;
PROC UNIVARIATE data=nc_data plot;
var TOTAL_REVENUE;
RUN;


* Plot NC's Expenditure Data;
* OTHER_EXPENDITURE was removed due to missing values;
proc sgplot data=nc_data;
	title 'NC Education Expenditure (1992-2016)';
	series x=YEAR y=INSTRUCTION_EXPENDITURE;
	series x=YEAR y=SUPPORT_SERVICES_EXPENDITURE;
	series x=YEAR y=CAPITAL_OUTLAY_EXPENDITURE;
	yaxis grid label='Expenditure';
run;
title;

* Total Expenditure Distribution Statistics;
PROC UNIVARIATE data=nc_data plot;
var TOTAL_EXPENDITURE;
RUN;


* Metadata & Variable Data Types: NC;
PROC CONTENTS data=nc_data;
RUN;

* Summary Statistics: NC;
PROC MEANS data=nc_data;



