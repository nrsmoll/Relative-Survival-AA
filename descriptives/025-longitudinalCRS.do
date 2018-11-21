$analysisfolder

use $tumor, clear
foreach enter of numlist $LCRSearly($period)$LCRSlate {
	local individ individ`enter'
	local grouped grouped`enter'
	local exit = `enter'+$window
	quietly: stset survdatemo, origin(time modx) enter(time `enter') exit(time `exit')  id(patientid) failure(lifestatus==2) scale(12) noshow
	quietly: strs using expectedsurvival, breaks($initial($span)$finish) mergeby(_year sex _age _race) savind(`individ', replace) savgroup(`grouped', replace) notables                           
}

clear
foreach file of numlist $LCRSearly($period)$LCRSlate {
	local filename grouped`file'
	append using grouped`file', generate(a`file')
	
}

gen t=.
forvalues datemo = $LCRSearly($period)$LCRSlate {
	local filename grouped`file'
	local yr = ((`datemo'-$LCRSearly)/$period)+$startingyear
	replace t=`yr' if a`datemo'==1
}

foreach file of numlist $LCRSearly($period)$LCRSlate {
	local filename grouped`file'
	erase "grouped`file'.dta"
	erase "individ`file'.dta"
}

save `$tumor'overallsurvtrend, replace

use `$tumor'overallsurvtrend, clear
list t cr_e2 if end==2
list t cr_e2 if end==5





$descriptivesfolder

