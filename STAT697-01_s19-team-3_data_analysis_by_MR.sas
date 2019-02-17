*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* set relative file import path to current directory (using standard SAS trick);
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that will generate final analytic file;
%include '.\STAT697-01_s19-team-3_data_preparation.sas';

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Can the % of "Education" under "Contribution of deprivation in 
dimension to overall poverty" be used to predict the country's "Multidimensional 
Poverty Index"?

Rationale: A correlation between the percent of education and the MPI will 
determine if education really is a significant agent to combat poverty.

Note: This compares the column "Contribution of deprivation in dimention to 
overall poverty" from 2018 Statistical Annex Table 6 to the column 
"Multidimensional Poverty Index" from 2018 Statistical Annex Table 6.
;


proc sql;
    create table Annex_Table_6_and_4_ as
        select
             coalesce(A.Country,B.Country) as Country
        	 ,adjusted_life_index
       		 ,Inequality_in_education
       		 ,HDI
       		 ,Mean_years_of_schooling_female
			 ,Mean_years_of_schooling_male
			 ,Year_School_Female
			 ,HDI_female
			 ,HDI_male
			 ,Estimated_gross_national_income
        from
            Statistical_2018_Annex_Table_6 as A
            full join
            Statistical_2018_Annex_Table_4 as B
            on A.Country=B.Country
        order by
            Country
    ;
quit;

proc compare
        base=Annex_Table_6_and_4_v1
        compare=Annex_Table_6_and_4_v2
        novalues
    ;
run;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Is there a strong association between "Mean years of schooling" by 
country for both M and F and the "Human Development Index"?

Rationale: A strong assocation would show whether the HDI is appropriately 
measured by the years of schooling and not by national income or life 
expectancy and vice versa.

Note: This compares the column "Mean years of schooling" from 2018 Statistical 
Annex Table 4 to the column "Human Development Index" from 2018 Statistical 
Annex Table 4.
;



proc sql;
    create table Annex_Table_3_and_4_v2 as
        select
             coalesce(A.Country,B.Country) as Country
        	 ,adjusted_life_index
       		 ,Inequality_in_education
       		 ,HDI
       		 ,Mean_years_of_schooling_female
			 ,Mean_years_of_schooling_male
			 ,Year_School_Female
			 ,HDI_female
			 ,HDI_male
			 ,Estimated_gross_national_income
        from
            Statistical_2018_Annex_Table_3 as A
            full join
            Statistical_2018_Annex_Table_4 as B
            on A.Country=B.Country
        order by
            Country
    ;
quit;

proc compare
        base=Annex_Table_3_and_4_v1
        compare=Annex_Table_3_and_4_v2
        novalues
    ;
run;
*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Is there a negative correlation between countries with a greater % of 
"Inequality of Education" and "Human Development Index" and does this 
correlation follow a similarly negative correlation with "Inequality in life 
expectancy"

Rationale: This would help to show whether life expectancy can forecast 
"expected" education and if that "expected" education contributes to the HDI.

Note: This compares the column "Inequality of Education" from 2018 Statistical 
Annex Table 3 to the column "Human Development Index" from 2018 Statistical 
Annex Table 3.
;



proc sql;
    create table Annex_Table_3_and_6_v2 as
        select
             coalesce(A.Country,B.Country) as Country
        	 ,adjusted_life_index
       		 ,Inequality_in_education
       		 ,HDI
       		 ,Mean_years_of_schooling_female
			 ,Mean_years_of_schooling_male
			 ,Year_School_Female
			 ,HDI_female
			 ,HDI_male
			 ,Estimated_gross_national_income
        from
            Statistical_2018_Annex_Table_3 as A
            full join
            Statistical_2018_Annex_Table_6 as B
            on A.Country=B.Country
        order by
            Country
    ;
quit;

proc compare
        base=Annex_Table_3_and_6_v1
        compare=Annex_Table_3_and_6_v2
        novalues
    ;
run;
