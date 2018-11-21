*_______________By Agegroup_____________________________________
$analysisfolder
use $tumor, clear

foreach enter of numlist $LCRSearly($period)$LCRSlate {
	local individ individagecat`enter'
	local grouped groupedagecat`enter'
	local exit = `enter'+$window
	stset survdatemo, origin(time modx) exit(time `exit') enter(time `enter') id(patientid) failure(lifestatus==2) scale(12) noshow
	strs using expectedsurvival, breaks(0(1)10) mergeby(_year sex _age _race) by($agecat) savind(`individ', replace) savgroup(`grouped', replace)  notables                           
}
clear
foreach file of numlist $LCRSearly($period)$LCRSlate {
	local filename groupedCRSagecat`file'
	append using groupedagecat`file', generate(a`file')
}

gen t=.
forvalues datemo = $LCRSearly($period)$LCRSlate {
	local filename groupedCRSagecat`file'
	local yr = ((`datemo'-$LCRSearly)/$period)+$startingyear
	replace t=`yr' if a`datemo'==1
}

foreach file of numlist $LCRSearly($period)$LCRSlate {
	local grouped`file'
	erase "groupedagecat`file'.dta"
	erase "individagecat`file'.dta"
}

save `$tumor'agecatsurvivaltrend, replace
regress cr_e2 t if end==$LCRStimeunit & $agecat==1, vce(robust)
regress cr_e2 t if end==$LCRStimeunit & $agecat==2, vce(robust)
regress cr_e2 t if end==$LCRStimeunit & $agecat==3, vce(robust)
regress cr_e2 t if end==$LCRStimeunit & $agecat==4, vce(robust)

local fup $LCRStimeunit
twoway  (rarea lo_cr_e2 hi_cr_e2 t if $agecat==1 & end==`fup') (line cr_e2 t if $agecat==1 & end==`fup', lpattern(.#.) lcolor(gs0) ylabel(0(.2)1, format(%9.1f)) xlabel(1981(5)2006, nolabels noticks) legend(off) saving("grapha", replace) title("$agecat1", size(huge)) xtitle("") ytitle("")) (scatter cr_e2 t if $agecat==1 & end==`fup', msize(vsmall) msymbol(O))
twoway  (rarea lo_cr_e2 hi_cr_e2 t if $agecat==2 & end==`fup') (line cr_e2 t if $agecat==2 & end==`fup', lpattern(-) lcolor(gs0) ylabel(0(.2)1, nolabels noticks) xlabel(1981(5)2006, nolabels noticks) legend(off) saving("graphb", replace) title("$agecat2", size(huge)) xtitle("") ytitle("")) (scatter cr_e2 t if $agecat==2 & end==`fup', msize(vsmall) msymbol(O))
twoway  (rarea lo_cr_e2 hi_cr_e2 t if $agecat==3 & end==`fup') (line cr_e2 t if $agecat==3 & end==`fup', lpattern(- . -) lcolor(gs0) ylabel(0(.2)1, format(%9.1f)) xlabel(1981(5)2006, valuelabel) legend(off) saving("graphc", replace) ytitle("") title("$agecat3", size(huge)) xtitle("")) (scatter cr_e2 t if $agecat==3 & end==`fup', msize(vsmall) msymbol(O))
twoway  (rarea lo_cr_e2 hi_cr_e2 t if $agecat==4 & end==`fup') (line cr_e2 t if $agecat==4 & end==`fup', lpattern(-..) lcolor(gs0) ylabel(0(.2)1, nolabels noticks) xlabel(1981(5)2006, valuelabel) legend(off) saving("graphd", replace) ytitle("")  title("$agecat4", size(huge)) xtitle("")) (scatter cr_e2 t if $agecat==4 & end==`fup', msize(vsmall) msymbol(O))
graph combine "grapha" "graphb" "graphc" "graphd", title("")

keep if end==5
foreach x of num 1 2 3 4  {
display "Agecat="`x'
list t n d cr_e2 lo_cr_e2 hi_cr_e2 if agecat==`x'
}

graph combine "grapha" "graphb" "graphc" "graphd", title("")

$figuresfolder
graph export "figure5.eps", as(eps) replace
$descriptivesfolder
exit






$descriptivesfolder
