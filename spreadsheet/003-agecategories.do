*Age Categories

gen age=ageatdiagnosis

*Official Categories of the Young Adult Oncology Progress Review Group's Age Criteria
gen agecat=.
replace agecat=1 if age<15
replace agecat=2 if age>=15 & age<=39
replace agecat=3 if age>=40 & age<=64
replace agecat=4 if age>=65
label define agecat 1 "Children" 2 "Young Adults" 3 "Adults" 4 "Elderly"
la val agecat agecat
la var agecat "Adolescent and Young Adult Oncology Progress Review Group Age Classification"
note agecat: The Adolescent and Young Adult Oncology Progress Review Group Age Classification was a concensus ///
	statement made by this group. They define adolescents and young adults which is the age group I term "Young adults". ///
	The adults and elderly category is defined arbitrarily.

gen age6cat=.
replace age6cat=1 if ageatdiagnosis<15
replace age6cat=2 if ageatdiagnosis>=15 & ageatdiagnosis<30
replace age6cat=3 if ageatdiagnosis>=30 & ageatdiagnosis<45
replace age6cat=4 if ageatdiagnosis>=45 & ageatdiagnosis<60
replace age6cat=5 if ageatdiagnosis>=60 & ageatdiagnosis<75
replace age6cat=6 if ageatdiagnosis>=75
label define age6cat 1 "<15yrs" 2 "15-29yrs" 3 "30-44yrs" 4 "45-59yrs" 5 "60-75yrs" 6 ">75yrs"
la val age6cat age6cat
la var age6cat "15 year interval age grouping"

gen age7cat=.
replace age7cat=1 if ageatdiagnosis<3
replace age7cat=2 if ageatdiagnosis>2 & ageatdiagnosis<15
replace age7cat=3 if ageatdiagnosis>=15 & ageatdiagnosis<30
replace age7cat=4 if ageatdiagnosis>=30 & ageatdiagnosis<45
replace age7cat=5 if ageatdiagnosis>=45 & ageatdiagnosis<60
replace age7cat=6 if ageatdiagnosis>=60 & ageatdiagnosis<75
replace age7cat=7 if ageatdiagnosis>=75
label define age7cat 1 "<3yrs" 2 "<15yrs" 3 "15-29yrs" 4 "30-44yrs" 5 "45-59yrs" 6 "60-75yrs" 7 ">75yrs"
la val age7cat age7cat
la var age7cat "15 year interval with segregation for <3 year olds"

gen pedages=.
replace pedages=0 if age<2
replace pedages=1 if age>1 & age<10
replace pedages=2 if age>=10 & age<=19
replace pedages=3 if age>=20
label define pedages 0 "<2yr" 1 "2-9yrs" 2 "10-19yrs" 3 "Adults"
label val pedages pedages
la var pedages "High Pediatric Loading Age Grouping with <2 yr olds segregation"
