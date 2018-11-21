$analysisfolder
*Cleaning
quietly {insheet using "AGE.txt", comma clear

encode agerecodewith1yearolds, gen(age19cat) 
encode behaviorcodeicdo31973, gen(behavior)
destring ageadjustedrate, gen(Rate) ignore("~")
destring lowerconfidenceinterval, gen(LoCI) ignore("~")
destring upperconfidenceinterval, gen(UpCI) ignore("~")
destring standarderror, gen(SE) ignore("~")
gen loCI=LoCI*10
gen upCI=UpCI*10
gen rate=Rate*10
drop if behavior!=4

drop agerecodewith1yearolds ageadjustedrate lowerconfidenceinterval standarderror upperconfidenceinterval behaviorcodeicdo31973
drop if age19cat==20
}
*Analysis
tsset age19cat
tssmooth ma srate=rate, window(4 1 4)
tssmooth ma sloCI=loCI, window(4 1 4)
tssmooth ma supCI=upCI, window(4 1 4)
twoway (line srate age19cat, sort color(gs12) legend(order(1 "Smoothed Rate")) title(Figure 1) xtitle("Age Category") ytitle("Age-adjusted Rate") xlabel(1(5)19, valuelabel) saving(ageincidence, replace))  (scatter srate age19cat, msymbol(O) msize(small) color(gs2) sort)

$figuresfolder
graph export "Figure1incidence.eps", replace as(eps)
$analysisfolder
save AGE, replace



$incidencefolder







