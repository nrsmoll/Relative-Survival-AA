*curefraction and figure 3
$analysisfolder

*Modelling
use `$tumor'individmodel if $agecat==2, clear

xi:strsnmix i.$agecat,  distribution(weibull) bhazard(d_star) link(identity) nolog

predict s, surv 
predict h, haz
predict s_uncured, survival uncured
predict h_uncured, hazard uncured
predict cure, cure 
predict median, centile
predict curetime, centile centval(.01)
bysort $agecat: gen first = _n == 1
tabdisp $agecat if first, c(cure median curetime) f(%5.3fc)

predict curetime2, centile centval(.001)
bysort $agecat: gen first2 = _n == 1
tabdisp $agecat if first2, c(cure median curetime2) f(%5.3fc)

sts graph if $agecat==2, tmax(30) title("") plotopts(lcolor(maroon)) ///
	text(.05 2 "Cure Fraction = 7%", size(vsmall)) yline(0.069, lpattern(dash) lwidth(vvthin)) ///
	xtitle("Years") ytitle("Survivor Function") legend(off) ///
	addplot((line s _t if $agecat==2 & _t<=30, sort ylabel(0 .25 .50 .75 1.00)))

$figuresfolder
graph export "figure4.eps", replace as(eps)
$modelfolder



