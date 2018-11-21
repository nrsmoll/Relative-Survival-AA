*figure1

$analysisfolder
use $tumor, clear


$globalstset
*Graph Part A
quietly {
sts graph, by($agecat) title("A", ring(0)) ytitle(Overall Survival) xtitle(Years) ///
	risktable(,group(1) rowtitle("$agecat1    ") size(small) ) ///
	risktable(,group(2) rowtitle("$agecat2    ") size(small) ) ///
	risktable(,group(3) rowtitle("$agecat3    ") size(small) title(,at(0) justification(left))) ///
	risktable(,group(4) rowtitle("$agecat4    ")  size(small) title(,at(0) justification(left)))	///
	tmax($finish) xlabel(0 2.5 5(5)$finish) saving(figure1parta, replace) legend(off) ///
	plot1opts(lpattern(.#.)) ///
	plot2opts(lpattern(-)) ///
	plot3opts(lpattern(- . -)) ///
	plot4opts(lpattern(-..)) nodraw
}
*Graph Part B
use CRS$tumor if end<=20, clear
quietly {
graph twoway  (line cr_e2_$children end, nodraw lpattern(.#.) connect(stairstep) title("B", ring(0)) ) ///
	(line cr_e2_$youngadults end, xlabel(0 2.5 5(5)$finish) ytitle("Cumulative Relative Survival") xtitle(Years) connect(stairstep) /// 
	ylabel(0 "0" .25 "0.25" .5 "0.5" .75 "0.75" 1 "1" ) ///
	yline(0.0, lcolor(gs14)) ///
	yline(.25, lcolor(gs14)) ///
	yline(.50, lcolor(gs14)) ///
	yline(.75, lcolor(gs14)) ///
	yline(1.00, lcolor(gs14)) ///
	legend(order(1 "$agecat1" 2 "$agecat2" 3 "$agecat3" 4 "$agecat4")  col(2) pos(6) bmargin(t=4)) lpattern(-) saving(figure1partb, replace)) ///
	(line cr_e2_$adults end, lpattern(-.-) connect(stairstep)) ///
	(line cr_e2_$elderly end, lpattern(-..) connect(stairstep))
}
graph combine "figure1parta" "figure1partb"

$figuresfolder
graph export "figure3survival.eps", as(eps) replace
$descriptivesfolder
