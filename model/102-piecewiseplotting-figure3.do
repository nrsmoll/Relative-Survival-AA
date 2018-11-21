*Plotting Observed vs Estimated Values for the piecewise model


local y1 $agecat==1
local y2 $agecat==2
local y3 $agecat==3
local y4 $agecat==4

$figuresfolder

twoway (rcap lo_cr_e2 hi_cr_e2 end if `y2', title("{bf:Young Adults", size(huge) color(black)) lcolor(black) xlabel(, labsize(large) labcolor(black)) ylabel(, labsize(large) labcolor(black))) (scatter cr_e2 end if `y2',  mcolor(black)) (line rs_hat end if `y2',  lcolor(black) lpattern(-)), legend(off) yti("") xti("") xla(1(1)5) yla(0(.2)1, format(%12.1fc)) saving(y2, replace)
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y3', title("{bf:Adults}", size(huge) color(black))  lcolor(black) xlabel(, labsize(large) labcolor(black)) ylabel(, labsize(large) labcolor(black))) (scatter cr_e2 end if `y3',  mcolor(black)) (line rs_hat end if `y3',  lcolor(black) lpattern(-  .  -)), legend(off) yti("") xti("") xla(1(1)5) yla(0(.2)1, format(%12.1fc)) saving(y3, replace)
twoway (rcap lo_cr_e2 hi_cr_e2 end if `y4', title("{bf:Elderly}", size(huge) color(black))  lcolor(black) xlabel(, labsize(large) labcolor(black)) ylabel(, labsize(large) labcolor(black))) (scatter cr_e2 end if `y3',  mcolor(black)) (line rs_hat end if `y4',  lcolor(black) lpattern(-..)), legend(off) yti("") xti("") xla(1(1)5) yla(0(.2)1, format(%12.1fc)) saving(y3, replace)

order rs_hat cr_e2 $agecat, first
graph combine "y2" "y3" "y4", row(1) xsize(10) l1title("Cumulative Relative Survival") b1title("Years")
graph export "figure5.eps", replace as(eps)
erase y2.gph
erase y3.gph
erase y4.gph
$modelfolder
