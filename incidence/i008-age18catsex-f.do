$analysisfolder
*Cleaning

*quietly {insheet using "AAage18catsexincidence.txt", tab clear
la val sex sex 
destring ageadjustedrate, gen(Rate) ignore("~")
destring lowerconfidenceinterval, gen(LoCI) ignore("~")
destring upperconfidenceinterval, gen(UpCI) ignore("~")
destring standarderror, gen(SE) ignore("~")
gen loCI=LoCI*10
gen upCI=UpCI*10
gen rate=Rate*10

rename agerecodewith1yearolds age18cat
la def age18cat 0 "<1yrs" 1 "1-4" 2 "5-9" 3 "10-14" 4 "15-19" 5 "20-24" 6 "25-29" 7 "30-34" ///
	8 "35-39" 9 "40-44" 10 "45-49" 11 "50-54" 12 "55-59" 13 "60-64" 14 "65-69" 15 "70-74" 16 "75-79" ///
	17 "80-84" 18 "85+" 19 "Unknown"
la val age18cat age18cat
drop ageadjustedrate lowerconfidenceinterval standarderror upperconfidenceinterval
drop if age18cat==19

*}
*Analysis
tsset sex age18cat
tssmooth ma Fsrate=rate if sex==1, window(4 1 4)
format Fsrate %12.0f 
tssmooth ma FsloCI=loCI if sex==1, window(4 1 4)
tssmooth ma FsupCI=upCI if sex==1, window(4 1 4)
tssmooth ma Msrate=rate if sex==2, window(4 1 4)
format Msrate %12.0f 
tssmooth ma MsloCI=loCI if sex==2, window(4 1 4)
tssmooth ma MsupCI=upCI if sex==2, window(4 1 4)

twoway (line Fsrate age18cat if sex==1, sort color(gs12) legend(off) ytitle("Age-adjusted Rate per 1 million Population", size(small)) xtitle("") xlabel(1(5)16, valuelabel) saving(ageincidenceA, replace))  /// 
	(scatter Fsrate age18cat  if sex==1, msymbol(o) msize(small) color(gs2) mlabel(Fsrate)  mlabposition(5)  mlabsize(small) sort) ///
	(line Msrate age18cat if sex==2, sort color(gs12) ) ///
	(scatter Msrate age18cat if sex==2, msymbol(X) msize(medium) color(gs2) mlabel(Msrate)  mlabposition(11) mlabsize(small) sort) 

twoway (line Fsrate age18cat if sex==1, sort color(gs12) legend(order(2 "Males Smoothed Rate" 4 "Females Smoothed Rate") size(small)) xtitle("Years of Age at Diagnosis", size(small)) ytitle("Age-adjusted Rate per 1 million Population", size(small)) xlabel(1(5)16, valuelabel) ylabel(0(10)30) saving(ageincidenceB, replace))  /// 
	(scatter Fsrate age18cat  if sex==1, msymbol(o) msize(small) color(gs2) sort) ///
	(line Msrate age18cat if sex==2, sort color(gs12) ) ///
	(scatter Msrate age18cat if sex==2, msymbol(X) msize(medium) color(gs2) sort)
graph combine "ageincidenceA" "ageincidenceB", col(1)

$figuresfolder
graph export "figure1incidence.eps", replace as(eps)
$analysisfolder
save AAage18catsexincidence, replace
$incidencefolder

