$analysisfolder
*Cleaning
quietly {
*MUST BE IMPORTED AS A TAB FILE
insheet using "RACE.txt", tab clear

encode racerecodewhiteblackother, gen(race) 
destring ageadjustedrate, gen(Rate) ignore("~")
drop racerecodewhiteblackother ageadjustedrate
drop if race==4|race==5
replace race=0 if race==6
la define race 0 "White" , modify
gen rate=Rate*10
destring lowerconfidenceinterval, gen(loCI) ignore("~")
destring upperconfidenceinterval, gen(upCI) ignore("~")
destring standarderror, gen(SE) ignore("~")
save esthesioRACE, replace
}


xi:poisson rate i.race if race!=1, irr

save RACE, replace


$incidencefolder
