$analysisfolder
*Cleaning
clear
quietly {
insheet using "YYDX.txt", comma clear

destring yearofdiagnosis, gen(yydx) force
drop if yydx==.
drop yearofdiagnosis
format yydx %ty
gen rate=ageadjustedrate*10
drop ageadjustedrate
gen loCI=lowerconfidenceinterval*10
gen upCI=upperconfidenceinterval*10
drop lowerconfidenceinterval
drop upperconfidenceinterval
rename standarderror SE
}

tsset yydx
tssmooth ma srate=rate, window(4 1 4)
tssmooth ma sloCI=loCI, window(4 1 4)
tssmooth ma supCI=upCI, window(4 1 4)
poisson srate yydx, irr
predict ir, ir
estat gof
fitstat

save YYDX, replace

$nodraw twoway (rarea sloCI supCI yydx, color(gs12) legend(order(1 "95% Confidence Interval" 2 "Smoothed Rate")) xtitle("Year") ytitle("Age-adjusted Rate") xlabel(, valuelabel) saving(yydxincidence, replace)) (line srate yydx, sort) (scatter srate yydx, msymbol(O) msize(small) color(gs2) sort)

$nodraw  $figuresfolder
$nodraw  graph export "smoothYYDX.eps", replace as(eps)
$analysisfolder

$incidencefolder
