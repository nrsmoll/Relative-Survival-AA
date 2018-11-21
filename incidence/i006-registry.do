$analysisfolder
*Cleaning
clearinsheet using "REGISTRY.txt", comma clear
encode seerregistry, gen(registry)
drop seerregistry
rename ageadjustedrate rate
replace rate=rate*10
rename lowerconfidenceinterval loCI
rename upperconfidenceinterval hiCI
replace loCI=loCI*10
replace hiCI=hiCI*10
rename standarderror SE
label define registry  1 "Atlanta (Metro)" 2 "Connecticut" 3 "Detroit (Metro)" 4 "Hawaii" 5 "Iowa" 6 "New Mexico" 7 "San Francisco-Oakland" 8 "Seattle (Puget Sound)" 9 "Utah", modify

*Analysis

xi:poisson rate ib2.registry, irr
save REGISTRY, replace

$nodraw twoway (rcap loCI hiCI registry, $nodraw legend(order(1 "95% Confidence Interval" 2 "Age-Adjusted Rate")) xtitle("Registry") ytitle("Age-adjusted Rate") xlabel(1(1)9, labsize(small) angle(45) valuelabel) saving(registryincidence, replace)) (scatter rate registry,  msymbol(O) msize(small) color(gs2) sort)

	
$nodraw $figuresfolder
$nodraw graph export "smoothREGISTRY.eps", replace as(eps)
$analysisfolder


$incidencefolder
