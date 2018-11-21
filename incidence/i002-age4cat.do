$analysisfolder
*Cleaning
quietly {
insheet using "AAincidenceage4cat.txt", tab clear

rename age4cat age4cat
label define age4cat 0 "<15 years" 1 "15-39yrs" 2 "40-65yrs" 3 ">65yrs"
label val age4cat age4cat

destring lowerconfidenceinterval, gen(LoCI) ignore("~")
destring upperconfidenceinterval, gen(UpCI) ignore("~")
destring standarderror, gen(SE) ignore("~")
gen rate=ageadjustedrate*10
rename lowerconfidenceinterval loCI
rename upperconfidenceinterval hiCI
replace loCI=loCI*10
replace hiCI=hiCI*10
}

poisson rate ib2.age4cat, irr
save age4cat, replace














$incidencefolder







