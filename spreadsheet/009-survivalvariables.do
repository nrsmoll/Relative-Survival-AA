*Survival Variables

encode seercausespecificdeathclassifica, gen(seervitalstatus)
encode vitalstatusrecodestudycutoffused, gen(lifestatus)

gen survmo=survivalmonths
la var survmo "Survival Time in Months"
notes survmo: Time of survival from diagnosis to exit (censorship or death). 
notes survmo:  Units are in months.

gen yydx=yearofdiagnosis
la var yydx "Year of Diagnosis"
format yydx %ty

gen modx=mofd(dofy(yydx))
format modx %tm
la var modx "Stata Month of Diagnosis"
notes modx: This is the year of diagnosis formatted to stata's format. 
notes modx: It is the number of months after Jan 1960 until diagnosed
notes modx: 1960 = 0, Jan 1961 = 12, and Jan 1962 = 24 

gen survdatemo=modx+survmo
format survdatemo %tm
la var survdatemo "Study Exit Time"
notes survdatemo: This variable describes the stata format exit date in months after Jan 1960


*dthaz variables - To be used if dthaz is part of analysis
gen v2=.
replace v2=0 if seervitalstatus==1
replace v2=1 if seervitalstatus==2
la var v2 "Lifestatus coding for discrete time survival analysis"
notes v2: This is not routinely used unless there are complex covariate-by-follow-up interactions present in a dataset
