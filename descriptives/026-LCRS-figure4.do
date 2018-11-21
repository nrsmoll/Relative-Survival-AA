
$analysisfolder
use `$tumor'overallsurvtrend, clear


regress cr_e2 t if end==$LCRStimeunit, vce(robust)
regress cr_e2 t if end==5, vce(robust)


local fup $LCRStimeunit
twoway (rarea lo_cr_e2 hi_cr_e2 t if end==`fup', color(gs12)) (line cr_e2 t if end==`fup', ylabel(0(.2)1, format(%9.1f)) ///
	xlabel($startingyear(5)$endingyear) legend(off) ///
	saving("grapha", replace) title("2-Year Longitudinal Relative Survival") ytitle("Relative Survival") xtitle("")) ///
	(scatter cr_e2 t if end==`fup',  msymbol(O) msize(small) color(gs2)) 



local fup2 5
 twoway (rarea lo_cr_e2 hi_cr_e2 t if end==`fup2', color(gs12)) ///
	(line cr_e2 t if end==`fup2', ylabel(0(.2)1, format(%9.1f)) xlabel($startingyear(5)$endingyear) legend(order(1 "95% CI" 2 "Relative Survival") ring(0) pos(2) col(1) size(small)) saving("graphb", replace) title("5-Year Longitudinal Relative Survival") ytitle("Relative Survival") xtitle("Years")) ///
	(scatter cr_e2 t if end==`fup2',  msymbol(O) msize(small) color(gs2)) 



graph combine "grapha" "graphb", col(1)
$figuresfolder
graph export "figure4.eps", as(eps) replace
$descriptivesfolder
exit
