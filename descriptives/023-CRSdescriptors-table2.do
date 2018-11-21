*Creation of Relative Survival datasets
$analysisfolder

forvalues x = 1/4 {
	use $tumor if $agecat==`x', clear
	quietly: $globalstset
	quietly: strs using expectedsurvival, breaks($initial($span)$finish) mergeby(_year sex _age _race) savind(individ`x', replace) savgroup(grouped`x', replace) notables
	use grouped`x', clear
	renames start end n d d_star ns w n_prime y p se_p lo_p p_star r se_r lo_r hi_r cp se_cp lo_cp hi_cp cp_e2 cr_e2 lo_cr_e2 hi_cr_e2 nu, suffix(_`x')
	gen end=end_`x'
	save grouped`x', replace
}

use $tumor, clear
quietly: $globalstset
quietly: strs using expectedsurvival, breaks($initial($span)$finish) mergeby(_year sex _age _race) savind(individ, replace) savgroup(grouped, replace) notables

use grouped, clear
forvalues x = 1/4 {
	merge 1:1 end using grouped`x'
	drop _merge
	}

save CRS$tumor, replace

*Creation of CRS survival table
use CRS$tumor, clear
quietly{
keep if end==1 | end==2 | end==5 | end==10 

forvalues x = 1/4 {
drop n_`x' d_`x' d_star_`x' ns_`x' w_`x' n_prime_`x' y_`x' p_`x' se_p_`x' lo_p_`x' p_star_`x' r_`x' se_r_`x' lo_r_`x' hi_r_`x' cp_`x' se_cp_`x' lo_cp_`x' hi_cp_`x' cp_e2_`x'
}

$tablesfolder
outsheet using "table2.txt", comma replace
$descriptivesfolder
}

$analysisfolder
use $tumor, clear
quietly: $globalstset
sts list, at (2 5 10) by($agecat)

tab agecat
gen agecatwei=.
replace agecatwei=0.0271 if agecat==1
replace agecatwei=0.1682 if agecat==2
replace agecatwei=0.5407 if agecat==3
replace agecatwei=0.2640 if agecat==4

strs using expectedsurvival [iw=agecatwei], standstrata($agecat) $ederer breaks($initial($span)20) mergeby(_year sex _age _race) savind(individ, replace) savgroup(grouped, replace) 



$descriptivesfolder








