*Piecewise constant hazards model
$analysisfolder
use $tumor, clear
stset survdatemo, origin(time modx) enter(time "$early") exit(time "$late") id(patientid) failure(lifestatus==2) scale(12)
strs using expectedsurvival, breaks($initial($span)$finish) by($agecat) mergeby(_year sex _age _race) savind(`$tumor'individmodel, replace) savgroup(`$tumor'groupedmodel, replace) notables                           

use `$tumor'groupedmodel if end <6, clear
drop if $agecat==1

xi: glm d i.end $agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
est sto a
xi: glm d end##$agecat, fam(poisson) link(rs d_star) lnoffset(y) eform
est sto b
lrtest a

predict xb, xb nooffset 
gen r_hat = exp(-exp(xb))
bysort $agecat (end) : g rs_hat = exp(sum(log(r_hat)))

est restore b
$tablesfolder
estout a using "finalmodel.txt", cells("b ci_l ci_u") eform replace
$analysisfolder

local y1 $agecat==1
local y2 $agecat==2
local y3 $agecat==3
local y4 $agecat==4

$figuresfolder
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y2', title("Young Adults", size(huge) color(black)) lcolor(black) xlabel(, labsize(large) labcolor(black)) ylabel(, labsize(large) labcolor(black))) (scatter cr_e2 end if `y2',  mcolor(black)) (line rs_hat end if `y2',  lcolor(black) lpattern(-)), legend(off) yti("") xti("") xla(1(1)5) yla(0(.2)1, format(%12.1fc)) saving(y2, replace)
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y3', title("Adults", size(huge) color(black))  lcolor(black) xlabel(, labsize(large) labcolor(black)) ylabel(, labsize(large) labcolor(black))) (scatter cr_e2 end if `y3',  mcolor(black)) (line rs_hat end if `y3',  lcolor(black) lpattern(-  .  -)), legend(off) yti("") xti("") xla(1(1)5) yla(0(.2)1, format(%12.1fc)) saving(y3, replace)
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y4', title("Elderly", size(huge) color(black))  lcolor(black) xlabel(, labsize(large) labcolor(black)) ylabel(, labsize(large) labcolor(black))) (scatter cr_e2 end if `y4',  mcolor(black)) (line rs_hat end if `y4',  lcolor(black) lpattern(-..)), legend(off) yti("") xti("") xla(1(1)5) yla(0(.2)1, format(%12.1fc)) saving(y4, replace)

order rs_hat cr_e2 $agecat, first
graph combine "y2" "y3" "y4", row(1) xsize(10) l1title("Cumulative Relative Survival") b1title("Years")
graph export "figure6.eps", replace as(eps)
erase y2.gph
erase y3.gph
erase y4.gph

local table model
postfile `table' agecat year coeff se using `table', replace

forvalues i=1/5 {
  	lincom `i'.end#2.agecat
  	post `table' (2) (1)  (r(estimate))  (r(se))
}

forvalues i=1/5 {
  	lincom `i'.end#3.agecat + 3.agecat
  	post `table' (3) (`i')  (r(estimate))  (r(se))
}

forvalues i=1/5 {
  	lincom `i'.end#4.agecat + 4.agecat
  	post `table' (4) (`i')  (r(estimate)) (r(se))
}
postclose `table'
use `table', clear

gen coefUL=coeff+(1.96*se)
gen coefLL=coeff-(1.96*se)
gen UL=exp(coefUL)
gen LL=exp(coefLL)
gen eHR=exp(coeff)
label define agecat 1 "Children" 2 "Young Adults" 3 "Adults" 4 "Elderly", replace
label val agecat agecat

order year agecat eHR LL UL, first
keep year-UL
sort agecat year 

$tablesfolder
outsheet using "table3.csv", comma replace
twoway  (line eHR year if $agecat==2, lcolor(gs0) lpattern(-) yline(1.0, lcolor(gs6) lpattern(dash)) xtitle(Excess Hazard Ratio)) ///
		(line eHR year if $agecat==3, lcolor(gs2) lpattern("-.") legend(order(1 "Young Adults" 2 "Adults" 3 "Elderly")))  ///
		(line eHR year if $agecat==4, lcolor(gs4) lpattern("--.."))
		
$figuresfolder
graph export "figure7.eps" , as(eps) replace
$modelfolder

