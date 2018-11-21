$analysisfolder
*Cleaning

quietly {insheet using "AAincidencesex.txt", tab clear
la def sex 1 "Males" 2 "Females"
la val sex sex 
gen rate=ageadjustedrate*10
drop ageadjustedrate

rename lowerconfidenceinterval LoCI
rename upperconfidenceinterval UpCI
destring standarderror, gen(SE) ignore("~")
gen loCI=LoCI*10
gen upCI=UpCI*10
}

*Analysis
xi:poisson rate i.sex if sex!=0, irr
save AAsex, replace

$incidencefolder
