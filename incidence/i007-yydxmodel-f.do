$analysisfolder

insheet using "AAyydxage4catincidence.txt", tab clear

rename age4cat age4cat
label val age4cat age4cat

destring yearofdiagnosis, gen(yydx) force
gen yydx=yearofdiagnosis+1973
format yydx %ty

destring lowerconfidenceinterval, gen(LoCI) ignore("~")
destring upperconfidenceinterval, gen(UpCI) ignore("~")
destring standarderror, gen(SE) ignore("~")
gen rate=ageadjustedrate*10
rename lowerconfidenceinterval loCI
rename upperconfidenceinterval hiCI
replace loCI=loCI*10
replace hiCI=hiCI*10

tsset age4cat yydx

tssmooth ma srate=rate, window(4 1 4)
tssmooth ma sloCI=loCI, window(4 1 4)
tssmooth ma shiCI=hiCI, window(4 1 4)

foreach var of numlist 0 1 2 3 {
poisson rate yydx if age4cat==`var', irr
estat gof
fitstat
}

twoway (line srate yydx if age4cat==0, sort color(gs12) legend(order(2 "Children" 4 "Young Adults" 6 "Adults" 8 "Elderly") row(1) size(small)) xtitle("Years of Diagnosis", size(small)) ytitle("Age-adjusted Rate per 1 million Population", size(small)) xlabel(1973(10)2010) ylabel(0(2)12))  /// 
	(scatter srate yydx if age4cat==0, msymbol(o) msize(small) color(gs2) sort) ///
	(line srate yydx if age4cat==1, sort color(gs12) ) ///
	(scatter srate yydx if age4cat==1, msymbol(X) msize(medium) color(gs2) sort) ///
	(line srate yydx if age4cat==2, sort color(gs12) ) ///
	(scatter srate yydx if age4cat==2, msymbol(D) msize(vsmall) color(gs2) sort) ///
	(line srate yydx if age4cat==3, sort color(gs12) ) ///
	(scatter srate yydx if age4cat==3, msymbol(T) msize(small) color(gs2) sort)
	
$figuresfolder
graph export "figure2incidence.eps", as(eps) replace
$incidencefolder
